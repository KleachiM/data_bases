USE wiki_backend;

CREATE TABLE course
(
    course_id VARCHAR(36) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (course_id)
);

CREATE TABLE structure_state
(
    id INT AUTO_INCREMENT NOT NULL,
    state VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO structure_state (state) VALUES ('Active'), ('Deleted');

CREATE TABLE course_status
(
    enrollment_id VARCHAR(36) NOT NULL,
    progress DECIMAL(3,0) DEFAULT 0 NOT NULL,
    duration INT NULL,
    state_id INT,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY fk_state_id (state_id)
        REFERENCES structure_state (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE course_module_status
(
    enrollment_id VARCHAR(36) NOT NULL,
    module_id VARCHAR(36) NOT NULL,
    progress DECIMAL(3,0) DEFAULT 0,
    duration INT,
    state_id INT,
    PRIMARY KEY (enrollment_id, module_id),
    FOREIGN KEY fk_module_status (state_id)
        REFERENCES structure_state (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX idx_module_id (module_id)
);

CREATE TABLE course_enrollment
(
    enrollment_id VARCHAR(36) NOT NULL ,
    course_id VARCHAR(36) NOT NULL ,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY fk_course_status (enrollment_id)
        REFERENCES course_status (enrollment_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY fk_course_module_status (enrollment_id)
        REFERENCES course_module_status (enrollment_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY fk_course (course_id)
        REFERENCES course (course_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE course_material
(
    module_id VARCHAR(36) NOT NULL,
    course_id VARCHAR(36) NOT NULL,
    is_required BOOLEAN NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    state_id INT,
    PRIMARY KEY (module_id),
    FOREIGN KEY fk_course_id (course_id)
        REFERENCES course (course_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY fk_course_module_status (module_id)
        REFERENCES course_module_status (module_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY fk_material_status (state_id)
        REFERENCES structure_state (id)
        ON UPDATE CASCADE ON DELETE CASCADE
)