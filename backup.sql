-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: employee_manage
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Отдел продаж',NULL,NULL),(2,'Бухгалтерия',NULL,NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` bigint unsigned NOT NULL,
  `name_id` bigint unsigned NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('done','in_process','decline') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_process',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_name_id_foreign` (`name_id`),
  KEY `documents_creator_id_foreign` (`creator_id`),
  CONSTRAINT `documents_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `documents_name_id_foreign` FOREIGN KEY (`name_id`) REFERENCES `documents_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,2,1,'2025-04-08 16:04:09','in_process',NULL,'2025-04-08 16:04:09','2025-04-08 16:04:09'),(2,2,1,'2025-04-08 16:04:59','in_process',NULL,'2025-04-08 16:04:59','2025-04-08 16:04:59'),(3,2,1,'2025-04-08 16:06:36','in_process',NULL,'2025-04-08 16:06:36','2025-04-08 16:06:36'),(4,2,1,'2025-04-08 16:08:45','in_process',NULL,'2025-04-08 16:08:45','2025-04-08 16:08:45'),(5,2,1,'2025-04-08 16:10:18','in_process',NULL,'2025-04-08 16:10:18','2025-04-08 16:10:18'),(6,2,1,'2025-04-08 16:10:20','in_process',NULL,'2025-04-08 16:10:20','2025-04-08 16:10:20'),(7,2,1,'2025-04-08 16:10:53','in_process',NULL,'2025-04-08 16:10:53','2025-04-08 16:10:53'),(8,2,1,'2025-04-08 16:10:54','in_process',NULL,'2025-04-08 16:10:54','2025-04-08 16:10:54'),(9,2,1,'2025-04-08 16:22:21','in_process',NULL,'2025-04-08 16:22:21','2025-04-08 16:22:21'),(10,1,1,'2025-04-08 18:46:31','in_process',NULL,'2025-04-08 18:46:31','2025-04-08 18:46:31'),(11,1,1,'2025-04-10 19:31:28','in_process',NULL,'2025-04-10 19:31:28','2025-04-10 19:31:28');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_types`
--

DROP TABLE IF EXISTS `documents_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_types`
--

LOCK TABLES `documents_types` WRITE;
/*!40000 ALTER TABLE `documents_types` DISABLE KEYS */;
INSERT INTO `documents_types` VALUES (1,'Cправка о доходах','HeadAccountant',NULL,NULL),(2,'Справка о стаже работы','SEO',NULL,NULL),(3,'Копия трудового договора','HR',NULL,NULL),(4,'Копия приказа о командировке','HR',NULL,NULL);
/*!40000 ALTER TABLE `documents_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_04_06_195033_create_personal_access_tokens_table',1),(5,'2025_04_06_200958_add_columns_to_users_table',2),(6,'2025_04_06_202454_create_departments_table',3),(7,'2025_04_06_202951_add_department_to_users_table',4),(8,'2025_04_06_203406_delete_name_on_users_table',5),(9,'2025_04_06_220419_create_tasks_table',6),(10,'2025_04_06_222127_create_task_user_table',7),(11,'2025_04_08_145822_create_documents_types_table',8),(12,'2025_04_08_150254_create_documents_table',9),(13,'2025_04_08_151111_add_creator_id_to_documents_table',10),(14,'2025_04_08_172015_create_notifications_table',11),(15,'2020_10_04_115514_create_moonshine_roles_table',12),(16,'2020_10_05_173148_create_moonshine_tables',12);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moonshine_user_roles`
--

DROP TABLE IF EXISTS `moonshine_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moonshine_user_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moonshine_user_roles`
--

LOCK TABLES `moonshine_user_roles` WRITE;
/*!40000 ALTER TABLE `moonshine_user_roles` DISABLE KEYS */;
INSERT INTO `moonshine_user_roles` VALUES (1,'Admin','2025-04-11 15:52:19','2025-04-11 15:52:19');
/*!40000 ALTER TABLE `moonshine_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moonshine_users`
--

DROP TABLE IF EXISTS `moonshine_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moonshine_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `moonshine_user_role_id` bigint unsigned NOT NULL DEFAULT '1',
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `moonshine_users_email_unique` (`email`),
  KEY `moonshine_users_moonshine_user_role_id_foreign` (`moonshine_user_role_id`),
  CONSTRAINT `moonshine_users_moonshine_user_role_id_foreign` FOREIGN KEY (`moonshine_user_role_id`) REFERENCES `moonshine_user_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moonshine_users`
--

LOCK TABLES `moonshine_users` WRITE;
/*!40000 ALTER TABLE `moonshine_users` DISABLE KEYS */;
INSERT INTO `moonshine_users` VALUES (1,1,'adminipsharafutdinov','$2y$12$UpTeV8ZoX5cOrT1/lhLaAOyvk2d7elNogsmopDAa59outILgTR8uK','adminuser',NULL,NULL,'2025-04-11 15:52:50','2025-04-11 15:52:50');
/*!40000 ALTER TABLE `moonshine_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES ('08aae508-7002-4bb7-935b-2aaf7f9cf633','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',3,'{\"task_id\":31,\"task_name\":\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-11 22:58:21','2025-04-11 22:58:21'),('1577330e-7511-4692-9502-edf3f5d630c7','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":13,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 02:40:00','2025-04-11 15:37:05'),('1b09083d-f974-4adc-b15f-862d93bbb5e6','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":16,\"task_name\":\"\\u041d\\u0430\\u0432\\u0437\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041d\\u0430\\u0432\\u0437\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 12:21:59','2025-04-11 15:37:05'),('1d595845-cdc2-48eb-b753-f66369dd8f6f','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',1,'{\"task_id\":10,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-10 19:26:52','2025-04-09 20:12:44','2025-04-10 19:26:52'),('1f163ce0-6c1a-4edb-9212-0a89e99b1b69','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":21,\"task_name\":\"\\u0420\\u0410\\u0441\\u0442\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0420\\u0410\\u0441\\u0442\"}','2025-04-11 15:37:05','2025-04-11 12:39:53','2025-04-11 15:37:05'),('28befb84-3aa8-4804-be94-75edbf6171b6','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":14,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 03:14:10','2025-04-11 15:37:05'),('2db9e139-8b84-4201-9dd5-717453195e07','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":24,\"task_name\":\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 12:43:30','2025-04-11 15:37:05'),('2f3c567b-3ceb-4644-9f96-e2ce62f23195','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":12,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-10 21:19:26','2025-04-11 15:37:05'),('3401399c-f3de-4e73-b765-9f924ef50764','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":11,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-10 20:53:42','2025-04-11 15:37:05'),('3bc24837-8f64-4315-9e8d-b49666e859ba','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":13,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 02:40:00','2025-04-11 15:37:05'),('4cd327d4-e667-4ad1-be02-55b0a3911c38','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',3,'{\"task_id\":28,\"task_name\":\"\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430scscsccsc\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430scscsccsc\"}','2025-04-11 22:17:49','2025-04-11 16:43:47','2025-04-11 22:17:49'),('51dc67c9-a698-466d-a0f5-1973d39c2a52','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":12,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-10 21:19:26','2025-04-11 15:37:05'),('520475d5-a028-470b-ba58-00ba403c7a97','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":17,\"task_name\":\"\\u043c\\u043f\\u043c\\u043d\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u043c\\u043f\\u043c\\u043d\"}','2025-04-11 15:37:05','2025-04-11 12:22:39','2025-04-11 15:37:05'),('68ba18d5-c1bf-4cb1-ae16-c077fccceed0','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',3,'{\"task_id\":27,\"task_name\":\"\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430scscsccsc\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430scscsccsc\"}','2025-04-11 22:17:49','2025-04-11 16:43:23','2025-04-11 22:17:49'),('6a34135e-a2c7-4656-8ac7-ba79c9c04171','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":15,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 11:15:33','2025-04-11 15:37:05'),('6e6c69a3-4f06-4c2d-b956-53c89793354b','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":23,\"task_name\":\"\\u0443\\u0430\\u0440\\u0448\\u0443\\u0449\\u0440\\u0430\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0443\\u0430\\u0440\\u0448\\u0443\\u0449\\u0440\\u0430\"}','2025-04-11 15:37:05','2025-04-11 12:41:57','2025-04-11 15:37:05'),('8e0cff80-3aca-4638-ae03-bd17ff5c0aad','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":25,\"task_name\":\"\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\"}','2025-04-11 15:48:15','2025-04-11 15:42:58','2025-04-11 15:48:15'),('91dbbdf5-a885-4d0b-9655-effbcc3b2721','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":20,\"task_name\":\"\\u0434\\u0431\\u044c\\u043b\\u0442\\u043e\\u0438\\u0440\\u043c\\u043f\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0434\\u0431\\u044c\\u043b\\u0442\\u043e\\u0438\\u0440\\u043c\\u043f\"}','2025-04-11 15:37:05','2025-04-11 12:33:17','2025-04-11 15:37:05'),('9f3e307a-740e-4f1c-9cba-a95a58d5325c','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',1,'{\"task_id\":10,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-10 19:26:52','2025-04-09 20:12:44','2025-04-10 19:26:52'),('aa20d416-3c63-4a24-a838-763280b9aea0','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',3,'{\"task_id\":30,\"task_name\":\"\\u041a\\u0430\\u043a\\u043e\\u0435-\\u0442\\u043e \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041a\\u0430\\u043a\\u043e\\u0435-\\u0442\\u043e \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-11 22:52:38','2025-04-11 22:52:38'),('ab194a34-3df1-4d9e-8e2a-bc292ccd9358','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',1,'{\"task_id\":31,\"task_name\":\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-11 22:58:21','2025-04-11 22:58:21'),('b720a1f0-e679-40e4-a4fd-1a2bb8ca3a7f','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',1,'{\"task_id\":23,\"task_name\":\"\\u0443\\u0430\\u0440\\u0448\\u0443\\u0449\\u0440\\u0430\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0443\\u0430\\u0440\\u0448\\u0443\\u0449\\u0440\\u0430\"}',NULL,'2025-04-11 12:41:57','2025-04-11 12:41:57'),('c6d92735-08e9-467f-af09-452b8fa0e5e0','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":29,\"task_name\":\"kmnjbhvg\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: kmnjbhvg\"}',NULL,'2025-04-11 16:54:46','2025-04-11 16:54:46'),('ca3dd962-b15c-45d8-918e-64c030d3c3c9','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":22,\"task_name\":\"\\u0420\\u044f\\u0434\\u043e\\u043c\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0420\\u044f\\u0434\\u043e\\u043c\"}','2025-04-11 15:37:05','2025-04-11 12:40:27','2025-04-11 15:37:05'),('cd1f61c0-27cf-493a-bb92-69774b7c34c6','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',1,'{\"task_id\":11,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-10 20:53:42','2025-04-10 20:53:42'),('d46676f0-18e9-46c7-bc59-04335bf34f64','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',1,'{\"task_id\":30,\"task_name\":\"\\u041a\\u0430\\u043a\\u043e\\u0435-\\u0442\\u043e \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041a\\u0430\\u043a\\u043e\\u0435-\\u0442\\u043e \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-11 22:52:38','2025-04-11 22:52:38'),('d72f7cf0-535f-4732-928a-f7ce25cd8c09','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":14,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 03:14:10','2025-04-11 15:37:05'),('d7c51e19-1d35-4833-b9d0-f876e315284d','App\\Notifications\\CreateDocumentNotification','App\\Models\\User',1,'{\"document_id\":11,\"document_name\":\"C\\u043f\\u0440\\u0430\\u0432\\u043a\\u0430 \\u043e \\u0434\\u043e\\u0445\\u043e\\u0434\\u0430\\u0445\",\"message\":\"\\u0412\\u044b \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u044f\\u0432\\u043a\\u0443 \\u043d\\u0430 \\u0434\\u043e\\u043a\\u0443\\u043c\\u0435\\u043d\\u0442: C\\u043f\\u0440\\u0430\\u0432\\u043a\\u0430 \\u043e \\u0434\\u043e\\u0445\\u043e\\u0434\\u0430\\u0445\"}',NULL,'2025-04-10 19:31:28','2025-04-10 19:31:28'),('dbca2558-e719-4788-9585-8e98f83f5eec','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":19,\"task_name\":\"\\u0434\\u043b\\u043e\\u0440\\u043f\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0434\\u043b\\u043e\\u0440\\u043f\"}','2025-04-11 15:37:05','2025-04-11 12:30:52','2025-04-11 15:37:05'),('e1aea944-0dd9-4247-b465-2fb7ed7822d6','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',3,'{\"task_id\":29,\"task_name\":\"kmnjbhvg\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: kmnjbhvg\"}','2025-04-11 22:17:49','2025-04-11 16:54:46','2025-04-11 22:17:49'),('e7975194-a964-4a03-9aa4-9581fa6af23b','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":18,\"task_name\":\"\\u044c\\u043b\\u0442\\u043e\\u0438\\u0440\\u043f\\u043c\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u044c\\u043b\\u0442\\u043e\\u0438\\u0440\\u043f\\u043c\"}','2025-04-11 15:37:05','2025-04-11 12:28:07','2025-04-11 15:37:05'),('eb988559-1854-43ae-b941-4aa09570b8ef','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":26,\"task_name\":\"\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\\u0430\"}','2025-04-11 15:48:39','2025-04-11 15:48:35','2025-04-11 15:48:39'),('edb4547e-79a9-4896-96b1-100e2d9f238a','App\\Notifications\\TaskCreatedToUser','App\\Models\\User',2,'{\"task_id\":15,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u044b \\u0443\\u0441\\u043f\\u0435\\u0448\\u043d\\u043e \\u0441\\u043e\\u0437\\u0434\\u0430\\u043b\\u0438 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-11 11:15:33','2025-04-11 15:37:05'),('ef3e8413-2b98-44ba-8a46-eb7cd64d2875','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',2,'{\"task_id\":10,\"task_name\":\"\\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041f\\u043b\\u0430\\u043d\\u044b \\u043d\\u0430 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0430\\u043b - \\u0441\\u043e\\u0431\\u0440\\u0430\\u043d\\u0438\\u0435\"}','2025-04-11 15:37:05','2025-04-09 20:12:44','2025-04-11 15:37:05'),('f4f6e127-c121-4c35-8f85-b0dbfba41fa6','App\\Notifications\\CreateTaskToMembers','App\\Models\\User',1,'{\"task_id\":24,\"task_name\":\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\",\"message\":\"\\u0412\\u0430\\u0441 \\u043f\\u0440\\u0438\\u0433\\u043b\\u0430\\u0441\\u0438\\u043b\\u0438 \\u0432 \\u0437\\u0430\\u0434\\u0430\\u0447\\u0443: \\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"}',NULL,'2025-04-11 12:43:30','2025-04-11 12:43:30');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (64,'App\\Models\\User',3,'access_token','91de7e701918b6960fce56c65b8cf7d7fe6056db9e2b589259c10087d2bfe81b','[\"*\"]','2025-04-11 23:51:23',NULL,'2025-04-11 23:51:22','2025-04-11 23:51:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('24zHOCGU39hbWSNhXGjyxo8S5MJmqmEwq5sj0D76',NULL,'192.168.65.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVzFVTlI3OU04eWFpeTlNZ3hobjFLZmNKdmdtRHF2RjE0ckpzT2xiRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1744391798),('XD2VKaUmmQ6bkpTHw7iEb6CTQ0bCzbJ5j7jvdion',1,'192.168.65.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiVVhnOW5wNzNvSkxGSnVLb0ZicU40dVpMa1hMSWlheUdGRjV4SVo0dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4MC9hZG1pbi9yZXNvdXJjZS9lbXBsb3llZXMtcmVzb3VyY2UvaW5kZXgtcGFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjU2OiJsb2dpbl9tb29uc2hpbmVfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjM6InBhc3N3b3JkX2hhc2hfbW9vbnNoaW5lIjtzOjYwOiIkMnkkMTIkVXBUZVY4Wm9YNWNPclQxL2xoTGFBT3l2azJkN2VsTm9nc21vcERBYTU5b3V0SUxnVFI4dUsiO30=',1744371486);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_user`
--

DROP TABLE IF EXISTS `task_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `task_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_user_task_id_foreign` (`task_id`),
  KEY `task_user_user_id_foreign` (`user_id`),
  CONSTRAINT `task_user_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_user`
--

LOCK TABLES `task_user` WRITE;
/*!40000 ALTER TABLE `task_user` DISABLE KEYS */;
INSERT INTO `task_user` VALUES (1,1,2,NULL,NULL),(2,2,2,NULL,NULL),(3,3,1,NULL,NULL),(4,3,2,NULL,NULL),(5,4,1,NULL,NULL),(6,4,2,NULL,NULL),(9,6,1,NULL,NULL),(10,6,2,NULL,NULL),(11,7,1,NULL,NULL),(12,7,2,NULL,NULL),(13,8,1,NULL,NULL),(14,8,2,NULL,NULL),(15,9,1,NULL,NULL),(16,9,2,NULL,NULL),(17,10,1,NULL,NULL),(18,10,2,NULL,NULL),(19,11,2,NULL,NULL),(20,12,2,NULL,NULL),(21,13,2,NULL,NULL),(22,14,2,NULL,NULL),(23,15,2,NULL,NULL),(26,29,3,NULL,NULL),(27,30,3,NULL,NULL),(28,31,3,NULL,NULL);
/*!40000 ALTER TABLE `task_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Планы на квартал - собрание','2025-04-08 00:00:00','2025-04-10 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-06 23:01:41','2025-04-06 23:01:41'),(2,'Планы на квартал - собрание','2025-04-08 00:00:00','2025-04-10 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-06 23:03:17','2025-04-06 23:03:17'),(3,'Планы на квартал - собрание','2025-04-08 00:00:00','2025-04-10 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-06 23:03:31','2025-04-06 23:03:31'),(4,'Планы на квартал - собрание','2025-04-08 00:00:00','2025-04-10 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-07 06:57:42','2025-04-07 06:57:42'),(6,'Планы на квартал - собрание','2025-04-06 00:00:00','2025-04-06 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-08 17:31:29','2025-04-08 17:31:29'),(7,'Планы на квартал - собрание','2025-04-06 00:00:00','2025-04-06 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-08 17:51:40','2025-04-08 17:51:40'),(8,'Планы на квартал - собрание','2025-04-06 00:00:00','2025-04-06 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-08 18:38:26','2025-04-08 18:38:26'),(9,'Планы на квартал - собрание','2025-04-06 00:00:00','2025-04-06 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-08 18:40:31','2025-04-08 18:40:31'),(10,'Планы на квартал - собрание','2025-04-06 00:00:00','2025-04-06 00:00:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',1,'2025-04-09 20:12:44','2025-04-09 20:12:44'),(11,'Планы на квартал - собрание','2025-04-10 18:00:00','2025-04-10 18:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',1,'2025-04-10 20:53:42','2025-04-10 20:53:42'),(12,'Планы на квартал - собрание','2025-04-11 02:00:00','2025-04-11 03:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-10 21:19:26','2025-04-10 21:19:26'),(13,'Планы на квартал - собрание','2025-04-11 12:00:00','2025-04-11 16:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-11 02:40:00','2025-04-11 02:40:00'),(14,'Планы на квартал - собрание','2025-04-12 12:00:00','2025-04-12 16:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-11 03:14:10','2025-04-11 03:14:10'),(15,'Планы на квартал - собрание','2025-04-11 11:00:00','2025-04-11 12:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-11 11:15:33','2025-04-11 11:15:33'),(25,'ааааааааа','2025-04-11 11:00:00','2025-04-11 12:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-11 15:42:58','2025-04-11 15:42:58'),(26,'ааааааааа','2025-04-11 11:00:00','2025-04-11 12:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',2,'2025-04-11 15:48:35','2025-04-11 15:48:35'),(27,'аааааааааscscsccsc','2025-04-11 11:00:00','2025-04-11 12:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',3,'2025-04-11 16:43:23','2025-04-11 16:43:23'),(28,'аааааааааscscsccsc','2025-04-11 11:00:00','2025-04-11 18:50:00','Всем привет! Собираемся планы на ближайший квартал, подключайтесь!','https://us06web.zoom.us/my/gumerov?pwd=ZzAxd29qQzNj5263ZUg2YjM78EljUT09',3,'2025-04-11 16:43:47','2025-04-11 16:43:47'),(29,'kmnjbhvg','2025-04-11 16:56:00','2025-04-11 18:55:00',NULL,'lkojihugy',2,'2025-04-11 16:54:46','2025-04-11 16:54:46'),(30,'Какое-то собрание','2025-04-11 22:52:00','2025-04-11 23:20:00','Ужас какой','У меня дома',1,'2025-04-11 22:52:38','2025-04-11 22:52:38'),(31,'Название','2025-04-11 00:00:00','2025-04-12 00:00:00','Approved','У меня дома',1,'2025-04-11 22:58:21','2025-04-11 22:58:21');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patronymic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` bigint unsigned DEFAULT NULL,
  `manager_id` bigint unsigned DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `work_mode` enum('office','remote') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_manager_id_foreign` (`manager_id`),
  KEY `users_department_foreign` (`department`),
  CONSTRAINT `users_department_foreign` FOREIGN KEY (`department`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_manager_id_foreign` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Иван','Иванов','Иванович','+7(999)9999999','ivan@test.test','Руководитель отдела продаж',1,2,'$2y$12$L0E7h/X0uxnq0SKOFcd2fuiNANv2z7FACvJAWdHBu4s/OstJtrgy6',NULL,NULL,NULL,'office'),(2,'Семен','Семенов','Семенович','+7(123)1231212','semen@test.test','Старший бухгалтер',2,1,'$2y$12$L0E7h/X0uxnq0SKOFcd2fuiNANv2z7FACvJAWdHBu4s/OstJtrgy6',NULL,NULL,NULL,'remote'),(3,'Михаил','Махайлов','Махайлович','+7(321)3213232','michail@test.test','SEO',NULL,NULL,'$2y$12$Y3PmV0lTIFcb2.xXQyOhI.W/Ogr2cliwhE2hdSYHCvGr5FmJChFKa',NULL,'2025-04-11 16:38:02','2025-04-11 16:38:02','office');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-11 18:55:42
