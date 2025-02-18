-- babel_test.employees definition

CREATE TABLE `employees` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL COMMENT 'First name of the employee',
  `last_name` varchar(100) NOT NULL COMMENT 'Last name of the employee',
  `second_last_name` varchar(100) DEFAULT NULL COMMENT 'Second last name (optional)',
  `age` int NOT NULL COMMENT 'Age of the employee',
  `gender` enum('M','F','O') NOT NULL COMMENT 'Gender of the employee (M = Male, F = Female, O = Other)',
  `birth_date` datetime(6) NOT NULL,
  `position` varchar(100) NOT NULL COMMENT 'Position or job title of the employee',
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE' COMMENT 'Current status of the employee (Active or Inactive)',
  PRIMARY KEY (`id`)
) COMMENT='Table to store employee information';

-- babel_test.error_log definition

CREATE TABLE `error_log` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each error log entry',
  `event_type` enum('CREATE','UPDATE','DELETE','CONSULT_BY_ID','CONSULT_ACTIVE','CONSULT_ALL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Type of event that failed (''CREATE'',''UPDATE'',''DELETE'',''CONSULT_BY_ID'',''CONSULT_ACTIVE'',''CONSULT_ALL'')',
  `error_message` text NOT NULL,
  `error_timestamp` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time when the error occurred (automatically set)',
  `client_ip` varchar(50) DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `employee_exists` tinyint(1) DEFAULT '0' COMMENT 'Indicates if the employee existed at the time of the event',
  `additional_details` json DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `stack_trace` text,
  PRIMARY KEY (`id`)
)  COMMENT='Table to store failed events or errors related to employee actions';

-- babel_test.event_log definition

CREATE TABLE `event_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint DEFAULT NULL,
  `event_type` enum('CREATE','UPDATE','DELETE','CONSULT_BY_ID','CONSULT_ACTIVE','CONSULT_ALL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Type of event enum(''CREATE'',''UPDATE'',''DELETE'',''CONSULT_BY_ID'',''CONSULT_ACTIVE'',''CONSULT_ALL'')',
  `event_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time when the event occurred (automatically set)',
  `client_ip` varchar(50) DEFAULT NULL COMMENT 'IP address of the client who made the request (optional)',
  `additional_details` blob,
  PRIMARY KEY (`id`),
  KEY `fk_employee_id` (`employee_id`),
  CONSTRAINT `fk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) COMMENT='Table to store event logs related to employee actions';