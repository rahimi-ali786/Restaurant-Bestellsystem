<?php
  $servername= "localhost"; 
  $benutzername= "root";
  $passwort="";
  $datenbank="restaurantdb";

  $conn = new mysqli($servername, $benutzername, $passwort, $datenbank);
 
  if($conn->connect_error){
    die("Fehler bei der Verbindung: " .$conn->connect_error);
  }
?>