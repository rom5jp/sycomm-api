
namespace :populate_db do
  desc 'All'
  task all: [
    :import_from_csv,
    :insert_into_users_from_select_userseeds,
    :populate_public_offices,
    :populate_public_agencies,
    :update_users_public_offices_from_csv,
    :update_users_public_agencies_from_csv
  ]

  desc "It populates database from a .csv file"
  task import_from_csv: :environment do
    csv_filename = 'import_users_from_csv.sql'

    puts "> Importing data from #{File.expand_path(csv_filename, 'db/scripts')}..."
    ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, 'db/scripts')))

    puts ">> END\n"
  end

  desc "Insert into 'users' from select from 'user_seeds'"
  task insert_into_users_from_select_userseeds: :environment do
    puts "> Inserting into 'users' from select from 'user_seeds'..."
    query = " CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";
              INSERT INTO users(name, cpf, registration, type, simple_address, created_at, updated_at, uid, provider)
              SELECT name, cpf, registration, 'Customer', simple_address, NOW(), NOW(), uuid_generate_v4(), 'email'
              FROM user_seeds;"

    ActiveRecord::Base.connection.execute(query)

    puts ">> END\n"
  end

  desc "Populate 'public_offices' table"
  task populate_public_offices: :environment do
    puts "> Populating 'public_offices' table..."
    public_offices = [
      'Aposentado',
      'Aposentado/Pensionista',
      'Efetivo',
      'Prestador',
      'Militar',
      'Reformado',
      'Comissionado',
      'Sem Vinculo (Requisitados e Outros)',
      'CLT',
      'Pensionista',
      'Estagiario'
    ]

    public_offices.each do |po|
      PublicOffice.create(name: po)
    end

    puts ">> END\n"
  end
  
  desc "Populates 'public_agencies' table"
  task populate_public_agencies: :environment do
    puts "> Populating 'public_agencies' table"

    orgs = [
      'PBPREV - INATIVOS',
      'PBPREV - PENSIONISTAS',
      'SECRETARIA EDUCACAO E CULTURA',
      'PENSAO DO TESOURO',
      'POLICIA MILITAR ESTADO',
      'SECRETARIA DA SAUDE',
      'Não Informado',
      'PBPREV - REFORMADO',
      'SECRETARIA SEGURANCA PUBLICA',
      'SECRETARIA TRAB. E ACAO SOCIAL',
      'SECRETARIA DA ADMINISTRACAO',
      'SECRETARIA DA RECEITA ESTADUAL',
      'GABINETE MILITAR',
      'SEC CIDADANIA E JUSTICA',
      'GABINETE DO VICE-GOVERNADOR',
      'SEC IND.COM.TUR.CIENC.TECNOL.',
      'SEC. ARTICULACAO MUNICIPAL',
      'SECRETARIA DA INFRA-ESTRUTURA',
      'SEC AGRIC IRRIG ABASTECIMENTO',
      'FALECIDOS PARA CALCULO DE PENS',
      'SEC PLANEJAMENTO E GESTAO',
      'GABINETE CIVIL',
      'PROCURADORIA GERAL DO ESTADO',
      'SEC.EXT.COMUNIC.INSTITUCIONAL',
      'SEC. CONTROLE DESPESA PUBLICA',
      'SECRETARIA ESPORTE E LAZER',
      'SECRETARIA DAS FINANACAS',
      'SEC. RECUR. HIDRIC. E MINERAIS',
      'SEC.EXT.ARTICUL.GOVERNAMENTAL',
      'SEC ACOMPANHAM. ACOES GOVERNAM'
    ]

    orgs.each do |o|
      PublicAgency.create(name: o)
    end

    puts ">> END\n"
  end

  desc "Updates all customers public_office reference with synced value from csv file"
  task update_users_public_offices_from_csv: :environment do
    puts "> Updating customers public_office reference with synced value from csv file..."
    
    csv_filename = 'update_customers_public_offices_from_csv.sql'

    # ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))

    ActiveRecord::Base.connection.execute("
      DO $$
      DECLARE
        v_registration VARCHAR(255);
        v_public_office_id INTEGER;
        c_public_offices CURSOR FOR
          SELECT us.registration, r.id as public_office_id
          FROM user_seeds us 
          INNER JOIN users u
            ON us.registration = u.registration
          INNER JOIN public_offices r
            ON us.public_office = r.name
          WHERE u.type = 'Customer';
      BEGIN
        OPEN c_public_offices;
      
        LOOP
          FETCH c_public_offices INTO v_registration, v_public_office_id;
          EXIT WHEN NOT FOUND;
      
          -- raise notice 'v_reg: %', v_registratoin;
          -- raise notice 'v_public_office_id: %', v_public_office_id;
          -- raise notice '---';
          
          UPDATE users
          SET public_office_id = v_public_office_id
          WHERE registration LIKE v_registration;
        END LOOP;
      
        CLOSE c_public_offices;
      END$$;
    ")

    puts ">> END\n"
  end

  desc "Updates all customers public_agency reference with synced value from csv file"
  task update_users_public_agencies_from_csv: :environment do
    puts "> Updating customers public_agency reference with synced value from csv file..."
    
    csv_filename = 'update_customers_public_agencies_from_csv.sql'

    # ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))

    ActiveRecord::Base.connection.execute("
      DO $$
      DECLARE
        v_registration VARCHAR(255);
        v_public_agency_id INTEGER;
        c_public_agencies CURSOR FOR
          SELECT us.registration, r.id as public_agency_id
          FROM user_seeds us 
          INNER JOIN users u
            ON us.registration = u.registration
          INNER JOIN public_agencies r
            ON us.public_agency = r.name
          WHERE u.type = 'Customer';
      BEGIN
        OPEN c_public_agencies;
      
        LOOP
          FETCH c_public_agencies INTO v_registration, v_public_agency_id;
          EXIT WHEN NOT FOUND;
      
          -- raise notice 'v_reg: %', v_registratoin;
          -- raise notice 'v_public_agency_id: %', v_public_agency_id;
          -- raise notice '---';
          
          UPDATE users
          SET public_agency_id = v_public_agency_id
          WHERE registration LIKE v_registration;
        END LOOP;
      
        CLOSE c_public_agencies;
      END$$;
    ")

    puts ">> END\n"
  end
end
