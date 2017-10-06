# grant % to root connection
USE mysql;
UPDATE user SET host='%' WHERE host='localhost' AND user='root';
FLUSH PRIVILEGES;
