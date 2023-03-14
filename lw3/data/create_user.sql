DROP USER 'wiki-backend-app'@'%';
CREATE USER 'wiki-backend-app'@'%' IDENTIFIED BY 'kUUTyU7LssSc';

DROP DATABASE wiki_backend;
CREATE DATABASE wiki_backend;
GRANT ALL ON wiki_backend.* TO 'wiki-backend-app'@'%';
