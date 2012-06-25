rm -Rf /etc/moodle_clients/*
rm -Rf /home/jeelos/*
mysql -uroot -ppaarse -e "TRUNCATE jeelo_buffer.client_categories ; TRUNCATE jeelo_buffer.client_courses ; TRUNCATE jeelo_buffer.client_moodles ; DROP USER 'testclient'@'localhost'; DROP DATABASE IF EXISTS testclient ;"
