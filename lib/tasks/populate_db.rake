
namespace :populate_db do
  desc 'All'
  task all: [
    :import_from_csv,
    :insert_into_users_from_select_userseeds,
    :populate_roles, :populate_organizations,
    :update_users_roles_from_csv, :update_users_organizations_from_csv
  ]
  
  desc "It populates database from a .csv file"
  task import_from_csv: :environment do
    csv_filename = 'import_users_from_csv.sql'
    
    puts "> Importing data from #{File.expand_path(csv_filename, '../sycomm-api/db/scripts')}..."
    ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))
    
    puts ">> END\n"
  end

  desc "Insert into 'users' from select from 'user_seeds'"
  task insert_into_users_from_select_userseeds: :environment do
    puts "> Inserting into 'users' from select from 'user_seeds'..."
    query = " CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";
              INSERT INTO users(name, cpf, registration, type, simple_address, created_at, updated_at, uid, provider)
              SELECT name, cpf, registration, 'Customer', simple_address, NOW(), NOW(), uuid_generate_v4(), 'email'
              FROM user_seeds;"
    # query = " INSERT INTO users(name, email, cpf, registration, type, simple_address, created_at, updated_at, uid, provider)
    #           SELECT name, LOWER(CONCAT(TRIM(SUBSTR(name, 1, (POSITION(' ' IN name)))), registration || '@mail.com')), cpf, registration, 'Customer', simple_address, NOW(), NOW(), LOWER(CONCAT(TRIM(SUBSTR(name, 1, (POSITION(' ' IN name)))), registration || '@mail.com')), 'email'
    #           FROM user_seeds;"

    ActiveRecord::Base.connection.execute(query)

    puts ">> END\n"
  end

  desc "Populate 'roles' table"
  task populate_roles: :environment do
    puts "> Populating 'roles' table..."
    roles = [
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

    roles.each do |r|
      Role.create(name: r)
    end

    puts ">> END\n"
  end
  
  desc "Populates 'organizations' table"
  task populate_organizations: :environment do
    puts "> Populating 'organizations' table"

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
      Organization.create(name: o)
    end

    puts ">> END\n"
  end

  desc "Updates all customers role reference with synced value from csv file"
  task update_users_roles_from_csv: :environment do
    puts "> Updating customers role reference with synced value from csv file..."
    
    csv_filename = 'update_customers_roles_from_csv.sql'

    # ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))

    ActiveRecord::Base.connection.execute("
      DO $$
      DECLARE
        v_registration VARCHAR(255);
        v_role_id INTEGER;
        c_roles CURSOR FOR 
          SELECT us.registration, r.id as role_id
          FROM user_seeds us 
          INNER JOIN users u
            ON us.registration = u.registration
          INNER JOIN roles r
            ON us.role = r.name
          WHERE u.type = 'Customer';
      BEGIN
        OPEN c_roles;
      
        LOOP
          FETCH c_roles INTO v_registration, v_role_id;
          EXIT WHEN NOT FOUND;
      
          -- raise notice 'v_reg: %', v_registratoin;
          -- raise notice 'v_role_id: %', v_role_id;
          -- raise notice '---';
          
          UPDATE users
          SET role_id = v_role_id
          WHERE registration LIKE v_registration;
        END LOOP;
      
        CLOSE c_roles;
      END$$;
    ")

    puts ">> END\n"
  end

  desc "Updates all customers organization reference with synced value from csv file"
  task update_users_organizations_from_csv: :environment do
    puts "> Updating customers organization reference with synced value from csv file..."
    
    csv_filename = 'update_customers_organizations_from_csv.sql'

    # ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))

    ActiveRecord::Base.connection.execute("
      DO $$
      DECLARE
        v_registration VARCHAR(255);
        v_organization_id INTEGER;
        c_organizations CURSOR FOR 
          SELECT us.registration, r.id as organization_id
          FROM user_seeds us 
          INNER JOIN users u
            ON us.registration = u.registration
          INNER JOIN organizations r
            ON us.organization = r.name
          WHERE u.type = 'Customer';
      BEGIN
        OPEN c_organizations;
      
        LOOP
          FETCH c_organizations INTO v_registration, v_organization_id;
          EXIT WHEN NOT FOUND;
      
          -- raise notice 'v_reg: %', v_registratoin;
          -- raise notice 'v_organization_id: %', v_organization_id;
          -- raise notice '---';
          
          UPDATE users
          SET organization_id = v_organization_id
          WHERE registration LIKE v_registration;
        END LOOP;
      
        CLOSE c_organizations;
      END$$;
    ")

    puts ">> END\n"
  end
end
