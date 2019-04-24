-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: librarydb.c7xooysbfjhv.us-east-2.rds.amazonaws.com    Database: librarydb
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Book` (
  `ISBN` char(13) NOT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `Author` varchar(30) DEFAULT NULL,
  `Genre` enum('Fantasy','Westerns','Romance','Thriller','Mystery','Dystopia') DEFAULT NULL,
  `Copies` int(11) NOT NULL DEFAULT '0',
  `ActiveCopies` int(11) NOT NULL DEFAULT '0',
  `CoverImage` text,
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES ('9780133970777','Fundamentals of Database Syste','Ramez Elmasri; Shamkant B. Nav','',1,1,'9780133970777-us.jpg'),('978014017739','Of Mice and Men','John Steinbeck',NULL,0,0,'covers/ofmiceandmen.jpg'),('978014303943','The Grapes of Wrath','John Steinbeck',NULL,0,0,'51zdzn8cO3L._SX323_BO1204203200_.jpg'),('978074327356','The Great Gatsby','F. Scott Fitzgerald','Fantasy',5,1,'covers/thegreatgatsby_PhVdPQF.jpg'),('9781986167727','Adventures of Huckleberry Finn','Mark Twain','Fantasy',12,4,'covers/Huckleberry_Finn_xQat5f0.jpg');
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookCopy`
--

DROP TABLE IF EXISTS `BookCopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `BookCopy` (
  `ItemID` int(11) NOT NULL,
  `ISBN` char(13) DEFAULT NULL,
  `CheckedOut` tinyint(1) NOT NULL DEFAULT '0',
  `IsHeld` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  UNIQUE KEY `ItemID_UNIQUE` (`ItemID`),
  KEY `ISBN_idx` (`ISBN`),
  CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Item_ID` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookCopy`
--

LOCK TABLES `BookCopy` WRITE;
/*!40000 ALTER TABLE `BookCopy` DISABLE KEYS */;
INSERT INTO `BookCopy` VALUES (1,'9781986167727',1,0),(2,'9781986167727',1,0),(3,'9781986167727',1,0),(4,'9781986167727',1,0),(5,'9781986167727',1,0),(6,'9781986167727',0,1),(7,'9781986167727',0,1),(8,'9781986167727',1,0),(9,'9781986167727',0,0),(10,'9781986167727',0,0),(11,'9781986167727',0,0),(12,'978074327356',0,1),(30,'978074327356',0,1),(200,'978074327356',0,1),(201,'9780133970777',0,0),(222,'9781986167727',0,0),(1000,'978074327356',0,1);
/*!40000 ALTER TABLE `BookCopy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `BookCopy_AFTER_INSERT` AFTER INSERT ON `BookCopy` FOR EACH ROW BEGIN
	IF(new.ISBN != '' AND new.ISBN IS NOT NULL) THEN
		SELECT A.Copies INTO @copies FROM Book A WHERE A.ISBN = new.ISBN;
        SET @copies = @copies + 1;
        UPDATE Book A SET A.Copies = @copies WHERE A.ISBN = new.ISBN;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `BookCopy_AFTER_UPDATE` AFTER UPDATE ON `BookCopy` FOR EACH ROW BEGIN
	SET @copies = (SELECT COUNT(*) FROM BookCopy WHERE ISBN = new.ISBN);
	UPDATE Book SET Copies = @copies WHERE ISBN = new.ISBN;
    
    SET @Activecopies = (SELECT COUNT(*) FROM BookCopy WHERE ISBN = new.ISBN AND CheckedOut = '0' AND IsHeld = '0');
	UPDATE Book SET ActiveCopies = @Activecopies WHERE ISBN = new.ISBN;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CheckIn`
--

DROP TABLE IF EXISTS `CheckIn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CheckIn` (
  `CheckInID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `DateCheckedIn` date NOT NULL,
  UNIQUE KEY `CheckInID_UNIQUE` (`CheckInID`),
  KEY `DATE` (`DateCheckedIn`),
  KEY `ItemID` (`ItemID`),
  KEY `User_ID_Num_idx` (`userID`),
  CONSTRAINT `ItemID` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`itemid`) ON UPDATE CASCADE,
  CONSTRAINT `User_ID_Num` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckIn`
--

LOCK TABLES `CheckIn` WRITE;
/*!40000 ALTER TABLE `CheckIn` DISABLE KEYS */;
INSERT INTO `CheckIn` VALUES (1,5,12,'2019-04-14'),(2,12,5,'1998-03-28'),(3,5,12,'1998-03-28'),(4,5,12,'1998-03-28'),(5,5,12,'1998-03-28'),(6,5,12,'1998-03-28'),(7,5,12,'2019-04-14'),(8,25,15,'2019-04-20'),(9,9,17,'2019-04-20');
/*!40000 ALTER TABLE `CheckIn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Checkin_AFTER_TRIGGER` AFTER INSERT ON `CheckIn` FOR EACH ROW BEGIN
    CALL full_check_in(new.ItemID, new.userID, new.DateCheckedIn);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CheckOut`
--

DROP TABLE IF EXISTS `CheckOut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CheckOut` (
  `TransactionID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `CheckOutDate` date NOT NULL,
  `DueDate` date NOT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE KEY `TransactionID_UNIQUE` (`TransactionID`),
  KEY `CheckOutUser_idx` (`userID`),
  KEY `CheckOutItem_idx` (`itemID`),
  CONSTRAINT `CheckOutItem` FOREIGN KEY (`itemID`) REFERENCES `Item` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CheckOutUser` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckOut`
--

LOCK TABLES `CheckOut` WRITE;
/*!40000 ALTER TABLE `CheckOut` DISABLE KEYS */;
INSERT INTO `CheckOut` VALUES (1,12,1,'1998-03-28','1998-03-29'),(2,11,2,'1998-03-28','1998-03-29'),(3,3,3,'1998-03-28','1998-03-29'),(4,12,4,'1998-03-28','1998-03-29'),(5,12,8,'1998-03-28','1998-03-29'),(6,12,5,'1998-03-28','1998-03-29'),(7,12,5,'1998-03-28','1998-03-28'),(8,12,5,'1998-03-28','1998-03-28'),(9,12,5,'1998-03-28','1998-03-28'),(10,12,5,'1998-03-28','1998-03-28'),(11,12,5,'1998-03-28','1998-03-29'),(12,11,5,'1998-03-28','1998-03-29'),(13,15,25,'2019-04-18','2019-04-19'),(14,17,9,'2019-04-18','2019-04-19');
/*!40000 ALTER TABLE `CheckOut` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `fines_before_insert` BEFORE INSERT ON `CheckOut` FOR EACH ROW BEGIN
    CALL check_fines(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_CheckedOut_before_checkOut` BEFORE INSERT ON `CheckOut` FOR EACH ROW BEGIN
    CALL check_if_checkedOut(new.itemID,new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_holds_before_insert2` BEFORE INSERT ON `CheckOut` FOR EACH ROW BEGIN
    CALL check_checkout_holds(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Checkout_AFTER_TRIGGER` AFTER INSERT ON `CheckOut` FOR EACH ROW BEGIN
    CALL full_check_out(new.ItemID, new.userID, new.CheckOutDate, new.DueDate);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Check_holds_before_update` BEFORE UPDATE ON `CheckOut` FOR EACH ROW BEGIN
    CALL check_checkout_holds(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CopiesBorrowed`
--

DROP TABLE IF EXISTS `CopiesBorrowed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CopiesBorrowed` (
  `userID` int(11) NOT NULL,
  `Copies_Borrowed` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userID_UNIQUE` (`userID`),
  CONSTRAINT `CopiesBorrowedID` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CopiesBorrowed`
--

LOCK TABLES `CopiesBorrowed` WRITE;
/*!40000 ALTER TABLE `CopiesBorrowed` DISABLE KEYS */;
INSERT INTO `CopiesBorrowed` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,2),(12,10),(13,0),(14,0),(15,0),(16,1),(17,0);
/*!40000 ALTER TABLE `CopiesBorrowed` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Check_holds_before_update1` BEFORE UPDATE ON `CopiesBorrowed` FOR EACH ROW BEGIN
    CALL check_checkout_holds(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CurrentCheckedOut`
--

DROP TABLE IF EXISTS `CurrentCheckedOut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CurrentCheckedOut` (
  `userID` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `CheckOutDate` date NOT NULL,
  `DueDate` date NOT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `itermID_UNIQUE` (`itemID`),
  KEY `CurrentCheckeduser_idx` (`userID`),
  CONSTRAINT `CurrentCheckeditem` FOREIGN KEY (`itemID`) REFERENCES `Item` (`itemid`),
  CONSTRAINT `CurrentCheckeduser` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CurrentCheckedOut`
--

LOCK TABLES `CurrentCheckedOut` WRITE;
/*!40000 ALTER TABLE `CurrentCheckedOut` DISABLE KEYS */;
INSERT INTO `CurrentCheckedOut` VALUES (12,1,'1998-03-28','1998-03-29'),(11,2,'1998-03-28','1998-03-29'),(12,4,'1998-03-28','1998-03-29'),(11,5,'1998-03-28','1998-03-29'),(12,8,'1998-03-28','1998-03-29');
/*!40000 ALTER TABLE `CurrentCheckedOut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CurrentHolds`
--

DROP TABLE IF EXISTS `CurrentHolds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CurrentHolds` (
  `itemID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `HoldDate` date NOT NULL,
  `HeldUntilDate` date DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `itemID_UNIQUE` (`itemID`),
  KEY `CurrentHolduser_idx` (`userID`),
  CONSTRAINT `CurrentHolditem` FOREIGN KEY (`itemID`) REFERENCES `Item` (`itemid`),
  CONSTRAINT `CurrentHolduser` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CurrentHolds`
--

LOCK TABLES `CurrentHolds` WRITE;
/*!40000 ALTER TABLE `CurrentHolds` DISABLE KEYS */;
INSERT INTO `CurrentHolds` VALUES (6,12,'2019-04-18',NULL),(7,12,'2019-04-18',NULL),(12,16,'2019-04-18',NULL),(23,1,'2019-04-16',NULL),(24,1,'2019-04-17',NULL),(30,1,'2019-04-16',NULL),(200,12,'2019-04-18',NULL),(1000,12,'2019-04-18',NULL),(1001,14,'2019-04-18',NULL),(1002,1,'2019-04-16',NULL),(1003,12,'2019-04-17',NULL),(1004,12,'2019-04-18',NULL);
/*!40000 ALTER TABLE `CurrentHolds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FineTransactions`
--

DROP TABLE IF EXISTS `FineTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `FineTransactions` (
  `userID` int(11) NOT NULL,
  `TransType` enum('PAYMENT','CHARGE') NOT NULL,
  `TransactionDate` date NOT NULL,
  `Amount` decimal(4,2) NOT NULL,
  `CheckOutID` int(11) DEFAULT NULL,
  `TransactionID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`TransactionID`),
  KEY `DATE` (`TransactionDate`),
  KEY `UserID_ft_idx` (`userID`),
  KEY `FineTransactionID_idx` (`CheckOutID`),
  CONSTRAINT `FineTransactionID` FOREIGN KEY (`CheckOutID`) REFERENCES `CheckOut` (`transactionid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UserID_ft` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FineTransactions`
--

LOCK TABLES `FineTransactions` WRITE;
/*!40000 ALTER TABLE `FineTransactions` DISABLE KEYS */;
INSERT INTO `FineTransactions` VALUES (12,'CHARGE','2019-04-14',10.00,6,1),(12,'PAYMENT','2019-04-15',10.00,NULL,3),(12,'CHARGE','2019-04-14',10.00,11,4),(12,'PAYMENT','2019-04-16',10.00,NULL,5),(15,'CHARGE','2019-04-20',10.00,13,6),(15,'PAYMENT','2019-04-18',10.00,NULL,7),(17,'CHARGE','2019-04-20',10.00,14,8),(17,'PAYMENT','2019-04-18',10.00,NULL,9);
/*!40000 ALTER TABLE `FineTransactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_fineLimits_before_insert` BEFORE INSERT ON `FineTransactions` FOR EACH ROW BEGIN
    CALL fines_amount_check(new.userID, new.TransType, new.Amount);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `FineTransactions_AFTER_INSERT` AFTER INSERT ON `FineTransactions` FOR EACH ROW BEGIN
	IF(new.TransType = 'PAYMENT') THEN
		SELECT A.Amount INTO @fines FROM FinesRecord A WHERE A.userID = new.userID;
        SET @fines = @fines - new.Amount;
	    UPDATE FinesRecord A SET A.Amount = @fines WHERE A.userID = new.userID;
    END IF;
    
    IF(new.TransType = 'CHARGE') THEN
		SELECT A.Amount INTO @fines FROM FinesRecord A WHERE A.userID = new.userID;
        SET @fines = @fines + new.Amount;
	    UPDATE FinesRecord A SET A.Amount = @fines WHERE A.userID = new.userID;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FinesRecord`
--

DROP TABLE IF EXISTS `FinesRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `FinesRecord` (
  `userID` int(11) NOT NULL,
  `Amount` decimal(4,2) DEFAULT '0.00',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userID_UNIQUE` (`userID`),
  CONSTRAINT `FinesRecordID` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FinesRecord`
--

LOCK TABLES `FinesRecord` WRITE;
/*!40000 ALTER TABLE `FinesRecord` DISABLE KEYS */;
INSERT INTO `FinesRecord` VALUES (6,0.00),(7,0.00),(8,25.00),(9,0.00),(10,0.00),(11,0.00),(12,0.00),(13,5.00),(14,0.00),(15,0.00),(16,0.00),(17,0.00);
/*!40000 ALTER TABLE `FinesRecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Holds`
--

DROP TABLE IF EXISTS `Holds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Holds` (
  `ItemID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `HoldDate` date NOT NULL,
  `HeldUntilDate` date DEFAULT NULL,
  `HeldTransactionID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`HeldTransactionID`),
  UNIQUE KEY `HeldTransactionID_UNIQUE` (`HeldTransactionID`),
  KEY `DATE` (`HoldDate`),
  KEY `ItmID` (`ItemID`),
  KEY `UsrID_idx` (`userID`),
  CONSTRAINT `ItmID` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UsrID` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Holds`
--

LOCK TABLES `Holds` WRITE;
/*!40000 ALTER TABLE `Holds` DISABLE KEYS */;
INSERT INTO `Holds` VALUES (5,12,'1998-03-28','1998-03-28',49),(5,12,'1998-03-28','1998-03-28',50),(5,12,'1998-03-28','1998-03-28',51),(5,12,'1998-03-28','1998-03-28',52),(30,1,'2019-04-16',NULL,59),(23,1,'2019-04-16',NULL,60),(1002,1,'2019-04-16',NULL,61),(1001,14,'2019-04-18',NULL,62),(24,1,'2019-04-17',NULL,63),(1003,12,'2019-04-17',NULL,64),(200,12,'2019-04-18',NULL,65),(1000,12,'2019-04-18',NULL,66),(1004,12,'2019-04-18',NULL,67),(6,12,'2019-04-18',NULL,68),(7,12,'2019-04-18',NULL,69),(25,15,'2019-04-18',NULL,70),(12,16,'2019-04-18',NULL,71),(9,17,'2019-04-18',NULL,72);
/*!40000 ALTER TABLE `Holds` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_holds_before_insert` BEFORE INSERT ON `Holds` FOR EACH ROW BEGIN
	CALL check_checkout_holds(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_CheckedOut_before_insert` BEFORE INSERT ON `Holds` FOR EACH ROW BEGIN
    CALL check_if_checkedOut(new.ItemID,new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `CheckFines_before_insert` BEFORE INSERT ON `Holds` FOR EACH ROW BEGIN
    CALL check_fines(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `check_holds_before_insert1` BEFORE INSERT ON `Holds` FOR EACH ROW BEGIN
    CALL check_checkout_holds(new.userID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Holds_AFTER_INSERT` AFTER INSERT ON `Holds` FOR EACH ROW BEGIN
	INSERT INTO CurrentHolds VALUES (new.ItemID, new.userID, new.HoldDate, new.HeldUntilDate);
    SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = new.userID;
    SET @copies = @copies + 1;
    UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = new.userID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Item` (
  `itemID` int(11) NOT NULL,
  `ItemType` enum('BOOK','MUSIC','MOVIE') NOT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `itemID_UNIQUE` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (1,'BOOK'),(2,'BOOK'),(3,'BOOK'),(4,'BOOK'),(5,'BOOK'),(6,'BOOK'),(7,'BOOK'),(8,'BOOK'),(9,'BOOK'),(10,'BOOK'),(11,'BOOK'),(12,'BOOK'),(23,'MOVIE'),(24,'MUSIC'),(25,'MUSIC'),(30,'BOOK'),(111,'BOOK'),(200,'BOOK'),(201,'BOOK'),(222,'BOOK'),(555,'BOOK'),(1000,'BOOK'),(1001,'MOVIE'),(1002,'MOVIE'),(1003,'MOVIE'),(1004,'MOVIE');
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Item_AFTER_INSERT` AFTER INSERT ON `Item` FOR EACH ROW BEGIN
	IF(new.ItemType = 'BOOK') THEN
		INSERT INTO BookCopy (ItemID) VALUES (new.itemID);
    END IF;
    
    IF(new.ItemType = 'MUSIC') THEN
		INSERT INTO MusicCopy (ItemID) VALUES (new.itemID);
    END IF;
    
    IF(new.ItemType = 'MOVIE') THEN
		INSERT INTO MovieCopy (ItemID) VALUES (new.itemID);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `Item_AFTER_UPDATE` AFTER UPDATE ON `Item` FOR EACH ROW BEGIN
	IF(new.ItemType = 'BOOK') THEN
		INSERT INTO BookCopy (ItemID) VALUES (new.itemID);
    END IF;
    
    IF(new.ItemType = 'MUSIC') THEN
		INSERT INTO MusicCopy (ItemID) VALUES (new.itemID);
    END IF;
    
    IF(new.ItemType = 'MOVIE') THEN
		INSERT INTO MovieCopy (ItemID) VALUES (new.itemID);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LoginCredentials`
--

DROP TABLE IF EXISTS `LoginCredentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `LoginCredentials` (
  `userID` int(11) NOT NULL,
  `user_password` varchar(32) NOT NULL,
  UNIQUE KEY `userID_UNIQUE` (`userID`),
  KEY `login_to_user_idx` (`userID`),
  CONSTRAINT `login_to_user` FOREIGN KEY (`userID`) REFERENCES `users_customuser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginCredentials`
--

LOCK TABLES `LoginCredentials` WRITE;
/*!40000 ALTER TABLE `LoginCredentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginCredentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Movie` (
  `ISAN` char(24) NOT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `Director` varchar(25) DEFAULT NULL,
  `Rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  `Genre` varchar(15) DEFAULT NULL,
  `Copies` int(11) NOT NULL DEFAULT '0',
  `ActiveCopies` int(11) NOT NULL DEFAULT '0',
  `CoverImage` text,
  PRIMARY KEY (`ISAN`),
  UNIQUE KEY `ISAN_UNIQUE` (`ISAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movie`
--

LOCK TABLES `Movie` WRITE;
/*!40000 ALTER TABLE `Movie` DISABLE KEYS */;
INSERT INTO `Movie` VALUES ('0000-0000-F33E-0000-1-0','Avengers: Infinity War','Anthony Russo',NULL,NULL,0,0,'covers/avengers.jpg'),('0000-0000-F66F-0000-1-0','Shrek','Andrew Adamson','PG','Animation',3,0,'covers/shrekdvdcover.jpg'),('555','Star Wars: The Last Jedi','Rian Johnson','PG-13','Action',2,0,'covers/starwars.jpg');
/*!40000 ALTER TABLE `Movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieCopy`
--

DROP TABLE IF EXISTS `MovieCopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `MovieCopy` (
  `ItemID` int(11) NOT NULL,
  `ISAN` char(24) DEFAULT NULL,
  `CheckedOut` tinyint(1) NOT NULL DEFAULT '0',
  `IsHeld` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  UNIQUE KEY `ItemID_UNIQUE` (`ItemID`),
  KEY `MovieCopyISAN_idx` (`ISAN`),
  CONSTRAINT `MovieCopyISAN` FOREIGN KEY (`ISAN`) REFERENCES `Movie` (`isan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MovieCopyItemID` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieCopy`
--

LOCK TABLES `MovieCopy` WRITE;
/*!40000 ALTER TABLE `MovieCopy` DISABLE KEYS */;
INSERT INTO `MovieCopy` VALUES (23,'555',0,1),(1001,'555',0,1),(1002,'0000-0000-F66F-0000-1-0',0,1),(1003,'0000-0000-F66F-0000-1-0',0,1),(1004,'0000-0000-F66F-0000-1-0',0,1);
/*!40000 ALTER TABLE `MovieCopy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `MovieCopy_AFTER_INSERT` AFTER INSERT ON `MovieCopy` FOR EACH ROW BEGIN
	IF(new.ISAN != '' AND new.ISAN IS NOT NULL) THEN
		SELECT A.Copies INTO @copies FROM Movie A WHERE A.ISAN = new.ISAN;
        SET @copies = @copies + 1;
        UPDATE Movie A SET A.Copies = @copies WHERE A.ISAN = new.ISAN;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `MovieCopy_AFTER_UPDATE` AFTER UPDATE ON `MovieCopy` FOR EACH ROW BEGIN
	SET @copies = (SELECT COUNT(*) FROM MovieCopy WHERE ISAN = new.ISAN);
	UPDATE Movie SET Copies = @copies WHERE ISAN = new.ISAN;
    
    SET @Activecopies = (SELECT COUNT(*) FROM MovieCopy WHERE ISAN = new.ISAN AND CheckedOut = '0' AND IsHeld = '0');
	UPDATE Movie SET ActiveCopies = @Activecopies WHERE ISAN = new.ISAN;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MusicCopy`
--

DROP TABLE IF EXISTS `MusicCopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `MusicCopy` (
  `ItemID` int(11) NOT NULL,
  `ISMN` char(13) DEFAULT NULL,
  `CheckedOut` tinyint(1) NOT NULL DEFAULT '0',
  `IsHeld` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  UNIQUE KEY `ItemID_UNIQUE` (`ItemID`),
  KEY `ISMN_idx` (`ISMN`),
  CONSTRAINT `ISMN` FOREIGN KEY (`ISMN`) REFERENCES `SheetMusic` (`ismn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Item_IDNum` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`itemid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MusicCopy`
--

LOCK TABLES `MusicCopy` WRITE;
/*!40000 ALTER TABLE `MusicCopy` DISABLE KEYS */;
INSERT INTO `MusicCopy` VALUES (24,'1234',0,1),(25,'1234',0,0);
/*!40000 ALTER TABLE `MusicCopy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `MusicCopy_AFTER_INSERT` AFTER INSERT ON `MusicCopy` FOR EACH ROW BEGIN
	IF(new.ISMN != '' AND new.ISMN IS NOT NULL) THEN
		SELECT A.Copies INTO @copies FROM SheetMusic A WHERE A.ISMN = new.ISMN;
        SET @copies = @copies + 1;
        UPDATE SheetMusic A SET A.Copies = @copies WHERE A.ISMN = new.ISMN;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `MusicCopy_AFTER_UPDATE` AFTER UPDATE ON `MusicCopy` FOR EACH ROW BEGIN
	SET @copies = (SELECT COUNT(*) FROM MusicCopy WHERE ISMN = new.ISMN);
	UPDATE SheetMusic SET Copies = @copies WHERE ISMN = new.ISMN;
    
    SET @Activecopies = (SELECT COUNT(*) FROM MusicCopy WHERE ISMN = new.ISMN AND CheckedOut = '0' AND IsHeld = '0');
	UPDATE SheetMusic SET ActiveCopies = @Activecopies WHERE ISMN = new.ISMN;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SheetMusic`
--

DROP TABLE IF EXISTS `SheetMusic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SheetMusic` (
  `ISMN` char(13) NOT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `Composer` varchar(25) DEFAULT NULL,
  `Genre` varchar(15) DEFAULT NULL,
  `Copies` int(11) NOT NULL DEFAULT '0',
  `ActiveCopies` int(11) NOT NULL DEFAULT '0',
  `CoverImage` text,
  PRIMARY KEY (`ISMN`),
  UNIQUE KEY `ISMN_UNIQUE` (`ISMN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SheetMusic`
--

LOCK TABLES `SheetMusic` WRITE;
/*!40000 ALTER TABLE `SheetMusic` DISABLE KEYS */;
INSERT INTO `SheetMusic` VALUES ('1234','Ave Maria No. 15','Daniel Knaggs','Secular',2,1,'covers/music_default.png');
/*!40000 ALTER TABLE `SheetMusic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'ADMIN'),(2,'FACULTY'),(4,'LIBRARIAN'),(3,'STUDENT');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add auth group',7,'add_authgroup'),(26,'Can change auth group',7,'change_authgroup'),(27,'Can delete auth group',7,'delete_authgroup'),(28,'Can view auth group',7,'view_authgroup'),(29,'Can add auth group permissions',8,'add_authgrouppermissions'),(30,'Can change auth group permissions',8,'change_authgrouppermissions'),(31,'Can delete auth group permissions',8,'delete_authgrouppermissions'),(32,'Can view auth group permissions',8,'view_authgrouppermissions'),(33,'Can add auth permission',9,'add_authpermission'),(34,'Can change auth permission',9,'change_authpermission'),(35,'Can delete auth permission',9,'delete_authpermission'),(36,'Can view auth permission',9,'view_authpermission'),(37,'Can add book',10,'add_book'),(38,'Can change book',10,'change_book'),(39,'Can delete book',10,'delete_book'),(40,'Can view book',10,'view_book'),(41,'Can add checkin',11,'add_checkin'),(42,'Can change checkin',11,'change_checkin'),(43,'Can delete checkin',11,'delete_checkin'),(44,'Can view checkin',11,'view_checkin'),(45,'Can add checkout',12,'add_checkout'),(46,'Can change checkout',12,'change_checkout'),(47,'Can delete checkout',12,'delete_checkout'),(48,'Can view checkout',12,'view_checkout'),(49,'Can add django admin log',13,'add_djangoadminlog'),(50,'Can change django admin log',13,'change_djangoadminlog'),(51,'Can delete django admin log',13,'delete_djangoadminlog'),(52,'Can view django admin log',13,'view_djangoadminlog'),(53,'Can add django content type',14,'add_djangocontenttype'),(54,'Can change django content type',14,'change_djangocontenttype'),(55,'Can delete django content type',14,'delete_djangocontenttype'),(56,'Can view django content type',14,'view_djangocontenttype'),(57,'Can add django migrations',15,'add_djangomigrations'),(58,'Can change django migrations',15,'change_djangomigrations'),(59,'Can delete django migrations',15,'delete_djangomigrations'),(60,'Can view django migrations',15,'view_djangomigrations'),(61,'Can add django session',16,'add_djangosession'),(62,'Can change django session',16,'change_djangosession'),(63,'Can delete django session',16,'delete_djangosession'),(64,'Can view django session',16,'view_djangosession'),(65,'Can add finetransactions',17,'add_finetransactions'),(66,'Can change finetransactions',17,'change_finetransactions'),(67,'Can delete finetransactions',17,'delete_finetransactions'),(68,'Can view finetransactions',17,'view_finetransactions'),(69,'Can add holds',18,'add_holds'),(70,'Can change holds',18,'change_holds'),(71,'Can delete holds',18,'delete_holds'),(72,'Can view holds',18,'view_holds'),(73,'Can add movie',19,'add_movie'),(74,'Can change movie',19,'change_movie'),(75,'Can delete movie',19,'delete_movie'),(76,'Can view movie',19,'view_movie'),(77,'Can add roles',20,'add_roles'),(78,'Can change roles',20,'change_roles'),(79,'Can delete roles',20,'delete_roles'),(80,'Can view roles',20,'view_roles'),(81,'Can add sheetmusic',21,'add_sheetmusic'),(82,'Can change sheetmusic',21,'change_sheetmusic'),(83,'Can delete sheetmusic',21,'delete_sheetmusic'),(84,'Can view sheetmusic',21,'view_sheetmusic'),(85,'Can add users customuser',22,'add_userscustomuser'),(86,'Can change users customuser',22,'change_userscustomuser'),(87,'Can delete users customuser',22,'delete_userscustomuser'),(88,'Can view users customuser',22,'view_userscustomuser'),(89,'Can add users customuser groups',23,'add_userscustomusergroups'),(90,'Can change users customuser groups',23,'change_userscustomusergroups'),(91,'Can delete users customuser groups',23,'delete_userscustomusergroups'),(92,'Can view users customuser groups',23,'view_userscustomusergroups'),(93,'Can add users customuser user permissions',24,'add_userscustomuseruserpermissions'),(94,'Can change users customuser user permissions',24,'change_userscustomuseruserpermissions'),(95,'Can delete users customuser user permissions',24,'delete_userscustomuseruserpermissions'),(96,'Can view users customuser user permissions',24,'view_userscustomuseruserpermissions'),(97,'Can add copiesborrowed',25,'add_copiesborrowed'),(98,'Can change copiesborrowed',25,'change_copiesborrowed'),(99,'Can delete copiesborrowed',25,'delete_copiesborrowed'),(100,'Can view copiesborrowed',25,'view_copiesborrowed'),(101,'Can add logincredentials',26,'add_logincredentials'),(102,'Can change logincredentials',26,'change_logincredentials'),(103,'Can delete logincredentials',26,'delete_logincredentials'),(104,'Can view logincredentials',26,'view_logincredentials'),(105,'Can add finesrecord',27,'add_finesrecord'),(106,'Can change finesrecord',27,'change_finesrecord'),(107,'Can delete finesrecord',27,'delete_finesrecord'),(108,'Can view finesrecord',27,'view_finesrecord'),(109,'Can add user',28,'add_user'),(110,'Can change user',28,'change_user'),(111,'Can delete user',28,'delete_user'),(112,'Can view user',28,'view_user'),(113,'Can add moviecopy',29,'add_moviecopy'),(114,'Can change moviecopy',29,'change_moviecopy'),(115,'Can delete moviecopy',29,'delete_moviecopy'),(116,'Can view moviecopy',29,'view_moviecopy'),(117,'Can add item',30,'add_item'),(118,'Can change item',30,'change_item'),(119,'Can delete item',30,'delete_item'),(120,'Can view item',30,'view_item'),(121,'Can add bookcopy',31,'add_bookcopy'),(122,'Can change bookcopy',31,'change_bookcopy'),(123,'Can delete bookcopy',31,'delete_bookcopy'),(124,'Can view bookcopy',31,'view_bookcopy'),(125,'Can add musiccopy',32,'add_musiccopy'),(126,'Can change musiccopy',32,'change_musiccopy'),(127,'Can delete musiccopy',32,'delete_musiccopy'),(128,'Can view musiccopy',32,'view_musiccopy'),(129,'Can add currentcheckedout',33,'add_currentcheckedout'),(130,'Can change currentcheckedout',33,'change_currentcheckedout'),(131,'Can delete currentcheckedout',33,'delete_currentcheckedout'),(132,'Can view currentcheckedout',33,'view_currentcheckedout'),(133,'Can add currentholds',34,'add_currentholds'),(134,'Can change currentholds',34,'change_currentholds'),(135,'Can delete currentholds',34,'delete_currentholds'),(136,'Can view currentholds',34,'view_currentholds');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-04-06 19:42:59.317966','2','',1,'[{\"added\": {}}]',6,1),(2,'2019-04-06 20:03:38.593323','1','ADMIN',1,'[{\"added\": {}}]',3,1),(3,'2019-04-06 20:03:54.382343','2','FACULTY',1,'[{\"added\": {}}]',3,1),(4,'2019-04-06 20:04:00.169310','3','STUDENT',1,'[{\"added\": {}}]',3,1),(5,'2019-04-06 20:04:06.678313','4','LIBRARIAN',1,'[{\"added\": {}}]',3,1),(6,'2019-04-06 20:04:57.818440','1','jordon.k.garza@gmail.com',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(7,'2019-04-06 20:05:02.797308','1','jordon.k.garza@gmail.com',2,'[]',6,1),(8,'2019-04-06 20:05:16.474347','6','jason@yahoo.com',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(9,'2019-04-06 20:05:39.736330','6','jason@yahoo.com',2,'[]',6,1),(10,'2019-04-06 20:05:52.037012','5','alex@gmail.com',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(11,'2019-04-06 20:09:54.088308','7','elena',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(12,'2019-04-11 04:33:39.279536','9781986167727','Book object (9781986167727)',1,'[{\"added\": {}}]',10,1),(13,'2019-04-11 04:35:28.249645','222','Bookcopy object (222)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(14,'2019-04-11 04:37:25.605873','111','Item object (111)',2,'[{\"changed\": {\"fields\": [\"itemtype\"]}}]',30,1),(15,'2019-04-11 04:37:33.229290','555','Item object (555)',2,'[{\"changed\": {\"fields\": [\"itemtype\"]}}]',30,1),(16,'2019-04-11 04:39:36.719157','1','Item object (1)',1,'[{\"added\": {}}]',30,1),(17,'2019-04-11 04:39:57.365996','1','Bookcopy object (1)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(18,'2019-04-11 04:42:56.669650','2','Item object (2)',1,'[{\"added\": {}}]',30,1),(19,'2019-04-11 04:43:12.017677','2','Bookcopy object (2)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(20,'2019-04-11 04:47:59.680247','3','Item object (3)',1,'[{\"added\": {}}]',30,1),(21,'2019-04-11 04:48:18.435663','3','Bookcopy object (3)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(22,'2019-04-11 04:51:04.545190','4','Item object (4)',1,'[{\"added\": {}}]',30,1),(23,'2019-04-11 04:51:30.242195','4','Bookcopy object (4)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(24,'2019-04-11 05:19:59.749587','5','Item object (5)',1,'[{\"added\": {}}]',30,1),(25,'2019-04-11 05:20:20.126585','5','Bookcopy object (5)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(26,'2019-04-11 05:24:44.821719','6','Item object (6)',1,'[{\"added\": {}}]',30,1),(27,'2019-04-11 05:25:00.828893','6','Bookcopy object (6)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(28,'2019-04-11 05:27:13.543689','7','Item object (7)',1,'[{\"added\": {}}]',30,1),(29,'2019-04-11 05:27:28.049881','7','Bookcopy object (7)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(30,'2019-04-11 05:31:24.982398','8','Item object (8)',1,'[{\"added\": {}}]',30,1),(31,'2019-04-11 05:31:43.308860','8','Bookcopy object (8)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(32,'2019-04-11 05:33:04.112889','9','Item object (9)',1,'[{\"added\": {}}]',30,1),(33,'2019-04-11 05:33:19.469898','9','Bookcopy object (9)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(34,'2019-04-11 05:36:50.837593','10','Item object (10)',1,'[{\"added\": {}}]',30,1),(35,'2019-04-11 05:37:05.134714','10','Bookcopy object (10)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(36,'2019-04-11 05:38:50.807135','11','Item object (11)',1,'[{\"added\": {}}]',30,1),(37,'2019-04-11 05:39:06.501838','11','Bookcopy object (11)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(38,'2019-04-11 05:48:13.200980','11','Bookcopy object (11)',2,'[{\"changed\": {\"fields\": [\"checkedout\"]}}]',31,1),(39,'2019-04-11 05:49:23.279950','11','Bookcopy object (11)',2,'[{\"changed\": {\"fields\": [\"checkedout\"]}}]',31,1),(40,'2019-04-11 22:05:55.086375','23','Item object (23)',1,'[{\"added\": {}}]',30,1),(41,'2019-04-11 22:07:53.282731','555','Star Wars: The Last Jedi',1,'[{\"added\": {}}]',19,1),(42,'2019-04-11 22:08:05.223495','23','Moviecopy object (23)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(43,'2019-04-11 22:09:08.597745','24','Item object (24)',1,'[{\"added\": {}}]',30,1),(44,'2019-04-11 22:10:25.892969','1234','Ave Maria No. 15',1,'[{\"added\": {}}]',21,1),(45,'2019-04-11 22:10:45.318990','24','Musiccopy object (24)',2,'[{\"changed\": {\"fields\": [\"ismn\"]}}]',32,1),(46,'2019-04-11 22:10:57.226397','25','Item object (25)',1,'[{\"added\": {}}]',30,1),(47,'2019-04-11 22:11:12.333496','25','Musiccopy object (25)',2,'[{\"changed\": {\"fields\": [\"ismn\"]}}]',32,1),(48,'2019-04-11 23:41:16.970475','978074327356','The Great Gatsby',1,'[{\"added\": {}}]',10,1),(49,'2019-04-12 05:06:49.535437','0000-0000-F66F-0000-1-0','Shrek',1,'[{\"added\": {}}]',19,1),(50,'2019-04-14 05:43:49.615154','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(51,'2019-04-14 05:57:09.326969','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(52,'2019-04-14 05:58:01.636883','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(53,'2019-04-14 05:58:25.656574','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(54,'2019-04-14 06:02:43.824143','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(55,'2019-04-14 06:03:20.760733','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(56,'2019-04-14 06:21:31.108146','9781986167727','Adventures of Huckleberry Finn',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(57,'2019-04-14 22:54:12.330826','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',10,1),(58,'2019-04-14 22:55:40.827889','30','Item object (30)',2,'[{\"changed\": {\"fields\": [\"itemid\"]}}]',30,1),(59,'2019-04-14 22:56:03.005094','200','Item object (200)',2,'[{\"changed\": {\"fields\": [\"itemid\"]}}]',30,1),(60,'2019-04-14 22:56:29.133028','1000','Item object (1000)',1,'[{\"added\": {}}]',30,1),(61,'2019-04-14 22:56:56.134407','1000','Bookcopy object (1000)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(62,'2019-04-14 22:57:11.852947','200','Bookcopy object (200)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(63,'2019-04-14 22:57:20.577571','30','Bookcopy object (30)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(64,'2019-04-15 03:27:01.827867','555','Star Wars: The Last Jedi',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',19,1),(65,'2019-04-15 03:27:17.063082','555','Star Wars: The Last Jedi',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',19,1),(66,'2019-04-15 03:27:32.157903','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',19,1),(67,'2019-04-15 03:37:37.693240','1001','Item object (1001)',1,'[{\"added\": {}}]',30,1),(68,'2019-04-15 03:38:07.119560','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(69,'2019-04-15 03:38:24.397205','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(70,'2019-04-15 03:38:53.820390','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(71,'2019-04-15 03:39:08.456493','555','Star Wars: The Last Jedi',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(72,'2019-04-15 03:39:16.637541','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(73,'2019-04-15 03:39:50.778097','0000-0000-F66F-0000-1-0','Shrek',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(74,'2019-04-15 03:40:16.096663','1002','Item object (1002)',1,'[{\"added\": {}}]',30,1),(75,'2019-04-15 03:40:36.688972','1003','Item object (1003)',1,'[{\"added\": {}}]',30,1),(76,'2019-04-15 03:40:55.396341','1004','Item object (1004)',1,'[{\"added\": {}}]',30,1),(77,'2019-04-15 03:42:32.411254','1001','Moviecopy object (1001)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(78,'2019-04-15 03:42:46.266312','1002','Moviecopy object (1002)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(79,'2019-04-15 03:42:55.742525','1003','Moviecopy object (1003)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(80,'2019-04-15 03:43:15.099213','1003','Moviecopy object (1003)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(81,'2019-04-15 03:43:22.263531','1004','Moviecopy object (1004)',2,'[{\"changed\": {\"fields\": [\"isan\"]}}]',29,1),(82,'2019-04-15 03:43:56.923050','555','Star Wars: The Last Jedi',2,'[{\"changed\": {\"fields\": [\"copies\"]}}]',19,1),(83,'2019-04-16 04:25:09.492615','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(84,'2019-04-16 04:25:24.256049','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(85,'2019-04-16 04:30:12.864654','9781986167727','Adventures of Huckleberry Finn',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(86,'2019-04-16 04:30:37.841439','9781986167727','Adventures of Huckleberry Finn',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(87,'2019-04-16 04:48:52.229588','9781986167727','Adventures of Huckleberry Finn',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(88,'2019-04-16 04:49:43.532566','978074327356','The Great Gatsby',2,'[{\"changed\": {\"fields\": [\"cover_image\"]}}]',10,1),(89,'2019-04-18 21:43:10.012860','15','janeDoe',1,'[{\"added\": {}}]',6,1),(90,'2019-04-18 21:43:25.499160','15','janeDoe',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(91,'2019-04-18 21:44:10.667291','15','janeDoe',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\"]}}]',6,1),(92,'2019-04-18 22:01:08.135403','12','Item object (12)',1,'[{\"added\": {}}]',30,1),(93,'2019-04-18 22:01:56.850748','12','Bookcopy object (12)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(94,'2019-04-18 22:49:15.500121','9780133970777','9780133970777',1,'[{\"added\": {}}]',10,1),(95,'2019-04-18 22:54:35.067843','201','Item object (201)',1,'[{\"added\": {}}]',30,1),(96,'2019-04-18 22:55:19.233770','201','Bookcopy object (201)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(97,'2019-04-18 22:55:37.210942','201','Bookcopy object (201)',2,'[{\"changed\": {\"fields\": [\"isbn\"]}}]',31,1),(98,'2019-04-18 22:56:57.403689','17','JohnDoe',1,'[{\"added\": {}}]',6,1),(99,'2019-04-18 22:57:12.175375','17','JohnDoe',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',6,1),(100,'2019-04-19 20:47:35.733099','9781986167727','9781986167727',2,'[{\"changed\": {\"fields\": [\"genre\"]}}]',10,1),(101,'2019-04-19 20:47:45.451735','9781986167727','9781986167727',2,'[]',10,1),(102,'2019-04-19 20:48:34.003952','978074327356','978074327356',2,'[{\"changed\": {\"fields\": [\"genre\"]}}]',10,1),(103,'2019-04-19 20:53:21.059578','9780133970777','9780133970777',2,'[{\"changed\": {\"fields\": [\"genre\"]}}]',10,1),(104,'2019-04-19 20:58:23.488012','9780133970777','9780133970777',2,'[{\"changed\": {\"fields\": [\"genre\"]}}]',10,1),(105,'2019-04-22 01:21:54.757176','978014303943','978014303943',1,'[{\"added\": {}}]',10,1),(106,'2019-04-22 02:04:05.250817','0000-0000-F33E-0000-1-0','0000-0000-F33E-0000-1-0',1,'[{\"added\": {}}]',19,1),(107,'2019-04-22 02:11:33.019472','978014017739','978014017739',1,'[{\"added\": {}}]',10,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(7,'users','authgroup'),(8,'users','authgrouppermissions'),(9,'users','authpermission'),(10,'users','book'),(31,'users','bookcopy'),(11,'users','checkin'),(12,'users','checkout'),(25,'users','copiesborrowed'),(33,'users','currentcheckedout'),(34,'users','currentholds'),(6,'users','customuser'),(13,'users','djangoadminlog'),(14,'users','djangocontenttype'),(15,'users','djangomigrations'),(16,'users','djangosession'),(27,'users','finesrecord'),(17,'users','finetransactions'),(18,'users','holds'),(30,'users','item'),(26,'users','logincredentials'),(19,'users','movie'),(29,'users','moviecopy'),(32,'users','musiccopy'),(20,'users','roles'),(21,'users','sheetmusic'),(28,'users','user'),(22,'users','userscustomuser'),(23,'users','userscustomusergroups'),(24,'users','userscustomuseruserpermissions');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-04-06 19:28:13.034300'),(2,'contenttypes','0002_remove_content_type_name','2019-04-06 19:28:13.573341'),(3,'auth','0001_initial','2019-04-06 19:28:14.773299'),(4,'auth','0002_alter_permission_name_max_length','2019-04-06 19:28:15.093300'),(5,'auth','0003_alter_user_email_max_length','2019-04-06 19:28:15.313297'),(6,'auth','0004_alter_user_username_opts','2019-04-06 19:28:15.522652'),(7,'auth','0005_alter_user_last_login_null','2019-04-06 19:28:15.752298'),(8,'auth','0006_require_contenttypes_0002','2019-04-06 19:28:15.986633'),(9,'auth','0007_alter_validators_add_error_messages','2019-04-06 19:28:16.212959'),(10,'auth','0008_alter_user_username_max_length','2019-04-06 19:28:16.453298'),(11,'auth','0009_alter_user_last_name_max_length','2019-04-06 19:28:16.665322'),(12,'users','0001_initial','2019-04-06 19:28:18.402460'),(13,'admin','0001_initial','2019-04-06 19:28:19.252311'),(14,'admin','0002_logentry_remove_auto_add','2019-04-06 19:28:19.482662'),(15,'admin','0003_logentry_add_action_flag_choices','2019-04-06 19:28:19.712624'),(16,'sessions','0001_initial','2019-04-06 19:28:20.222512'),(17,'users','0002_remove_customuser_user_type','2019-04-06 19:48:55.038313'),(18,'users','0003_authgroup_authgrouppermissions_authpermission_book_bookcopy_checkin_checkout_copiesborrowed_djangoad','2019-04-06 21:01:15.669972'),(19,'auth','0010_alter_group_name_max_length','2019-04-08 03:34:52.338693'),(20,'auth','0011_update_proxy_permissions','2019-04-08 03:34:52.588502'),(21,'users','0004_auto_20190409_2317','2019-04-10 04:46:19.279719'),(22,'users','0005_auto_20190409_2318','2019-04-10 04:46:20.010316');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1vz71tsf14z1gbx7i0l4te76pd07wxsf','NjI1YjhmNWVhMGExNWFjNmE4ZjY3NDVlMTg0MmI3MzkxNTczY2Y1Zjp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGZjODQ2MjBkYThjNTM5OWQ3NjFlMGE4ZmY2Y2M3Y2M1NDE1NGU0ZCJ9','2019-05-02 20:57:25.539425'),('6bgm142wczsvfpws1er3ak5ikw0mnpt4','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-03 20:16:16.133136'),('6i3xubgc75iavo6thtuia92yx5yy2hf9','NTE3MzY0ZDQyZjI4YWM5M2QwZGY2ZDIwNDRjZmE5ZDM0MzMyM2IzZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjc4YTQ2NWM5ZWNlN2U4ZjcxMmQxYmExYWM4ZDg3ZGFiMWM5MzU4In0=','2019-04-23 19:07:39.192367'),('8chtl7tsabmmgy6za6g5wrtj4p5qlqhu','NWM0NDAwOGU5MTllNGUzNDNiMzMxOWJlMzE5YzUxNmQ1YTlhOGEyYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MDBjMmJkM2UzMGRmNTJjNDhhYzk3ZmNmZmRhYzExZTJhODYzY2RlIn0=','2019-05-08 02:38:09.057321'),('b6efsk8hhtst1ynb11xp1x4jdl4g3cdk','MWU3MDZmZGYyYWRjMDhiNGIwN2NiY2RjZDY1NTMwN2ZkYzNkZWZhNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZTA3Y2RhZDA4NGE4ZTYyNDFlMjhiMTNjYTE5ZjI0YzI2MTk1ZTBmIn0=','2019-05-06 02:03:44.509015'),('c0xgsl89o0f7gl6sc2jkc7vir28p1ign','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-04 23:56:22.260134'),('dty4k5l6m042orva7k96sgabydbfl0o7','NTE3MzY0ZDQyZjI4YWM5M2QwZGY2ZDIwNDRjZmE5ZDM0MzMyM2IzZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjc4YTQ2NWM5ZWNlN2U4ZjcxMmQxYmExYWM4ZDg3ZGFiMWM5MzU4In0=','2019-04-23 19:07:39.186383'),('dyfzrnm0jhuadbzbr82029ucdxa5di21','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-04 23:30:13.376144'),('fc1amduh5lzam1xnw8gjpm2vvurj502x','MzUxMDg3ODU5ZDhmNzNhNzZjMTMyODM0OGZjMWNiMTdjYzExMDdlYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NmZlNDNmYzFiMDkzODMxNDNkOTljOTNhMGUwM2FkZjlhZjM3YzVhIn0=','2019-05-08 02:34:15.888444'),('fkm4e91tucu79q6i5l5jammn6z0na7qm','MDY3MWJjOWJjMmIyZDIyYWQzMDNhNGY1YWI1MTE3OThjZTUyMjUyMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTgzMjQ0NDY3M2JiMjNjZjJjZGU0YTNmZGMyNDhiZDAzYzIxYmNkIn0=','2019-05-02 00:46:58.940706'),('hgs52ypg1g6nyxurwr73c3d6hy8b3c2h','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-04 22:54:28.059107'),('imld69tocw2a9p3hn094nvaps8ec5001','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-02 23:00:50.913806'),('iq9acs0ybvytdjfglesoo2kfrxvo13mo','ODcyMjYzMDk1MjA0NWFmNTE4NDI5ZTMxOWFkZWE3ZDY1MzZjNmMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwZDU5MDkzZmYyMWFmMGJiMDcxYzA4MmUxNWE5N2ZhZWUwNjhiMjE3In0=','2019-04-30 22:25:36.212793'),('itcd57qsthq3jwsy28py8hcddz9xxajb','NjA0YjZiNzQ0NTZkNmVjMjkyMDlmODI3OGJlZTU3ZTAxNTI5OGFmMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlN2FiMmYwYzhhMzViMjU3ZDE2ZmI3NjI0ODJiYWNjYmQzODZhYWRjIn0=','2019-05-02 04:53:33.305650'),('jih64e6k02vppm1hxhgvtdyntpmytyv8','NGVlZWZlYzE2NTFiMjU0ZmVkNzJmZGMyZDY2MmI3OTQyMzQyYmYyZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTRiMmQzODYzZjM2MDdhOTRhMGYzZTYyYWNjOTVjN2UyMDc1OTA4In0=','2019-05-08 02:34:17.417706'),('ndu24lzrdydl7hhygrxsm8c1wmo6tk0k','ODQ1OTlhYzk3ZTM1MTVkNjdkOGMwMTcwZDE5Y2RjN2JkMmUxZjYwMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0MjEyNTBkZTFiYmNjODYwMDI4MDgwMjM4MzQ2MGNiZmQ3OTNiNWM4In0=','2019-04-25 18:28:35.764961'),('nxbt7irk2jaoayp0we57u59uvvfuprn5','ZDI1MmQ0MDdkMjI3YTllMjcwMGUyMWRmZTgwODdhODE0ZjRjYmUxMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNTlmNjc4M2IyYTQ3ODEyNzFhNWQ1MmRiMmU3OGNhNjQwY2M1YzE0In0=','2019-04-24 03:43:09.345258'),('on82jazlayb04eqgwb8ttr7evv9uahj6','MWU3MDZmZGYyYWRjMDhiNGIwN2NiY2RjZDY1NTMwN2ZkYzNkZWZhNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZTA3Y2RhZDA4NGE4ZTYyNDFlMjhiMTNjYTE5ZjI0YzI2MTk1ZTBmIn0=','2019-05-06 01:58:55.440395'),('r881ej5wfdt6va33cghthvkzmd65v4rd','NjI1YjhmNWVhMGExNWFjNmE4ZjY3NDVlMTg0MmI3MzkxNTczY2Y1Zjp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGZjODQ2MjBkYThjNTM5OWQ3NjFlMGE4ZmY2Y2M3Y2M1NDE1NGU0ZCJ9','2019-05-02 20:27:02.087525'),('s0ljeh26x3c2kkzisx863v5mppwzyvp0','OTNiZTFkNzllYmQzN2YyMWVmNmMwOTFjOGM1OGQ2NmIxMzMxNTA3Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNGJlY2FlMDBjOTY4NzRhMzI3NjNjNzJjMzZiYmM0YWI4YzBkZTFlIn0=','2019-05-08 02:36:00.917039'),('sr7q6yarqgyiv5a720ri78ji01i2r4qu','YTg4ODRiNzc4ZTFjYjQ4MTU2MGZiMmIwMDA4MjBiZTliZmRlZjk3MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMjkxNjdjZjI2MzgxZDM5Y2M5OGM4Y2MzMjE0N2EwN2EyMmZhYjA4In0=','2019-04-30 19:57:57.492774'),('svye739ob9gkjmv7rn3r0rcejxz7776t','OTE1MzRkY2UyZTAzZGYzNjRjMmFjNjg2Njc4NmIwMjU3ZjQ0MWU0ZTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhMDQ3NjMyYWI4NjM5ZTQyMjI2NmE3NTdjMTgwMWUzOWM2NDM0MGU0In0=','2019-05-02 21:13:03.089668'),('uoxq0qnnr6ourgibceygixqh4j1myvne','NGVlZWZlYzE2NTFiMjU0ZmVkNzJmZGMyZDY2MmI3OTQyMzQyYmYyZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTRiMmQzODYzZjM2MDdhOTRhMGYzZTYyYWNjOTVjN2UyMDc1OTA4In0=','2019-05-08 02:34:16.429157'),('wuz5k6bxbpmpjbfoue7pd3binq20auml','NjE5NDllYzUwZmZlOGNjZTllYjNiMmVjYWY3ODVmYjEwYzdiZDA0NTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmIxOWYxYTllOTA4ZGVmY2JkMjE3ZWIxMmY1NWZlNTBiMzYzMDgzZCJ9','2019-04-29 16:59:36.008889'),('xamno8bk0jwpxzm38vbhfhptnroidoxm','MDUwZmE0MTk0NTNkMjcxNjQyZTIwMmYwYTU1NTIwYmVmYWMxMjgyYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZWUxNDhiYTJhOTVkNjRhNWNiZWQ3MTI1ZGY0ZDM3ZDNiY2EwMGZkIn0=','2019-05-06 01:27:59.437190'),('xiwjfwoshl2jh7u7hrup1d6lyeitko0g','NmI2NjBhYTU5NTAzMjllZjliZTgwMjg2ZDlkMTljOTE4NGJmYWZlZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZDAyYmVjZmFhODU1MjM3YjM3ZDNiOTc3NTEwYWE1NTRhYjE2NGFiIn0=','2019-05-02 22:50:27.315343');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_table`
--

DROP TABLE IF EXISTS `new_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `new_table` (
  `itemID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `HoldDate` date NOT NULL,
  `HeldUntilDate` date NOT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `itemID_UNIQUE` (`itemID`),
  KEY `CurrentHolduser_idx` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_table`
--

LOCK TABLES `new_table` WRITE;
/*!40000 ALTER TABLE `new_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser`
--

DROP TABLE IF EXISTS `users_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_customuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser`
--

LOCK TABLES `users_customuser` WRITE;
/*!40000 ALTER TABLE `users_customuser` DISABLE KEYS */;
INSERT INTO `users_customuser` VALUES (1,'pbkdf2_sha256$150000$gxebdIgChiKR$yEm5rbUEYAGtHGBMIoxexBp3UueF1shRitFp88z/Aqc=','2019-04-24 02:38:09.053229',1,'Jordon','Jordon','Garza','jordon.k.garza@gmail.com',1,1,'2019-04-06 19:40:04.000000'),(2,'pbkdf2_sha256$120000$2dFlTIM3Sevc$fAAuupXjT5EKJy0qjGfMqhG3bhK7beJkrY/0Cb8Oa6w=',NULL,0,'josh','Josh','Henderson','josh@gmail.com',0,1,'2019-04-06 19:42:59.049679'),(3,'pbkdf2_sha256$120000$P6HmgDpGzn8L$7GQXxRES+J+IOGcwkyLAKm9xDDz+U99bIAHZoehztIE=',NULL,0,'jonothan','Jonothan','Castillo','jonothan@gmail.com',0,1,'2019-04-06 19:50:36.359331'),(4,'pbkdf2_sha256$120000$I2WqDWTRcDX1$9P8EYnDeFpwlTK0ubCYXW+2JP8OUkCeL7PPryS15CCQ=',NULL,0,'gabriel','Gabriel','Dan','gabriel@gmail.com',0,1,'2019-04-06 19:53:56.632299'),(5,'pbkdf2_sha256$120000$JHnfQl3yhrwb$YSVbUlJzwYxt7FYnfAhWyOG/YmzWbi5pbNTA/Lo/GM4=','2019-04-12 01:04:34.273471',0,'alex','Alex','G','alex@gmail.com',0,1,'2019-04-06 19:56:01.000000'),(6,'pbkdf2_sha256$120000$599pRvFTNyT9$IMXMzbYotqrPANC5t206iM97ft+ols5mazWACJhR3ls=','2019-04-18 21:35:31.600538',0,'jason','jason','garza','jason@yahoo.com',0,1,'2019-04-06 20:01:05.000000'),(7,'pbkdf2_sha256$120000$QgcAyZqGpCMP$0RCIBoMYxkpCA4IR/hZoJtY/NZrsc4bAEkjgBnWBwu4=','2019-04-18 22:58:31.496309',0,'elena','elena','fisher','elena@gmail.com',0,1,'2019-04-06 20:09:23.000000'),(8,'pbkdf2_sha256$120000$Fk23RQSQOwoE$XV5nhbLxE7yrvVenL/lKEeEDN3UTm/5si4fS0NFUnv0=',NULL,0,'billy','','','',0,1,'2019-04-10 04:48:26.469578'),(9,'pbkdf2_sha256$120000$m00D6bd5jtyz$YQIm11udhI/QT9lMmqbKvAYGehSy+SNBQ5QO4uuA6pg=',NULL,0,'sonya','sonya','blade','sonya@gmail.com',0,1,'2019-04-10 05:32:25.046457'),(10,'pbkdf2_sha256$120000$OZfDoVR265jD$9D99ZyE6S8MX3W7HkVSzLj+vVOP8gs6qt971jQmy7pg=',NULL,0,'Jenny','Jenny','Nicholson','sonya@gmail.com',0,1,'2019-04-10 05:34:27.957145'),(11,'pbkdf2_sha256$120000$A0ZaXMqWIPMn$e43BHhcHliWBMdN/vg6XMagdvp7nTTwbAOjirPD81xc=',NULL,0,'maria','maria','laney','maria@gmail.com',0,1,'2019-04-10 05:39:01.016677'),(12,'pbkdf2_sha256$120000$MXlyNq6EImrv$ocdP+O3qfy8O+ZqnMillUKVApG4O6OzH+8XWH2GTfo8=','2019-04-18 21:36:08.773581',0,'sonic','sonic','hedgehog','sonic@gmail.com',0,1,'2019-04-10 05:43:03.267330'),(13,'pbkdf2_sha256$150000$KjnLf3fXuEYd$w/GjBTcKF9882TFLqyrN5P1BNsIbKC4bTZA8oJTHiYg=','2019-04-15 20:29:07.391301',0,'qwerty','Josh','Lara','Joshualara9@gmail.com',0,1,'2019-04-11 18:43:52.218801'),(14,'pbkdf2_sha256$150000$Q7bcGul6ufWJ$sfrFCOcnFHP2Hs8+Mni5KkWgVbgoKmBjMfm2zZzKwFg=','2019-04-15 16:59:35.942624',0,'tuvan','Tu Van','Nguyen','tnnguyen66@uh.edu',0,1,'2019-04-11 22:36:25.966529'),(15,'pbkdf2_sha256$120000$bnA9A3wwobqf$6ibPSMFNnJeM2aOnNCQU2Mmn6Fisf6fJTMGkAlecbl0=','2019-04-18 21:47:59.810445',0,'janeDoe','Janey','Does','',0,1,'2019-04-18 21:43:09.000000'),(16,'pbkdf2_sha256$120000$cXVnzEh7zwPI$xHdYIc21SfMpibbelLE3pop1srhqdhKhN7wfWztgQEI=','2019-04-18 22:35:58.670593',0,'davidtest','David','Herrera','davidt1@somemail.com',0,1,'2019-04-18 22:35:27.170534'),(17,'pbkdf2_sha256$120000$VJIdYpQCDnAl$vfRR1cTNW8NnB11hKu6G9nz/n4mkKwWWFmcuud1nBoE=','2019-04-18 23:00:18.634788',0,'JohnDoe','John','Doe','',0,1,'2019-04-18 22:56:57.000000');
/*!40000 ALTER TABLE `users_customuser` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Admin`@`%`*/ /*!50003 TRIGGER `users_customuser_AFTER_INSERT` AFTER INSERT ON `users_customuser` FOR EACH ROW BEGIN
	INSERT INTO FinesRecord (userID) VALUES (new.id);
    INSERT INTO CopiesBorrowed (userID) VALUES (new.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users_customuser_groups`
--

DROP TABLE IF EXISTS `users_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_customuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_groups`
--

LOCK TABLES `users_customuser_groups` WRITE;
/*!40000 ALTER TABLE `users_customuser_groups` DISABLE KEYS */;
INSERT INTO `users_customuser_groups` VALUES (1,1,1),(3,5,3),(2,6,2),(4,7,4),(5,12,3),(6,13,3),(7,14,3),(8,15,3),(9,16,3),(10,17,3);
/*!40000 ALTER TABLE `users_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_user_permissions`
--

DROP TABLE IF EXISTS `users_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_customuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_user_permissions`
--

LOCK TABLES `users_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'librarydb'
--

--
-- Dumping routines for database 'librarydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_checkin_holds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `check_checkin_holds`(user_id int)
BEGIN
	SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE ID = user_id;
	IF (@copies = 0) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot check in when you have no copies checked out.';
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_checkout_holds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `check_checkout_holds`(user_id int)
BEGIN
	SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_id;
	SELECT group_id INTO @user_role FROM users_customuser_groups WHERE customuser_id = user_id;
	IF (@copies = 5 AND @user_role = '3') THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot check out more than 5 items at a time';
	END IF;
    
    IF (@copies = 10 AND @user_role = '2') THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot check out more than 10 items at a time';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_fines` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `check_fines`(user_ID int)
BEGIN
	SELECT Amount INTO @amount FROM FinesRecord WHERE userID = user_id;
	IF(@amount > 0) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'User cannot hold or check out an item while they have a fine.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_if_checkedOut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `check_if_checkedOut`(item_ID int, user_ID int)
BEGIN
	SELECT ItemType INTO @itemType FROM Item WHERE itemID = item_ID;
    
	IF (@itemType = 'BOOK') THEN
		SELECT CheckedOut INTO @checkedOut FROM BookCopy WHERE ItemID = item_ID;
        SELECT IsHeld INTO @held FROM BookCopy WHERE ItemID = item_ID;
	END If;
    IF (@itemType = 'MUSIC') THEN
		SELECT CheckedOut INTO @checkedOut FROM MusicCopy WHERE ItemID = item_ID;
        SELECT IsHeld INTO @held FROM MusicCopy WHERE ItemID = item_ID;
	END IF;
	IF (@itemType = 'MOVIE') THEN
		SELECT CheckedOut INTO @checkedOut FROM MovieCopy WHERE ItemID = item_ID;
        SELECT IsHeld INTO @held FROM MovieCopy WHERE ItemID = item_ID;
	END IF;

	IF(@checkedOut = 1) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The Item is currently checked out.';
    END IF;
    
    IF(@held = 1) THEN
		SELECT A.userID INTO @user FROM Holds A WHERE A.ItemID = item_ID AND A.HeldTransactionID = (SELECT MAX(B.HeldTransactionID) FROM Holds B WHERE B.ItemID = item_ID);
        IF(@user != user_ID) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'The Item is currently held by someone else.';
        END IF;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fines_amount_check` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `fines_amount_check`(user_id int, transType enum('PAYMENT', 'CHARGE'), newAmount decimal(4,2) )
BEGIN
	SELECT Amount INTO @amount FROM FinesRecord WHERE userID = user_id;
    IF(transType = 'PAYMENT') THEN
		IF(@amount - newAmount < 0.00) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'You cannot pay more than your total fine, please try again.';
        END IF;
    END IF;
    IF(transType = 'CHARGE') THEN
		IF(@amount + newAmount > 9999.99) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'You cannot cause the fine to be higher than $9999.99, please try again.';
        END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `full_check_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `full_check_in`(item_ID int, user_ID int, dateTurnedIn DATE)
BEGIN
	SELECT ItemType INTO @itemType FROM Item WHERE itemID = item_ID;
    
	IF (@itemType = 'BOOK') THEN
		UPDATE BookCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE BookCopy SET IsHeld = 0 WHERE ItemID = item_ID;
	END If;
    IF (@itemType = 'MUSIC') THEN
		UPDATE MusicCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE MusicCopy SET IsHeld = 0 WHERE ItemID = item_ID;
	END IF;
	IF (@itemType = 'MOVIE') THEN
		UPDATE MovieCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE MovieCopy SET IsHeld = 0 WHERE ItemID = item_ID;
	END IF;
    
    SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_ID;
    SET @copies = @copies - 1;
    UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = user_ID;
    
    SELECT A.DueDate INTO @Due FROM CheckOut A WHERE A.itemID = item_ID AND A.TransactionID = (SELECT MAX(B.TransactionID) FROM CheckOut B WHERE B.itemID = item_ID);
    SELECT A.TransactionID INTO @TransID FROM CheckOut A WHERE A.itemID = item_ID AND A.TransactionID = (SELECT MAX(B.TransactionID) FROM CheckOut B WHERE B.itemID = item_ID);
    IF (dateTurnedIn > @Due) THEN
		INSERT INTO FineTransactions (userID,TRansType,TransactionDate, Amount, CheckOutID) VALUES (user_ID, 'CHARGE', dateTurnedIn, 10.00,  @TransID);
    END IF;
    
    DELETE FROM CurrentCheckedOut WHERE itemID = item_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `full_check_out` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `full_check_out`(item_ID int, user_ID int, checkDate DATE, dueDate DATE)
BEGIN
	SELECT ItemType INTO @itemType FROM Item WHERE itemID = item_ID;
    
	IF (@itemType = 'BOOK') THEN
		UPDATE BookCopy SET CheckedOut = 1 WHERE ItemID = item_ID;
        SELECT IsHeld INTO @isItHeld FROM BookCopy WHERE ItemID = item_ID;
        IF (@isItHeld = 1) THEN
			SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_ID;
			SET @copies = @copies - 1;
			UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = user_ID;
            UPDATE BookCopy SET IsHeld = 0 WHERE ItemID = item_ID;
        END IF;
	END If;
    IF (@itemType = 'MUSIC') THEN
		UPDATE MusicCopy SET CheckedOut = 1 WHERE ItemID = item_ID;
        SELECT IsHeld INTO @isItHeld FROM MusicCopy WHERE ItemID = item_ID;
        IF (@isItHeld = 1) THEN
			SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_ID;
			SET @copies = @copies - 1;
			UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = user_ID;
            UPDATE BookCopy SET IsHeld = 0 WHERE ItemID = item_ID;
         END IF;
	END IF;
	IF (@itemType = 'MOVIE') THEN
		UPDATE MovieCopy SET CheckedOut = 1 WHERE ItemID = item_ID;
        SELECT IsHeld INTO @isItHeld FROM MovieCopy WHERE ItemID = item_ID;
        IF (@isItHeld = 1) THEN
			SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_ID;
			SET @copies = @copies - 1;
			UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = user_ID;
            UPDATE BookCopy SET IsHeld = 0 WHERE ItemID = item_ID;
        END IF;
	END IF;

	SELECT Copies_Borrowed INTO @copies FROM CopiesBorrowed WHERE userID = user_ID;
    SET @copies = @copies + 1;
    UPDATE CopiesBorrowed SET Copies_Borrowed = @copies WHERE userID = user_ID;
    INSERT INTO CurrentCheckedOut VALUES (user_ID, item_ID, checkDate, dueDate);
    DELETE FROM CurrentHolds WHERE itemID = item_ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `full_hold_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `full_hold_insert`(item_ID int, userID int)
BEGIN
	SELECT ItemType INTO @itemType FROM Item WHERE itemID = item_ID;
    
	IF (@itemType = 'BOOK') THEN
		UPDATE BookCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE BookCopy SET IsHeld = 1 WHERE ItemID = item_ID;
	END If;
    IF (@itemType = 'MUSIC') THEN
		UPDATE MusicCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE MusicCopy SET IsHeld = 1 WHERE ItemID = item_ID;
	END IF;
	IF (@itemType = 'MOVIE') THEN
		UPDATE MovieCopy SET CheckedOut = 0 WHERE ItemID = item_ID;
        UPDATE MovieCopy SET IsHeld = 1 WHERE ItemID = item_ID;
	END IF;
    
    SELECT CopiesBorrowed INTO @copies FROM CopiesBorrowed WHERE ID = userID;
    SET @copies = @copies + 1;
    UPDATE CopiesBorrowed SET CopiesBorrowed = @copies WHERE ID = userID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recount_Book_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `recount_Book_copies`(bookNum char)
BEGIN
	SET @booknum = bookNum;
    SET @copies = (SELECT COUNT(*) FROM BookCopy WHERE ISBN = @booknum);
	UPDATE Book SET Copies = @copies WHERE ISBN = @booknum;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recount_Movie_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `recount_Movie_copies`(movieNum int)
BEGIN
	SELECT COUNT(*) INTO @copies FROM MovieCopy WHERE ISAN = movieNum;
	UPDATE Movie A SET A.Copies = @copies WHERE A.ISAN = movieNum;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recount_Music_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Admin`@`%` PROCEDURE `recount_Music_copies`(musicNum int)
BEGIN
	SELECT COUNT(*) INTO @copies FROM MusicCopy WHERE ISMN = musicNum;
	UPDATE SheetMusic A SET A.Copies = @copies WHERE A.ISMN = musicNum;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-23 21:41:53
