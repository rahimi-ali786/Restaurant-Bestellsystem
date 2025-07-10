<?php
  include "config/db.php";
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rechnungen</title>
    <link rel="stylesheet" href="css/rechnung.css">
</head>
<body>
    <?php
    if(isset($_GET['success']) && $_GET['success'] == 1 && isset($_GET['message'])) {
        $message = htmlspecialchars($_GET['message']);
        echo "<script>alert('" . $message . "');</script>";
    }
    
    if(isset($_GET['error']) && $_GET['error'] == 1) {
        echo "<script>alert('Es ist ein Fehler aufgetreten!');</script>";
    }
    ?>
     <div>
      <h2>Rechnungen</h2>

        <nav class="navigation">
            <ul>
                <li><p>Links:</p></li>
                <li><a href="kellner.php">🔗 Bestellung Aufnehmen</a></li>
                <li><a href="kueche.php">🔗 Kueche</a></li>
                <li><a href="rechnung.php">🔗 Rechnung</a></li>
            </ul>
         </nav>

        <div>
            <?php
            $sql = "SELECT * FROM tische";
            if(isset($_POST['tischNummer'])) {
                $sql = "SELECT * FROM tische where tischNummer = " . htmlspecialchars($_POST['tischNummer']);
            }
            $result = $conn->query($sql);
            if($result->num_rows > 0) {
                $bestellungID = null;
                while($row = $result->fetch_assoc()) {
                    $tischNummer = $row['tischNummer'];
                    $tischID = $row['tischID'];
                    $sql2 = "SELECT * FROM view_rechnung WHERE Tisch = " .$tischNummer. " ORDER BY Tisch";
                    $result2 = $conn->query($sql2);
                    if($result2->num_rows > 0) {
                        echo "<div class='rechnung-container'>";
                        echo "<h3>Tisch " . $tischNummer . "</h3>";
                        echo "<table>";
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Gericht</th>";
                        echo "<th>Menge</th>";
                        echo "<th>Einzelpreis</th>";
                        echo "<th>Gesamtpreis</th>";
                        echo "</tr>";
                        echo "</thead>";
                        $gesamtsumme = 0;
                        while($row2 = $result2->fetch_assoc()) {
                            $gericht = $row2['Gericht'];
                            $anzahl = $row2['Anzahl'];
                            $einzelpreis = $row2['Preis'];
                            $gesamtpreis = $row2['Betrag'];
                            $bestellungID = $row2['BestellungID'];
                            $gesamtsumme = $row2['GesamtsummeProTisch'];
            ?>
                            <tr>
                                <td><?=$gericht;?></td>
                                <td><?=$anzahl;?></td>
                                <td><?=number_format($einzelpreis, 2);?> €</td>
                                <td><?=number_format($gesamtpreis, 2);?> €</td>
                            </tr>
            <?php
                        }
                        echo "<tr class='gesamtsumme'>";
                        echo "<td colspan='3'>Gesamtsumme Tisch " . $tischNummer . ":</td>";
                        echo "<td>" . number_format($gesamtsumme, 2) . " €</td>";
                        echo "</tr>";
                        echo "</table>";
                        echo "<form action='config/funktionen.php' method='POST'>";
                        echo "<input type='hidden' name='bestellungID' value='" . $bestellungID . "'>";
                        echo "<input type='hidden' name='tischNummer' value='" . $tischNummer . "'>";
                        echo "<button type='submit' name='rechnung_drucken' class='drucken-button'>Rechnung drucken 🖨️</button>";
                        echo "</form>";
                        echo "</div>"; 
                    }
                }
            }
            ?>
        </div>
     </div>
</body>
</html>