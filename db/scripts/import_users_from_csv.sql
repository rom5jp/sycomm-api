LOAD DATA LOCAL INFILE '/home/romero/Documentos/Sycomm/pb.csv' 
INTO TABLE user_seeds 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, registration, organization, role, cpf, simple_address);