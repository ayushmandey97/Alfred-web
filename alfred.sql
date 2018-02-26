-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: alfred
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks` (
  `username` varchar(20) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` text,
  `url` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks`
--

LOCK TABLES `bookmarks` WRITE;
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
INSERT INTO `bookmarks` VALUES ('ayushman','What is a Python egg? - Stack Overflow','Join Stack Overflow to learn, share knowledge, and build your career.','https://stackoverflow.com/questions/2051192/what-is-a-python-egg');
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommendations` (
  `image_url` text,
  `prod_url` text,
  `type` varchar(20) DEFAULT NULL,
  `title` text,
  `username` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations`
--

LOCK TABLES `recommendations` WRITE;
/*!40000 ALTER TABLE `recommendations` DISABLE KEYS */;
INSERT INTO `recommendations` VALUES ('https://images-na.ssl-images-amazon.com/images/I/819iVIomwsL._UX522_.jpg','https://www.amazon.in//Fogg-Analog-White-Watch-2017-WH-CK/dp/B01BGPAOX0?_encoding=UTF8&amp;psc=1','amazon','Fogg Analog White Dial Men\'s Watch 2017-WH-CK','eshan'),('https://images-na.ssl-images-amazon.com/images/I/714IteMx%2BUL._UX466_.jpg','https://www.amazon.in//Fogg-Analog-White-Womens-4002-WH/dp/B0168GQ0MG?_encoding=UTF8&amp;psc=1','amazon','Fogg Analog White Dial Women\'s Watch 4002-WH','eshan'),('https://images-na.ssl-images-amazon.com/images/I/71l7dMYXw4L._UX425_.jpg','https://www.amazon.in//Fogg-Analog-Blue-Watch-2038-BL/dp/B075RBD78J?_encoding=UTF8&amp;psc=1','amazon','Fogg Analog Blue Day and Date Men\'s Watch 2038-BL','eshan'),('https://images-na.ssl-images-amazon.com/images/I/71X91F0jnSL._UX342_.jpg','https://www.amazon.in//Fogg-Analog-Black-Watch-2034-BK/dp/B01J7PL1LA?_encoding=UTF8&amp;psc=1','amazon','Fogg Analog Black Day and Date Men\'s Watch 2034-BK','eshan'),('https://images-na.ssl-images-amazon.com/images/I/71X-m4MRMFL._UX342_.jpg','https://www.amazon.in//Espoir-Mens-ESP12457-Analog-Watch/dp/B07417987C?_encoding=UTF8&amp;psc=1','amazon','Espoir Mens ESP12457 Analog Blue Dial Watch','eshan'),('https://images-na.ssl-images-amazon.com/images/I/81503HFczGL._UX425_.jpg','https://www.amazon.in//Fogg-Analog-Grey-Watch-2002-GR/dp/B01AJO2KX6?_encoding=UTF8&amp;psc=1','amazon','Fogg Analog Grey Dial Men\'s Watch 2002-GR','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTc2OTQ3OTkwMF5BMl5BanBnXkFtZTgwNjAwMzkxOTE@._V1_SX300.jpg','http://www.youtube.com/watch?v=UM-Q_zpuJGU','youtube','Comedians in Cars Getting Coffee','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTcwMWVlM2QtMjFhZS00ZGZhLTg1MzMtODYyZWNlNWU5MTZmXkEyXkFqcGdeQXVyODQ1NTk5OQ@@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Chris_Rock:_Tamborine','wiki','Chris Rock: Tamborine','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTI5ODMzOTY4MV5BMl5BanBnXkFtZTcwNzU1MjM0Mw@@._V1_SX300.jpg','https://www.reddit.com/r/all/','reddit','Late Show with David Letterman','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BNDM4OTY0NTAyMF5BMl5BanBnXkFtZTcwNTcxMDQyMQ@@._V1_SX300.jpg','http://www.youtube.com/watch?v=HQGUHwBb4Bw','youtube','Jerry Seinfeld: \'I\'m Telling You for the Last Time\'','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMzIzMjI1N2UtNDE4OS00NzA3LWEwMjItM2ZmMzhjNzIzZTljXkEyXkFqcGdeQXVyMzUxMTU2MTU@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Dave_Chappelle:_Equanimity','wiki','Dave Chappelle: Equanimity','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BM2QyY2JhOWQtOWEwNy00OTVkLThhZjYtZGI3MWJjNWVjNjBmXkEyXkFqcGdeQXVyNTA2NTIzOQ@@._V1_SX300.jpg','https://www.reddit.com/r/all/','reddit','Comedians in Cars Getting Coffee: Single Shot','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BOWExZTg4ZWYtOTQxMi00YWZkLTkxYzgtOTg1MTUxNzNiNDcxL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg','http://www.youtube.com/watch?v=7s4ZLIhSFgo','youtube','A Time to Kill','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTU2MzcyODgyNV5BMl5BanBnXkFtZTcwNTc4MDYwOQ@@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Mud','wiki','Mud','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTMyODY1NTg1N15BMl5BanBnXkFtZTcwMTUyODI4Mg@@._V1_SX300.jpg','http://www.youtube.com/watch?v=LX6kVRsdXW4','youtube','Law Abiding Citizen','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BN2JhZDlmY2MtOWM4Yi00ODNlLWI4NjItOTY4MjEyYzQ0ZGI2XkEyXkFqcGdeQXVyNTQzOTc3MTI@._V1_SX300.jpg','http://www.youtube.com/watch?v=cxpvzmvFHTM','youtube','Killer Joe','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BOTcwMmE5YWItNDkzMi00Yjk2LTk5ZjItMmY5ZDhhNWE0ZWRmXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Runaway_Jury','wiki','Runaway Jury','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTg3NTQ2MDY4OF5BMl5BanBnXkFtZTcwOTAzMjU1MQ@@._V1_SX300.jpg','http://www.youtube.com/watch?v=7gK3QD2QSRo','youtube','Fool\'s Gold','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjAzMjk4NjI4M15BMl5BanBnXkFtZTcwNjQ4OTEwNA@@._V1_SX300.jpg','http://www.youtube.com/watch?v=lti0vfCPZns','youtube','The Next Three Days','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjExOTM4NDUzNV5BMl5BanBnXkFtZTcwOTgzNzczMw@@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Sahara','wiki','Sahara','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BNjU4NzYzOTY1MF5BMl5BanBnXkFtZTgwMTAyNTc1MDE@._V1_SX300.jpg','http://www.youtube.com/watch?v=5klp6rkHIks','youtube','Ride Along','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTU4ODAzMzcxOV5BMl5BanBnXkFtZTgwODkxMDI1NjE@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Ride_Along_2','wiki','Ride Along 2','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjA2NzEzNjIwNl5BMl5BanBnXkFtZTgwNzgwMTEzNzE@._V1_SX300.jpg','http://www.youtube.com/watch?v=MxEw3elSJ8M','youtube','Central Intelligence','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTY0NjI3MzM2Nl5BMl5BanBnXkFtZTcwNDgxNjA5Nw@@._V1_SX300.jpg','http://www.youtube.com/watch?v=4qQ6UcU_JiE','youtube','The Campaign','ayushman'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ0OTE1MTk4N15BMl5BanBnXkFtZTgwMDM5OTk5NjE@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Daddy\'s_Home','wiki','Daddy\'s Home','ayushman'),('https://images-na.ssl-images-amazon.com/images/I/71zMIQwrRlL._SY679_.jpg','https://www.amazon.in//Honor-View-10-128GB-memory/dp/B077PWJQ57?_encoding=UTF8&amp;psc=1','amazon','Honor View 10 (Navy Blue, 6GB RAM + 128GB memory)','sarthak'),('https://images-na.ssl-images-amazon.com/images/I/71E9Z7PDTyL._SY355_.jpg','https://www.amazon.in//Taslar%C2%AE-Front-Screen-Scratch-Protector/dp/B079DT6FFB?_encoding=UTF8&amp;psc=1','amazon','Taslar® Front Screen Scratch Guard Protector For Honor Band A2 - (Pack Of 2)','sarthak'),('https://images-na.ssl-images-amazon.com/images/I/91V89Qmb5YL._SX342_.jpg','https://www.amazon.in//Honor-Blue-4GB-32GB-memory/dp/B0784BZ5VY?_encoding=UTF8&amp;psc=1','amazon','Honor 7X (Blue, 4GB RAM + 32GB memory)','sarthak'),('https://images-na.ssl-images-amazon.com/images/I/71v-OpApXdL._SX425_.jpg','https://www.amazon.in//Golden-Sand-Honor-View-Leather/dp/B078Q9VCWY?_encoding=UTF8&amp;psc=1','amazon','Golden Sand Honor View 10 Case Premium Leather Texture Series Rugged Armor ShockProof TPU Back Cover for Huawei Honor View 10 Mobile, Navy Blue','sarthak'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','http://www.youtube.com/watch?v=3ChgRbqGi-E','youtube','Stranger Things','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BZDNhNzhkNDctOTlmOS00NWNmLWEyODQtNWMxM2UzYmJiNGMyXkEyXkFqcGdeQXVyNTMxMjgxMzA@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Breaking_Bad','wiki','Breaking Bad','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMWY3NTljMjEtYzRiMi00NWM2LTkzNjItZTVmZjE0MTdjMjJhL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNTQ4NTc5OTU@._V1_SX300.jpg','https://www.reddit.com/r/Sherlock','reddit','Sherlock','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BOGE2YWUzMDItNTg2Ny00NTUzLTlmZGYtNWMyNzVjMjQ3MThkXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg','http://www.youtube.com/watch?v=ZrU_tt4R3xY','youtube','South Park','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTQ1NDg1Ml5BMl5BanBnXkFtZTgwNzY2NDA0MjI@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Game_of_Thrones','wiki','Game of Thrones','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BNTEwYzNiMGUtNzRlYS00MTMzLTliNzgtOGUxZGZiNThlNWYwXkEyXkFqcGdeQXVyMjYwNDA2MDE@._V1_SX300.jpg','https://www.reddit.com/r/BlackMirror','reddit','Black Mirror','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BNzA2ZDk2ZTUtMWU2Yi00NDVmLTk1ODEtMmFmMjQyNWYzODI0XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg','http://www.youtube.com/watch?v=pTKgLK6DB80','youtube','Futurama','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTEyODk5NTc2MjNeQTJeQWpwZ15BbWU4MDQ5NTgwOTkx._V1_SX300.jpg','https://en.wikipedia.org/wiki/Westworld','wiki','Westworld','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjRiNDRhNGUtMzRkZi00MThlLTg0ZDMtNjc5YzFjYmFjMmM4XkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg','http://www.youtube.com/watch?v=WTWdP5DMdsM','youtube','Rick and Morty','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTg3NTMwMzY2OF5BMl5BanBnXkFtZTgwMDcxMjQ0NDE@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Archer','wiki','Archer','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMjhiNTZhNGEtYTRhNS00NGZlLWIxNjktYzI0NDAyMTQ0NzY3XkEyXkFqcGdeQXVyNjQ2MjQ5NzM@._V1_SX300.jpg','http://www.youtube.com/watch?v=32q0PUcAZwY','youtube','F Is for Family','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTcyNTk0ODgzOF5BMl5BanBnXkFtZTgwMzM0NjIzMzI@._V1_SX300.jpg','http://www.youtube.com/watch?v=hk_BoK0OwZs','youtube','Big Mouth','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BNzA2ZDk2ZTUtMWU2Yi00NDVmLTk1ODEtMmFmMjQyNWYzODI0XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Futurama','wiki','Futurama','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BOGE2YWUzMDItNTg2Ny00NTUzLTlmZGYtNWMyNzVjMjQ3MThkXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg','https://www.reddit.com/r/SouthPark','reddit','South Park','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTg2MzI0NTQ3OV5BMl5BanBnXkFtZTgwODMyMzc1MDE@._V1_SX300.jpg','http://www.youtube.com/watch?v=-RoFVJC3JS4','youtube','Bob\'s Burgers','eshan'),('https://images-na.ssl-images-amazon.com/images/M/MV5BMTk4OTIyNzA5NF5BMl5BanBnXkFtZTcwODQxMTE1OQ@@._V1_SX300.jpg','https://en.wikipedia.org/wiki/Arrested_Development','wiki','Arrested Development','eshan');
/*!40000 ALTER TABLE `recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping`
--

DROP TABLE IF EXISTS `shopping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopping` (
  `username` varchar(20) DEFAULT NULL,
  `prod_url` text,
  `image_url` text,
  `title` varchar(200) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping`
--

LOCK TABLES `shopping` WRITE;
/*!40000 ALTER TABLE `shopping` DISABLE KEYS */;
INSERT INTO `shopping` VALUES ('ayushman','https://www.amazon.in/dp/B009C2HBD6/ref=br_msw_pdt-1?pf_rd_m=A1VBAL9TL5WCBF','https://images-na.ssl-images-amazon.com/images/I/41h2D-nBHkL.jpg','Strontium Pollex 16GB USB Pen Drive (Black/Red)','360.00'),('ayushman','https://www.amazon.in/dp/B00C5K8D5W/ref=sspa_dk_detail_1?psc=1','https://images-na.ssl-images-amazon.com/images/I/51j1tYZCKpL._SY450_.jpg','Kingston DataTraveler DT100 G3 16GB USB 3.0 Pen Drive','1,399.00'),('ayushman','https://www.amazon.in/Mivi-Female-Adapter-Supported-Smartphones/dp/B0742BBQPG/ref=pd_sim_147_4?_encoding=UTF8','https://images-na.ssl-images-amazon.com/images/I/71yohFzvITL._SY450_.jpg','Mivi Micro USB To USB A Female OTG Adapter For OTG Supported Smartphones','399.00'),('ayushman','https://www.amazon.in/gp/product/B072K7VVFX/ref=s9u_simh_gw_i6?ie=UTF8','https://images-na.ssl-images-amazon.com/images/I/71Eq9nNuWrL._UX385_.jpg','Fogg Analog White Dial Men\'s Watch 1094-BR','399.00'),('ayushman','https://www.flipkart.com/oricum-combo-671-606-946-653-casuals-men/p/itmffpwanze5xsuy?pid=SHOFFZPUG5MGZC5B','https://rukminim1.flixcart.com/image/704/704/jcp4b680/shoe/t/9/m/combo-o-610-606-946-653-6-oricum-grey-original-imaffzhqvmgbysny.jpeg?q=70','Oricum COMBO-671+606+946+653 Casuals For Men  (Grey)','899'),('ayushman','https://www.flipkart.com/wizzart-back-cover-mi-redmi-note-4/p/itmett58prgh8khq?pid=ACCETT4WZ2BXXSZJ','https://rukminim1.flixcart.com/image/704/704/j2ggpe80/cases-covers/back-cover/s/z/j/wizzart-02sh-mxrmn4-13-original-imaetsa9bgjamyyt.jpeg?q=70','Wizzart Back Cover for Mi Redmi Note 4  (batman joker, Plastic)','233'),('ayushman','https://www.amazon.in/dp/B078W5MQ6Q/ref=dp_cerb_3','https://images-na.ssl-images-amazon.com/images/I/71P1DJJEIQL._UX425_.jpg','Carson CR7106 Dynamo Day-n-Date Watch - For Men','399.00'),('ayushman','https://www.amazon.in/Watches-Watch-stylish-Analogue-Offers/dp/B0795M2RBK/ref=pd_sim_241_7?_encoding=UTF8','https://images-na.ssl-images-amazon.com/images/I/71TYeNbI0ZL._UX425_.jpg','Watches For Boys / Watches For Mens / Watch For Boy / Watch For Men stylish / Watch For Kids Boys Analogue Black Dial Offers','397.00'),('ayushman','https://www.amazon.in/dp/B072BPVZ9Y/ref=sspa_dk_detail_2?psc=1','https://images-na.ssl-images-amazon.com/images/I/71yYcnn%2BAaL._UX342_.jpg','Littly Unisex Cotton Pyjama Bottom (Pack of 5)','699.00'),('ayushman','https://www.amazon.in/dp/B072BPVZ9Y/ref=sspa_dk_detail_2?psc=1','https://images-na.ssl-images-amazon.com/images/I/71yYcnn%2BAaL._UX342_.jpg','Littly Unisex Cotton Pyjama Bottom (Pack of 5)','699.00'),('ayushman','https://www.amazon.in/dp/B072BPVZ9Y/ref=sspa_dk_detail_2?psc=1','https://images-na.ssl-images-amazon.com/images/I/71yYcnn%2BAaL._UX342_.jpg','Littly Unisex Cotton Pyjama Bottom (Pack of 5)','699.00'),('ayushman','https://www.amazon.in/Puma-Prisma-Hawaiian-Ocean-Sandals/dp/B077G3JDDV/ref=sr_1_1?s=apparel','https://images-na.ssl-images-amazon.com/images/I/91ufEKPgzYL._UY535_.jpg','Puma Men\'s Prisma Flip IDP Flip Flops Thong Sandals','329.00 -    599.00'),('ayushman','https://www.amazon.in/Forzza-William-Single-Seater-Recliner/dp/B0748FX421/ref=sr_1_1?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/414bZDfg27L._SX450_.jpg','Forzza William Single Seater Recliner (Light Grey)','8,299.00'),('ayushman','https://www.amazon.in/Cello-Oasis-Seater-Centre-Table/dp/B01F5HFUNE/ref=sr_1_4?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/410CjLU2qPL._SY355_.jpg','Cello Oasis Four Seater Centre Table (Ice Brown)','999.00'),('ayushman','https://www.amazon.in/Crompton-Hill-1200mm-Ceiling-Brown/dp/B015H0AKTS/ref=sr_1_2?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/71PMWlQ7HgL._SX450_.jpg','Crompton Hill Briz 1200mm Ceiling Fan (Brown)','1,275.00'),('ayushman','https://www.amazon.in/Signoraware-Round-Plastic-Plate-Yellow/dp/B00JJH3U3O/ref=sr_1_1?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/81fZ0SjCz7L._SX522_.jpg','Signoraware Round Plastic Full Plate Set, Set of 3, Lemon Yellow','243.00'),('ayushman','https://www.amazon.in/Swiss-Classic-Paring-Peeler-Pieces/dp/B01GHTVX9E/ref=sr_1_1_sspa?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/51KWK3ZxQdL._SX466_.jpg','Swiss Classic Paring Knife Set With Peeler, 3 Pieces - 6.7113.31','1,250.00'),('ayushman','https://www.amazon.in/Solimo-piece-Stainless-Steel-Stripes/dp/B06Y14XM5H/ref=sr_1_1?s=kitchen','https://images-na.ssl-images-amazon.com/images/I/91bNwFJ222L._SX450_.jpg','Solimo 6 piece Stainless Steel Fork Set, Stripes','279.00'),('eshan','https://www.flipkart.com/flipkart-smartbuy-dynamo-550-w-mixer-grinder/p/itmes6bxsbywfeyu?pid=MIXES6BXETYTZ2TQ','https://rukminim1.flixcart.com/image/704/704/j20qv0w0/mixer-grinder-juicer/2/t/q/flipkart-smartbuy-mgp550w-original-imaeth7sqngkcszm.jpeg?q=70','Flipkart SmartBuy Dynamo 550 W Mixer Grinder  (White, 3 Jars)','1,499'),('eshan','https://www.amazon.in/Fogg-Analog-White-Watch-2038-WH/dp/B076F947LW/ref=br_msw_pdt-3?_encoding=UTF8','https://images-na.ssl-images-amazon.com/images/I/71c1a1x2C8L._UX522_.jpg','Fogg Analog White Day and Date Dial Men\'s Watch 2038-WH','399.00'),('ayushman','https://www.amazon.in/JBL-C100SI-Ear-Headphones-Black/dp/B01DEWVZ2C/ref=br_bsl_pdt-1?pf_rd_m=A1VBAL9TL5WCBF','https://images-na.ssl-images-amazon.com/images/I/61y71IsqUyL._SX425_.jpg','JBL C100SI In-Ear Headphones with Mic (Black)','1,099.00'),('sarthak','https://www.amazon.in/Honor-AW61-Band-A2-Black/dp/B0776X8W26/ref=gbph_img_m-3_465a_5aa06351?smid=A2HIN95H5BP4BL','https://images-na.ssl-images-amazon.com/images/I/71pcYVegIWL._SX466_.jpg','Honor Band A2 (Black)','2,249.00'),('sarthak','https://www.amazon.in/dp/B0714BCMWL/ref=sspa_dk_detail_6?psc=1','https://images-na.ssl-images-amazon.com/images/I/61hjFM3AIAL._SX425_.jpg','Flink Badminton Tracker','3,599.00');
/*!40000 ALTER TABLE `shopping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ayushman','ayushman','$5$rounds=535000$lVJVRFDOWgT2uXgT$hTDl5AattTeE8bg.qQadz8QCeoYDAXJDni4JU8OjfKB'),('eshan','eshan','$5$rounds=535000$LcIOqhrl3UHEr0DB$WgLwG/UipxF5RMllpCWvxk9kocmYrFXLyl8fTVfsqd9'),('sarthak','sarthak','$5$rounds=535000$BwIDAMlWav2kd9.A$WYOjI2aMHBCd8vXvMjWCk1nePrmtQ7UuJyAwzz2EsQD');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos` (
  `username` varchar(20) DEFAULT NULL,
  `vid_url` text,
  `image_url` text,
  `title` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES ('ayushman','http://www.dailymotion.com/video/x64urmm','https://s2-ssl.dmcdn.net/nPKbc/526x297-9r7.jpg','LA CASA DE PAPEL T2 CAPITULO 1 HD 1/2 - Vìdeo Dailymotion'),('ayushman','https://www.youtube.com/watch?v=Ie4oeMp12CA','https://i.ytimg.com/vi/Ie4oeMp12CA/hqdefault.jpg','Key & Peele - Non-Scary Movie'),('ayushman','https://www.netflix.com/in/title/80209096','https://images-na.ssl-images-amazon.com/images/M/MV5BODY1ODg5ZmEtMmQ1Ny00YWUzLWExODUtYmRhYzhhMGZhNmRhXkEyXkFqcGdeQXVyODQ1NTk5OQ@@._V1_SX300.jpg','My Next Guest Needs No Introduction With David Letterman'),('ayushman','https://www.youtube.com/watch?v=HTfae73dIpk','https://i.ytimg.com/vi/HTfae73dIpk/hqdefault.jpg','Jake and Amir: Talent Show Part 2'),('ayushman','https://www.youtube.com/watch?v=PT2_F-1esPk','https://i.ytimg.com/vi/PT2_F-1esPk/hqdefault.jpg','The Chainsmokers - Closer (Lyric) ft. Halsey'),('ayushman','https://www.youtube.com/watch?v=PT2_F-1esPk','https://i.ytimg.com/vi/PT2_F-1esPk/hqdefault.jpg','The Chainsmokers - Closer (Lyric) ft. Halsey'),('ayushman','https://www.youtube.com/watch?v=IgCphQCkHSk','https://i.ytimg.com/vi/IgCphQCkHSk/hqdefault.jpg','Alan Walker - Faded'),('ayushman','https://www.netflix.com/in/title/80014749','https://images-na.ssl-images-amazon.com/images/M/MV5BMjRiNDRhNGUtMzRkZi00MThlLTg0ZDMtNjc5YzFjYmFjMmM4XkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg','Rick and Morty'),('ayushman','https://www.netflix.com/in/title/70178217','https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODMyMjc3MV5BMl5BanBnXkFtZTgwNDgzNDc5NzE@._V1_SX300.jpg','House of Cards'),('ayushman','https://www.netflix.com/in/title/70178217','https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODMyMjc3MV5BMl5BanBnXkFtZTgwNDgzNDc5NzE@._V1_SX300.jpg','House of Cards'),('ayushman','https://www.netflix.com/in/title/70178217','https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODMyMjc3MV5BMl5BanBnXkFtZTgwNDgzNDc5NzE@._V1_SX300.jpg','House of Cards'),('ayushman','https://www.netflix.com/in/title/80057281','https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','Stranger Things'),('ayushman','https://www.netflix.com/in/title/80057281','https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','Stranger Things'),('ayushman','https://www.netflix.com/in/title/80057281','https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','Stranger Things'),('ayushman','https://www.netflix.com/in/title/70178217','https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODMyMjc3MV5BMl5BanBnXkFtZTgwNDgzNDc5NzE@._V1_SX300.jpg','House of Cards'),('ayushman','https://www.netflix.com/in/title/80057281','https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','Stranger Things'),('ayushman','https://www.netflix.com/in/title/80057281','https://images-na.ssl-images-amazon.com/images/M/MV5BMjUwMDgzOTg3Nl5BMl5BanBnXkFtZTgwNTI4MDk5MzI@._V1_SX300.jpg','Stranger Things'),('ayushman','https://www.netflix.com/in/title/70178217','https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODMyMjc3MV5BMl5BanBnXkFtZTgwNDgzNDc5NzE@._V1_SX300.jpg','House of Cards'),('ayushman','https://www.netflix.com/in/title/70300800','https://images-na.ssl-images-amazon.com/images/M/MV5BMjI2MDMxODAyMl5BMl5BanBnXkFtZTgwNjI1NTIzMzI@._V1_SX300.jpg','BoJack Horseman'),('ayushman','https://www.netflix.com/in/title/70300800','https://images-na.ssl-images-amazon.com/images/M/MV5BMjI2MDMxODAyMl5BMl5BanBnXkFtZTgwNjI1NTIzMzI@._V1_SX300.jpg','BoJack Horseman'),('ayushman','https://www.netflix.com/in/title/70300800','https://images-na.ssl-images-amazon.com/images/M/MV5BMjI2MDMxODAyMl5BMl5BanBnXkFtZTgwNjI1NTIzMzI@._V1_SX300.jpg','BoJack Horseman'),('eshan','https://www.youtube.com/watch?v=HTfae73dIpk','https://i.ytimg.com/vi/HTfae73dIpk/hqdefault.jpg','Jake and Amir: Talent Show Part 2'),('eshan','https://www.netflix.com/in/title/80209096','https://images-na.ssl-images-amazon.com/images/M/MV5BODY1ODg5ZmEtMmQ1Ny00YWUzLWExODUtYmRhYzhhMGZhNmRhXkEyXkFqcGdeQXVyODQ1NTk5OQ@@._V1_SX300.jpg','My Next Guest Needs No Introduction With David Letterman'),('ayushman','https://www.netflix.com/in/title/70167077','https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4NDE4NTY5MV5BMl5BanBnXkFtZTcwODQyMTkxNA@@._V1_SX300.jpg','The Lincoln Lawyer'),('ayushman','https://www.netflix.com/in/title/70167077','https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4NDE4NTY5MV5BMl5BanBnXkFtZTcwODQyMTkxNA@@._V1_SX300.jpg','The Lincoln Lawyer'),('ayushman','https://www.netflix.com/in/title/70167077','https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4NDE4NTY5MV5BMl5BanBnXkFtZTcwODQyMTkxNA@@._V1_SX300.jpg','The Lincoln Lawyer'),('ayushman','https://www.netflix.com/in/title/80018689','https://images-na.ssl-images-amazon.com/images/M/MV5BMTc3OTc1NjM0M15BMl5BanBnXkFtZTgwNjAyMzE1MzE@._V1_SX300.jpg','Get Hard'),('ayushman','https://www.netflix.com/in/title/80018689','https://images-na.ssl-images-amazon.com/images/M/MV5BMTc3OTc1NjM0M15BMl5BanBnXkFtZTgwNjAyMzE1MzE@._V1_SX300.jpg','Get Hard'),('ayushman','https://www.netflix.com/in/title/80002479','https://images-na.ssl-images-amazon.com/images/M/MV5BMTQxODYzNTQzOV5BMl5BanBnXkFtZTgwMTI2MDYwMDE@._V1_SX300.jpg','Peaky Blinders'),('ayushman','https://www.netflix.com/in/title/70167077','https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4NDE4NTY5MV5BMl5BanBnXkFtZTcwODQyMTkxNA@@._V1_SX300.jpg','The Lincoln Lawyer'),('ayushman','https://www.netflix.com/in/title/80018689','https://images-na.ssl-images-amazon.com/images/M/MV5BMTc3OTc1NjM0M15BMl5BanBnXkFtZTgwNjAyMzE1MzE@._V1_SX300.jpg','Get Hard'),('eshan','https://www.netflix.com/in/title/80014749','https://images-na.ssl-images-amazon.com/images/M/MV5BMjRiNDRhNGUtMzRkZi00MThlLTg0ZDMtNjc5YzFjYmFjMmM4XkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg','Rick and Morty'),('eshan','https://www.netflix.com/in/title/70300800','https://images-na.ssl-images-amazon.com/images/M/MV5BMjI2MDMxODAyMl5BMl5BanBnXkFtZTgwNjI1NTIzMzI@._V1_SX300.jpg','BoJack Horseman'),('ayushman','https://www.youtube.com/watch?v=rixqsLpq8kE','https://i.ytimg.com/vi/rixqsLpq8kE/hqdefault.jpg','Top 10 Crazy Rick and Morty Fan Theories That Might Be True');
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-27  0:15:37
