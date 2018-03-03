
namespace :populate_db do
  desc 'All'
  task all: [:import_from_csv, :insert_into_users_from_select_userseeds, :populate_roles, :populate_organizations]
  
  desc "It populates database from a .csv file"
  task import_from_csv: :environment do
    csv_filename = 'import_users_from_csv.sql'

    # require 'csv'

    # csv_text = File.read('/home/romero/Documentos/Sycomm/pb.csv')
    # csv = CSV.parse(csv_text, :headers => true)
    
    # puts " ----- INICIANDO SEED DE #{csv.size} REGISTROS ------"

    # csv.each_with_index do |row, index|
    #   puts " > Criando usuário de número #{index}"
    #   User.create!(row.to_hash)
    # end
    
    puts "> Importing data from #{File.expand_path(csv_filename, '../sycomm-api/db/scripts')}..."
    ActiveRecord::Base.connection.execute(IO.read(File.expand_path(csv_filename, '../sycomm-api/db/scripts')))
    
    puts ">> END\n"
  end

  desc "Insert into 'users' from select from 'user_seeds'"
  task insert_into_users_from_select_userseeds: :environment do
    puts "> Inserting into 'users' from select from 'user_seeds'..."
    query = "INSERT INTO users (name, cpf, registration, type, created_at, updated_at)
              SELECT name, cpf, registration, 'Customer', NOW(), NOW()
              FROM user_seeds;"

    # ActiveRecord::Base.connection.execute("INSERT INTO ")
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
end
