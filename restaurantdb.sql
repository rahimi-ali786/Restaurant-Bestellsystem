-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: restaurantdb
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bestellpositionen`
--

DROP TABLE IF EXISTS `bestellpositionen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestellpositionen` (
  `positionID` int(11) NOT NULL AUTO_INCREMENT,
  `bestellungID` int(11) NOT NULL,
  `gerichtID` int(11) NOT NULL,
  `anzahl` int(11) NOT NULL,
  PRIMARY KEY (`positionID`),
  KEY `bestellungID` (`bestellungID`),
  KEY `gerichtID` (`gerichtID`),
  CONSTRAINT `bestellpositionen_ibfk_1` FOREIGN KEY (`bestellungID`) REFERENCES `bestellungen` (`bestellungID`),
  CONSTRAINT `bestellpositionen_ibfk_2` FOREIGN KEY (`gerichtID`) REFERENCES `gerichte` (`gerichtID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestellpositionen`
--

LOCK TABLES `bestellpositionen` WRITE;
/*!40000 ALTER TABLE `bestellpositionen` DISABLE KEYS */;
INSERT INTO `bestellpositionen` VALUES (1,1,1,2),(2,1,9,1),(3,2,3,1),(4,2,11,2);
/*!40000 ALTER TABLE `bestellpositionen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `bestellung_pro_tisch`
--

DROP TABLE IF EXISTS `bestellung_pro_tisch`;
/*!50001 DROP VIEW IF EXISTS `bestellung_pro_tisch`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bestellung_pro_tisch` AS SELECT
 1 AS `BestellungID`,
  1 AS `Tisch`,
  1 AS `Gericht`,
  1 AS `Anzahl` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bestellungen`
--

DROP TABLE IF EXISTS `bestellungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestellungen` (
  `bestellungID` int(11) NOT NULL AUTO_INCREMENT,
  `tischID` int(11) NOT NULL,
  `zeitpunkt` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Offen','In Bearbeitung','Fertig','Storniert') DEFAULT 'Offen',
  PRIMARY KEY (`bestellungID`),
  KEY `tischID` (`tischID`),
  CONSTRAINT `bestellungen_ibfk_1` FOREIGN KEY (`tischID`) REFERENCES `tische` (`tischID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestellungen`
--

LOCK TABLES `bestellungen` WRITE;
/*!40000 ALTER TABLE `bestellungen` DISABLE KEYS */;
INSERT INTO `bestellungen` VALUES (1,1,'2025-07-10 19:17:15','Fertig'),(2,2,'2025-07-10 19:17:36','Fertig');
/*!40000 ALTER TABLE `bestellungen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gerichte`
--

DROP TABLE IF EXISTS `gerichte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gerichte` (
  `gerichtID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `Beschreibung` text DEFAULT NULL,
  `preis` decimal(6,2) NOT NULL,
  PRIMARY KEY (`gerichtID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gerichte`
--

LOCK TABLES `gerichte` WRITE;
/*!40000 ALTER TABLE `gerichte` DISABLE KEYS */;
INSERT INTO `gerichte` VALUES (1,'Schnitzel Wiener Art','Paniertes Schnitzel vom Kalb mit Zitrone',14.50),(2,'Sauerbraten','Traditioneller Sauerbraten mit Rotkohl und Knödeln',16.90),(3,'Spaghetti Carbonara','Spaghetti mit Speck, Ei und Parmesan',11.90),(4,'Grillhähnchen','Halbes Hähnchen vom Grill mit Pommes',12.50),(5,'Vegetarische Lasagne','Lasagne mit Gemüse und Béchamel-Sauce',13.90),(6,'Schweinemedaillons','Zarte Schweinemedaillons in Pfefferrahm-Sauce',17.50),(7,'Caesar Salad','Römersalat mit Hähnchenbrust und Caesar-Dressing',9.90),(8,'Rinderfilet','Zartes Rinderfilet mit Kräuterbutter',24.90),(9,'Coca Cola','Erfrischende Cola, 0,33l',2.50),(10,'Apfelsaft','Naturtrüber Apfelsaft, 0,25l',2.80),(11,'Mineralwasser','Stilles oder sprudelndes Wasser, 0,5l',2.20),(12,'Weißbier','Hefeweizen vom Fass, 0,5l',4.20),(13,'Rotwein','Spätburgunder, 0,2l',5.50),(14,'Espresso','Italienischer Espresso',2.00),(15,'Cappuccino','Espresso mit aufgeschäumter Milch',3.20),(16,'Orangensaft','Frisch gepresster Orangensaft, 0,25l',3.50),(17,'Tiramisu','Italienisches Dessert mit Mascarpone und Kaffee',6.50),(18,'Schwarzwälder Kirschtorte','Klassische Torte mit Kirschen und Sahne',5.90),(19,'Vanilleeis','Drei Kugeln Vanilleeis mit Sahne',4.50),(20,'Apfelstrudel','Hausgemachter Strudel mit Vanillesauce',5.20),(21,'Schokoladenmousse','Cremiges Mousse mit dunkler Schokolade',6.20),(22,'Pannacotta','Italienisches Dessert mit Beerensauce',5.80),(23,'Crème Brûlée','Französische Creme mit karamelisiertem Zucker',6.80),(24,'Kaiserschmarrn','Österreichische Spezialität mit Zwetschkenröster',7.50);
/*!40000 ALTER TABLE `gerichte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rechnungen`
--

DROP TABLE IF EXISTS `rechnungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rechnungen` (
  `rechnungID` int(11) NOT NULL AUTO_INCREMENT,
  `bestellungID` int(11) NOT NULL,
  `tischID` int(11) NOT NULL,
  `gericht` varchar(255) NOT NULL,
  `preis` decimal(6,2) NOT NULL,
  `anzahl` int(11) NOT NULL,
  `betrag` decimal(8,2) NOT NULL,
  `zahlungsstatus` enum('Offen','Bezahlt','Storniert') NOT NULL DEFAULT 'Offen',
  `zahlungsdatum` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`rechnungID`),
  KEY `bestellungID` (`bestellungID`),
  CONSTRAINT `rechnungen_ibfk_1` FOREIGN KEY (`bestellungID`) REFERENCES `bestellungen` (`bestellungID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechnungen`
--

LOCK TABLES `rechnungen` WRITE;
/*!40000 ALTER TABLE `rechnungen` DISABLE KEYS */;
INSERT INTO `rechnungen` VALUES (1,1,1,'Schnitzel Wiener Art',14.50,2,29.00,'Bezahlt','2025-07-10 19:21:34'),(2,1,1,'Coca Cola',2.50,1,2.50,'Bezahlt','2025-07-10 19:21:34'),(3,2,2,'Spaghetti Carbonara',11.90,1,11.90,'Bezahlt','2025-07-10 19:21:37'),(4,2,2,'Mineralwasser',2.20,2,4.40,'Bezahlt','2025-07-10 19:21:37');
/*!40000 ALTER TABLE `rechnungen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tische`
--

DROP TABLE IF EXISTS `tische`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tische` (
  `tischID` int(11) NOT NULL AUTO_INCREMENT,
  `tischNummer` int(11) NOT NULL,
  PRIMARY KEY (`tischID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tische`
--

LOCK TABLES `tische` WRITE;
/*!40000 ALTER TABLE `tische` DISABLE KEYS */;
INSERT INTO `tische` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `tische` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_rechnung`
--

DROP TABLE IF EXISTS `view_rechnung`;
/*!50001 DROP VIEW IF EXISTS `view_rechnung`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_rechnung` AS SELECT
 1 AS `RechnungID`,
  1 AS `BestellungID`,
  1 AS `Tisch`,
  1 AS `Gericht`,
  1 AS `Preis`,
  1 AS `Anzahl`,
  1 AS `Betrag`,
  1 AS `Status`,
  1 AS `ZahlungsDatum`,
  1 AS `GesamtsummeProTisch` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `bestellung_pro_tisch`
--

/*!50001 DROP VIEW IF EXISTS `bestellung_pro_tisch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bestellung_pro_tisch` AS select `b`.`bestellungID` AS `BestellungID`,`t`.`tischNummer` AS `Tisch`,`g`.`name` AS `Gericht`,`bp`.`anzahl` AS `Anzahl` from (((`bestellpositionen` `bp` join `bestellungen` `b` on(`bp`.`bestellungID` = `b`.`bestellungID`)) join `tische` `t` on(`b`.`tischID` = `t`.`tischID`)) join `gerichte` `g` on(`bp`.`gerichtID` = `g`.`gerichtID`)) where `b`.`status` = 'Offen' order by `t`.`tischNummer` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_rechnung`
--

/*!50001 DROP VIEW IF EXISTS `view_rechnung`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_rechnung` AS select `r`.`rechnungID` AS `RechnungID`,`r`.`bestellungID` AS `BestellungID`,`t`.`tischNummer` AS `Tisch`,`r`.`gericht` AS `Gericht`,`r`.`preis` AS `Preis`,`r`.`anzahl` AS `Anzahl`,`r`.`betrag` AS `Betrag`,`r`.`zahlungsstatus` AS `Status`,`r`.`zahlungsdatum` AS `ZahlungsDatum`,(select sum(`r2`.`betrag`) from (`rechnungen` `r2` join `bestellungen` `b2` on(`r2`.`bestellungID` = `b2`.`bestellungID`)) where `b2`.`tischID` = `b`.`tischID` and `r2`.`zahlungsstatus` = 'Offen') AS `GesamtsummeProTisch` from ((`rechnungen` `r` join `bestellungen` `b` on(`r`.`bestellungID` = `b`.`bestellungID`)) join `tische` `t` on(`b`.`tischID` = `t`.`tischID`)) where `r`.`zahlungsstatus` = 'Offen' order by `t`.`tischNummer`,`r`.`bestellungID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-10 21:28:33
