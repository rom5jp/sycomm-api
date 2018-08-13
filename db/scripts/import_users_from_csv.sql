COPY user_seeds(name, registration, public_agency, public_office, cpf, simple_address)
FROM '../clientes.csv' DELIMITER ',' CSV HEADER;