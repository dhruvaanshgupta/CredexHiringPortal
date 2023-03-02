CREATE DATABASE hiring;
USE hiring;

CREATE TABLE colleges (
  college_id INT PRIMARY KEY,
  name VARCHAR(255),
  location VARCHAR(255),
  courses_offered TEXT,
  placement_cell_contact VARCHAR(255),
  current_accreditation VARCHAR(255)
);

CREATE TABLE campus_drives (
  drive_id INT PRIMARY KEY,
  recruitment_year INT,
  college_id INT,
  num_students_enrolled INT,
  contact_person VARCHAR(255),
  visit_date DATE,
  team_selected VARCHAR(255),
  FOREIGN KEY (college_id) REFERENCES colleges(college_id)
);

CREATE TABLE questionnaires (
  questionnaire_id INT PRIMARY KEY,
  year INT,
  drive_id INT,
  version INT,
  questionnaire TEXT,
  FOREIGN KEY (drive_id) REFERENCES campus_drives(drive_id)
);

CREATE TABLE roles (
  role_id INT PRIMARY KEY,
  role_name VARCHAR(255)
);

INSERT INTO roles (role_id, role_name) VALUES (1, 'admin'), (2, 'recruiter'), (3, 'student');

CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255),
  password VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  role_id INT DEFAULT 3,
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE student_details (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  campus_type ENUM('On Campus', 'Off Campus'),
  college_id INT,
  date_of_birth DATE,
  gender ENUM('Male', 'Female', 'Others'),
  highest_qualification VARCHAR(255),
  specialization VARCHAR(255),
  current_address TEXT,
  skills TEXT,
  resume_link VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (college_id) REFERENCES colleges(college_id)
);


CREATE TABLE results (
  result_id INT PRIMARY KEY,
  user_id INT,
  score INT,
  technical_score1 INT,
  technical_score2 INT,
  comments TEXT,
  preferred_tech_stack VARCHAR(255),
  total_score INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE selected_students (
  selected_id INT PRIMARY KEY,
  drive_id INT,
  student_id INT,
  FOREIGN KEY (drive_id) REFERENCES campus_drives(drive_id),
  FOREIGN KEY (student_id) REFERENCES student_details(student_id)
);
