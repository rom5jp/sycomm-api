
namespace :populate_db do
  desc "Alimenta o banco a partir de um arquivo .csv"
  task import_from_csv: :environment do
    require 'csv'

    csv_text = File.read('/home/romero/Documentos/Sycomm/pb.csv')
    csv = CSV.parse(csv_text, :headers => true)
    
    puts " ----- INICIANDO SEED DE #{csv.size} REGISTROS ------"

    csv.each_with_index do |row, index|
      puts " > Criando usuário de número #{index}"
      User.create!(row.to_hash)
      # break
      # puts row.to_hash
    end

    puts " ----- FIM ------"
  end

  desc "Popula a tabela roles"
  task populate_roles: :environment do
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

    puts "--- Serão adicionados #{roles.length} roles: #{roles.to_s}"

    roles.each do |r|
      Role.create(name: r)
    end

    puts " --- FIM ---"
  end
  
  desc "Popula a tabela organizations"
  task populate_roles: :environment do
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

    puts "--- Serão adicionados #{orgs.length} organizations: #{orgs.to_s}"

    roles.each do |r|
      Role.create(name: r)
    end

    puts " --- FIM ---"
  end
end
