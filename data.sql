CREATE TABLE user_groups
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(255) NOT NULL
);

CREATE TABLE modules
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    module_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE users
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES user_groups (id)
);

CREATE TABLE module_functions
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    module_id     INT                 NOT NULL,
    function_name VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (module_id) REFERENCES modules (id)
);

CREATE TABLE access_rights
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    user_id        INT,
    group_id       INT,
    module_id      INT,
    function_id    INT,
    access_granted TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (group_id) REFERENCES user_groups (id),
    FOREIGN KEY (module_id) REFERENCES modules (id),
    FOREIGN KEY (function_id) REFERENCES module_functions (id)
);

INSERT INTO user_groups (group_name) VALUES ('test_group');
INSERT INTO user_groups (group_name) VALUES ('test_group_2');

INSERT INTO modules (module_name) VALUES ('test_module');
INSERT INTO modules (module_name) VALUES ('test_module_2');

INSERT INTO users (username, group_id) VALUES ('testuser', 1);

INSERT INTO users (username, group_id) VALUES ('testuser_2', 2);

INSERT INTO module_functions (module_id, function_name) VALUES (1, 'test_function');

INSERT INTO module_functions (module_id, function_name) VALUES (2, 'test_function_2');

-- Direct access rights
INSERT INTO access_rights (user_id, group_id, module_id, function_id, access_granted)
VALUES (1, 1, 1, 1, 1);

-- Inherited access rights
INSERT INTO access_rights (user_id, group_id, module_id, function_id, access_granted)
VALUES (null, 2, 2, 2, 1);
