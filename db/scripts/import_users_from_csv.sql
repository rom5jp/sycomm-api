COPY user_seeds(name, registration, public_agency, public_office, cpf, simple_address)
FROM '/home/romero/Documentos/Sycomm/pb.csv' DELIMITER ',' CSV HEADER;