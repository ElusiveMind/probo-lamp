DROP USER 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'strongpassword';
CREATE USER 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'strongpassword';
CREATE USER 'root'@'::1' IDENTIFIED WITH mysql_native_password BY 'strongpassword';
GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO 'root'@'127.0.0.1';
GRANT ALL PRIVILEGES ON * . * TO 'root'@'::1';
FLUSH PRIVILEGES;
