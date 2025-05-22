CREATE TABLE admin (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);
INSERT INTO admin (username, password) 
VALUES ('admin', 'admin123');
