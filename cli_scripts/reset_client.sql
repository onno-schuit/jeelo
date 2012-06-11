FLUSH PRIVILEGES;
UPDATE jeelo_buffer.client_moodles SET status='prepaired_school';
DROP DATABASE testclient;
DROP USER 'testclient'@'localhost';
FLUSH PRIVILEGES;

