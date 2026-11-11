-- Defines the attribute of a Class.
CREATE TABLE CLASS (
    course_number VARCHAR(16) NOT NULL,
    term VARCHAR(8) NOT NULL,
    section_number INT NOT NULL,
    desc VARCHAR(255) NOT NULL,
    PRIMARY KEY (course_number, term, section_number)
);

-- Defines the attribute of a Category.
CREATE TABLE CATEGORY (
    course_num VARCHAR(16) NOT NULL,
    term VARCHAR(8) NOT NULL,
    section_num INT NOT NULL,
    name VARCHAR 64 NOT NULL,
    weight DECIMAL(6,2) NOT NULL CHECK (weight > 0)
    PRIMARY KEY (course_num, term, section_num, name),
    FOREIGN KEY (course_num, term, section_num) REFERENCES class (course_num, term, section_num)
);

-- Defines the attribute of an Assignment.
CREATE TABLE ASSIGNMENT (
    course_num VARCHAR(16) NOT NULL,
    term VARCHAR(8) NOT NULL,
    section_num INT NOT NULL,
    name VARCHAR(64) NOT NULL,
    desc VARCHAR(255) NOT NULL CHECK (max_points > 0),
    PRIMARY KEY (course_num, term, section_num, name),
    FOREIGN KEY (course_num, term, section_num, category_name) REFERENCES class (course_num, term, section_num, name)
);

-- Defines the attribute of an Student.
CREATE TABLE STUDENT (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    last_name VARCHAR(64) NOT NULL,
    first_name VARCHAR(64) NOT NULL
);

-- Defines the attribute of Enrollment. In other words, defines the relationship between a Student and a Class.
CREATE TABLE ENROLLMENT (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_num VARCHAR(16) NOT NULL,
    term VARCHAR(8) NOT NULL,
    section_num INT NOT NULL,
    student_id INT NOT NULL,
    UNIQUE (course_num, term, section_num, student_id),
    UNIQUE (enrollment_id, course_num, term, section_num),
    FOREIGN KEY (course_num, term, section_num) REFERENCES class (course_num, term, section_num),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);

-- Defines the grades of a Student for a given Assignment.
CREATE TABLE GRADES (
  enrollment_id INT NOT NULL,
  course_num VARCHAR(16) NOT NULL,
  term VARCHAR(8) NOT NULL,
  section_num INT NOT NULL,
  name VARCHAR(64) NOT NULL,
  points DECIMAL(8,2) NOT NULL CHECK (points >= 0),
  PRIMARY KEY (enrollment_id, name),
  FOREIGN KEY (enrollment_id, course_num, term, section_num) REFERENCES enrollment (enrollment_id, course_num, term, section_num),
  FOREIGN KEY (course_num, term, section_num, name) REFERENCES assignment (course_num, term, section_name, name)
);
