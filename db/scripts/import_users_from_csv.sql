COPY user_seeds(name, registration, organization, role, cpf, simple_address)
FROM '/home/romero/Documentos/Sycomm/pb.csv' DELIMITER ',' CSV HEADER;