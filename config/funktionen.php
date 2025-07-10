<?php
 include "db.php";

 if(isset($_POST['Bestellung_hinzufuegen'])) {
    
     $gerichtID = htmlspecialchars($_POST['gerichtID']);
     $anzahl = htmlspecialchars($_POST['anzahl']);
     $tischID = htmlspecialchars($_POST['tischID']);

     // Prüfen ob bereits eine offene Bestellung für diesen Tisch existiert
     $sql_check = "SELECT b.bestellungID FROM bestellungen b JOIN rechnungen r ON b.bestellungID = r.bestellungID WHERE b.tischID = " . $tischID . " AND r.zahlungsstatus = 'Offen'";
     $result_check = $conn->query($sql_check);
     
     if($result_check->num_rows > 0) {
         // Bestehende offene Bestellung gefunden
         $row_check = $result_check->fetch_assoc();
         $bestellungID = $row_check['bestellungID'];
     } else {
         // Neue Bestellung erstellen
         $sql = $conn->prepare("INSERT INTO bestellungen (tischID) VALUES (?)");
         $sql->bind_param("i", $tischID);
         
         if ($sql->execute()) {
             $bestellungID = $conn->insert_id;
         } else {
             header("location:../kellner.php?error=1");
             exit();
         }
     }
     // Bestellposition hinzufügen
     $sql2 = $conn->prepare("INSERT INTO bestellpositionen (bestellungID, gerichtID, anzahl) VALUES (?, ?, ?)");
     $sql2->bind_param("iii", $bestellungID, $gerichtID, $anzahl);
     
     if ($sql2->execute()) {
         // Preis des Gerichts aus der gerichte-Tabelle holen
         $sql3 = $conn->prepare("SELECT * FROM gerichte WHERE gerichtID = ?");
         $sql3->bind_param("i", $gerichtID);
         $sql3->execute();
         $result3 = $sql3->get_result();
         $row3 = $result3->fetch_assoc();
         $einzelpreis = $row3['preis'];
         $gericht = $row3['name'];

         // Gesamtbetrag berechnen
         $betrag = $anzahl * $einzelpreis;
         
         // Prüfen ob bereits ein Rechnungseintrag für dieses Gericht in dieser Bestellung existiert
         $sql_check_rechnung = $conn->prepare("SELECT rechnungID, anzahl, betrag FROM rechnungen WHERE bestellungID = ? AND gericht = ? LIMIT 1");

         $sql_check_rechnung->bind_param("is", $bestellungID, $gericht);
         $sql_check_rechnung->execute();
         $result_rechnung = $sql_check_rechnung->get_result();
         
         if($result_rechnung->num_rows > 0) {
             // Rechnungseintrag für dieses Gericht existiert bereits - Anzahl und Betrag aktualisieren
             $row_rechnung = $result_rechnung->fetch_assoc();
             $neue_anzahl = $row_rechnung['anzahl'] + $anzahl;
             $neuer_betrag = $neue_anzahl * $einzelpreis;
             $sql4 = $conn->prepare("UPDATE rechnungen SET anzahl = ?, betrag = ? WHERE rechnungID = ?");
             $sql4->bind_param("idi", $neue_anzahl, $neuer_betrag, $row_rechnung['rechnungID']);
         } else {
             // Neuen Rechnungseintrag für dieses Gericht erstellen
             $sql4 = $conn->prepare("INSERT INTO rechnungen (bestellungID, tischID, gericht, preis, anzahl, betrag, zahlungsstatus) VALUES (?, ?, ?, ?, ?, ?, 'Offen')");
             $sql4->bind_param("iisdid", $bestellungID, $tischID, $gericht, $einzelpreis, $anzahl, $betrag);
         }
         
         if ($sql4->execute()) {
             header("location:../kellner.php?success=1");
             exit();
         } else {
             header("location:../kellner.php?error=1");
             exit();
         }
     } else {
         header("location:../kellner.php?error=1");
         exit();
     }

 } elseif(isset($_POST['bestellung_fertig'])){
        $bestellungID = htmlspecialchars($_POST['bestellung_fertig']);
    // SQL-Abfrage zum Markieren der Bestellung als fertig
        $sql = $conn->prepare("UPDATE bestellungen SET status = 'Fertig' WHERE bestellungID = ?");
        $sql->bind_param("i", $bestellungID);
        if($sql->execute()){
            header("location:../kueche.php?success=1");
            exit();
        } else {
            header("location:../kueche.php?error=1");
            exit(); 
        }
    //*************/
    } elseif(isset($_POST['rechnung_drucken'])){
    $bestellungID = htmlspecialchars($_POST['bestellungID']);
    $tischNummer = htmlspecialchars($_POST['tischNummer']);
    
    // Rechnung als bezahlt markieren
    $sql = $conn->prepare("UPDATE rechnungen SET zahlungsstatus = 'Bezahlt', zahlungsdatum = NOW() WHERE bestellungID IN (SELECT bestellungID FROM bestellungen WHERE tischID = ?) AND zahlungsstatus = 'Offen'");
    $sql->bind_param("i", $tischNummer);
    $sql->execute(); 

        header("location:../rechnung.php?success=1&message=Rechnung für Tisch " . $tischNummer . " wurde gedruckt");
        exit();
    
    } else {
        header("location:../kellner.php");
        exit();
    }

    





?>