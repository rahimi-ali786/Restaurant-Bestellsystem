<?php
  include "config/db.php";
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kellner - Bestellung aufnehmen</title>
    <link rel="stylesheet" href="css/kueche.css">
</head>
<body>
     <div>
      <h2>Offene Bestellungen</h2>

        <nav class="navigation">
            <ul>
                <li><p>Links:</p></li>
                <li><a href="kellner.php">🔗 Bestellung Aufnehmen</a></li>
                <li><a href="kueche.php">🔗 Kueche</a></li>
                <li><a href="rechnung.php">🔗 Rechnung</a></li>
            </ul>
         </nav>

        <div>
             <form action="config/funktionen.php" method="POST">

               <?php
                    $sql ="SELECT * FROM tische";
                    $result = $conn->query($sql);
                    if($result->num_rows > 0){
                        while($row=$result->fetch_assoc()){
                            // prüfen ob Bestellungen vorhanden sind
                            $sql2 = "SELECT *FROM bestellung_pro_tisch WHERE tisch = " . $row['tischID'];
                            $result2 = $conn->query($sql2);
                            
                            // nur anzeigen wenn Bestellungen vorhanden sind
                            if($result2->num_rows > 0){
                                echo "<div>";
                                echo "<div class='bestellung-container'>";
                                
                                $bestellungID = null; 

                                echo "<div><p>Tisch " . $row['tischNummer'] . "</p></div>";
                                echo "<div>";
                                while($row2 = $result2->fetch_assoc()){

                                    $bestellungID = $row2['BestellungID'];
                                    
                                    echo "<p>" . $row2['Anzahl'] . " x " . $row2['Gericht'] . "</p>";              
                                }
                                echo "</div>";
                                echo "<button class='fertig-button' type='submit' name='bestellung_fertig' value='" . $bestellungID . "'>Fertig</button>";
                                
                                echo "</div>"; 
                                echo "</div>"; 
                            }
                        }
                    }                  
                ?>
             </form>   
        </div>
     </div>
</body>
</html>