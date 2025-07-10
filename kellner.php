<?php
  include "config/db.php";
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kellner - Bestellung aufnehmen</title>
    <link rel="stylesheet" href="css/kellner.css">
</head>
<body>
    <div>
        <h1>Kellner - Bestellung aufnehmen</h1>

          <nav class="navigation">
            <ul>
                <li><p>Links:</p></li>
                <li><a href="kellner.php">🔗 Bestellung Aufnehmen</a></li>
                <li><a href="kueche.php">🔗 Kueche</a></li>
                <li><a href="rechnung.php">🔗 Rechnung</a></li>
            </ul>
         </nav>

        <?php
        // Erfolgs- oder Fehlermeldung anzeigen
        if (isset($_GET['success']) && $_GET['success'] == '1') {
            echo "<div class='success-message'>✅ Die Bestellung wurde erfolgreich gesendet!</div>";
        } elseif (isset($_GET['error']) && $_GET['error'] == '1') {
            echo "<div class='error-message'>❌ Fehler beim Senden der Bestellung. Bitte versuchen Sie es erneut.</div>";
        }
        ?>

        <div>
            <h2>Speisekarte</h2>
           <div>
                <form action="config/funktionen.php" method="POST">

                    <div class="tisch-auswahl">
                       <label for="tischSelect">Tisch auswählen:</label>
                       <select id="tischSelect" name="tischID" required>
                           <option value="" disabled selected>--- Bitte Tisch auswählen ---</option>
                           <?php
                           // Alle Tische anzeigen
                           $sql = "SELECT * FROM tische ORDER BY tischNummer";
                           $result = $conn->query($sql);
                           if ($result->num_rows > 0) {
                               while($row = $result->fetch_assoc()) {
                                   $tischID = $row["tischID"];
                                   $tischNummer = $row["tischNummer"];
                                   
                                   // Prüfen ob Tisch offene Rechnung hat
                                   $sql_check = "SELECT * FROM bestellungen b JOIN rechnungen r ON b.bestellungID = r.bestellungID WHERE b.tischID = " . $tischID . " AND r.zahlungsstatus = 'Offen'";
                                   $result_check = $conn->query($sql_check);
                                   
                                   if($result_check->num_rows > 0) {
                                       echo "<option value='" . $tischID . "'>Tisch " . $tischNummer . " (Belegt - weitere Bestellung möglich)</option>";
                                   } else {
                                       echo "<option value='" . $tischID . "'>Tisch " . $tischNummer . " (Frei)</option>";
                                   }
                               }
                           }
                           ?>
                       </select>
                    </div>


                    <div>
                        <label>Gericht auswählen:</label>
                        <select id="gerichtSelect" name="gerichtID" required>
                            <option value="" disabled selected>Bitte Gericht auswählen</option>
                            <?php
                              $sql = "SELECT gerichtID, name, Beschreibung, preis FROM gerichte ORDER BY gerichtID";
                              $gerichte = $conn->query($sql);
                            if ($gerichte->num_rows > 0) {
                                while($gericht = $gerichte->fetch_assoc()) {
                                    echo "<option value='" . $gericht["gerichtID"] . "'>";
                                    echo htmlspecialchars($gericht["gerichtID"]). " - ". htmlspecialchars($gericht["name"]) . " - " . htmlspecialchars($gericht["preis"]) . " €";
                                    echo "</option>";
                                }
                            }
                            ?>
                        </select>
                    </div>
                    
                    <div>
                        <label>Anzahl:</label>
                        <input type='number' min='1' max='20' value='1' name='anzahl' required>
                    </div>
                    
                    <button type='submit' name='Bestellung_hinzufuegen'>Bestellung an Küche senden</button>
               </form>
           </div>
        </div>
    </div>
</body>
</html>
