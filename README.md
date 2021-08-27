# Alta Disponibilidade em Streaming de Dados Transacionais.

[![NPM](https://img.shields.io/npm/l/react)](https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/LICENSE) 

# About the project

Irei falar sobre conceitos de alta disponibilidade dos dados e suas infraestrutura e também iremos implementar uma arquitetura de Streaming Transacional Utilizando Oracle GoldenGate com 2 cenários de alta disponbilidade. o primeiro será Streaming de dados Transacionais entre 2 Database. o Database1 irei implementar o Redhat Enterprise Linux 7.4 com o Banco de dados Oracle 12c e no Database2 Redhat enterprise linux 7.4 com o MySQL 5.7 CE

No cenário 2 a replicação entre Banco Relacional e o nosso Data Lake(HDFS). Em uma máquina teremos o Redhat Enterprise linux 7.5 e o Banco de dados Oracle 12c e no Destino 2 VM (Cluster) CentOS 7 e Hadoop 3.x



## Porque? 

Porque esse trabalho faz sanar varias dúvidas sobre Alta disponbilidade e streaming de dados, conceitos que muda o paradigma da metodologia mais antigas de dados transacionais.

-Este projeto faz parte do meu portfólio pessoal, então ficarei feliz se você puder me fornecer qualquer feedback sobre o projeto, código, estrutura ou qualquer coisa que você possa relatar que possa me fazer um melhor engenheiro de dados!

Email-me: henricao_7@yahoo.com.br

Connect with me at [LinkedIn](https://www.linkedin.com/in/henrique-castro-484269203//).

## Iniciando o Projeto

Lembrando que cada etapa existe o script em anexo !!!

## Alta Disponibilidade em Streaming de Dados Transacionais.

Alta disponbilidade é a capacidade de um sistema executar a sua função de forma contínua (sem interrupção) por um período de tempo significativo e superior ao que a confiabilidade dos seus componentes individuais poderia sugerir.

## Alta Disponibilidade deve levar em consideração diversos fatores:

- Ambiente
- Hardware
- Software
- Dados
- Rede

O Termo Alta disponibilidade, quando aplicado a sistemas de tecnologia, significa que a aplicação ou serviço em questão está permanentemente disponível, independentemente da hora do dia, local ou outros fatores que possam influenciar a disponibilidade de tal recursos.

![1]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/1.png

De Acordo com uma pesquisa recente feita com pequenas e médias empresas, a principal causa do tempo de inatividade foi falha no Hardware (55%), seguida por falha humana (22%), falha de software (18%) e desastres naturais (5%). O tempo médio de recuperação foi de aproximadamente 30h.

## Estrategia para evitar o Downtime

-1 Redundância > eu preciso de backup, preciso de servidor espelho, redundância de disco, mais de um link de conexão. Você pode ter um servidor de backup em outra região, mais de um provedor de ambiente em nuvem.

2 – Monitoramento > eu preciso saber quando ocorre o Downtime e que ação eu tomo quando Downtime ocorrer, qual minha estratégia de redundância

## A importância do RAID – RAID0, RAID 1 e RAID 5

RAID é a abreviação para Redundant Array of Independent Disks, ou em tradução livre, conjunto redundante de discos independentes. Essa tecnologia é baseada em montar arranjos onde dois ou mais hard drives e/ou memórias SSDS trabalharão em conjunto, com o intuito de aprimorar a segurança e performance de computadores, servidores e storages.

![2]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/2.png



![3]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/3.png

A lógica por traz do raid0 consiste em distribuir os dados a serem armazenados no sistema gravando a informação particionada em diversos HDs de forma simultânea, ou seja, dessa forma tanto a gravação quanto as leituras dos dados utilizam todos os discos do arranjo sem necessidade de nem um cálculo para geração de paridade o que é feito no RAID5. Em consequência do alto desempenho do RAID0 nós perdemos em questão de segurança porque ele não proporciona nem uma tolerância a falha eu não usaria RAID 0 em nem um sistema que estou trabalhando, mas é bom saber o que é possível.
![4]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/4.png

![5]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/5.png


O RAID5 é uma das principais alternativa para ambiente profissional de Produção e partir disso temos várias variantes de arranjos de discos. O método é bastante usado em servidores e nós precisamos de pelo menos 3 discos rígidos instalados e ainda uma camada de redundância o que claro acaba sacrificando um pouco da capacidade do sistema para segurança dos dados no RAID5 os bits de paridade eles são criados e acrescentado aos dados então são gravados de forma alternadas nós discos caso algum do HDs venha a falhar nem um dado será perdido porque a paridade é a segurança do sistema que possibilidade a reconstrução dos dados sem perda de informação o RAID5 é muito recomendado para aplicações do dia-a-dia. Claro que teremos uma perda de performance porque o objetivo é garantir Alta Disponibilidade que você não vai perde os dados e seu sistema vai continuar rodando mesmo que fique mais lento durante um período até reconstrução dos dados mas mesmo assim o sistema vai estar up and running. Na AWS podemos configurar as RAID.

![6]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/6.png

Uma explicação da própria Cloudera o RAID é basicamente utilizado para redundância entretanto, o HDFS já tem isso internamente o HDFS foi construído levando em consideração a falha de hardware e por isso que um bloco de dados no HDFS é replicado pelo menos 3 vezes. Mas podemos usar claro nos NodeMaster um RAID até porque se você perde o NodeMaster você perde o cluster temos que claro garantir alguma redundância no NodeMaster mas é claro isso e 1 máquina no seu ambiente ou 2 máquinas se estiver trabalhando com alta disponibilidade os DataNodes pode ser centenas ou milhares nós não utilizamos RAID.

## Oracle GoldenGate

![14]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/14.png

![15]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/15.png

## Oracle Big Data Platform

![16]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/16.png
![17]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/17.png
![18]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/18.png


![19]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/19.png
![20]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/20.png


## Em que momento devemos aplicar um ELT? Existe basicamente uma pequena regra que ajuda por escolher uma arquitetura ou outra.

- Usamos ETL quando não temos a capacidade computacional suficiente na fonte ou no destino.

- Usamos ELT quando temos capacidade computacional suficiente na fonte ou no destino.

## Arquitetura do ODI

O ODI é na verdade uma grande plataforma de integração de dados.

![21]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/21.png

O Oracle Data Integrator (ODI) é uma ferramenta de extração, carregamento e transformação (ELT) (Em contraste com a abordagem comum ETL) produzida pela Oracle que oferece um ambiente gráfico para criar, gerenciar e manter processos de integração de dados em sistemas de Business Intelligence e Big Data.
ODI oferece KMs (Knowledge Modules) para fontes e destinos.

![22]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/22.png

![23]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/23.png

O Oracle GoldenGate é para integração de dados em tempo real. Esse é o próximo passo na evolução em processamento de dados. O Oracle GoldenGate é um Pacote de Software para integração e replicação de dados em tempo real em Ambientes de TI heterogêneos.
O Oracle GoldenGate permite soluções de alta disponibilidade, integração de dados em tempo real, captura de dados transacionais, replicação de dados, transformações e verificação entre sistemas corporativos operacionais e analíticos.
O Oracle GoldenGate oferece uma plataforma de Software de replicação baseada em Log em tempo real para atender às necessidades dos aplicativos atuais orientados por transações. O Software fornece captura, roteamento, transformação e entrega de dados transacionais em bancos de dados heterogêneos em tempo real. Usando essa tecnologia, os clientes podem obter disponibilidade contínua para sistemas críticos e integração de dados em tempo real para acesso rápido e fácil a dados atuais e precisos em bancos de dados homogêneos e heterogêneos.


![24]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/24.png

Ele vai trabalhar apenas nas modificações por isso o conceito do CDC (Change Data Capture), ou seja, ele vai olhar para aquilo que foi modificado se não ouve modificação porque ele vai levar os dados? No caso de uma query SQL isso é muito mais difícil se você não tiver um campo especificando a DATA de modificação do registro eu nem tenho como saber se o registro foi modificado ou não.

![25]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/25.png


Independentemente de trabalhar com Big Data ou qualquer outro tipo de sistema eu tenho a Extração o Pump e o Collector, ou seja, vou coletar os dados da fonte vou movimentar para o destino e vou coletar e gerar um Trail File. Eles simplesmente converteram o Trail File para um formato que possa ser lido pelo HDFS, HBase e etc... 

Imagine que você tem banco de dados relacionais espalhado por regiões geográficas diferentes e você precisa trazer esses dados para o seu Data Lake dependendo do caso o Golden Gate pode ser a melhor opção. O Golden Gate não é evasivo, ou seja, ele não vai ao sistema ele vai aos LOG’s com isso ele praticamente não tem impacto, o impacto é quase mínimo na fonte ele traz apenas as mudanças dos dados. Então o volume de dados que ele trafega é muito menor e com isso você vai manter a integridade das transações, ou seja, se eu tiver vários bancos de dados espalhados por várias regiões o Golden Gate pode trazer esse streaming transacional para o seu Data Lake. Se eu fizer isso com o ODI significa ter que executar várias Querys em cada um desses banco de dados espalhados geograficamente, se eu utilizar o Sqoop é a mesma coisa o Sqoop também executa um query no sistema fonte, se eu tentar usar o apache flume eu não consigo trazer os Logs transacionais, se eu tentar usar o apache Kafka eu teria que desenvolver um programa em Java para fazer a leitura dos arquivos de Logs então a empresa tem que avaliar o que é melhor. Muita empresa opta por gerar um arquivo txt todo dia a noite movimenta o txt para o outro lado durante a noite pega o txt e carrega no Data Lake, ok funciona também, mas não é integração em tempo real.

![26]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/26.png

Entretanto o Golden Gate não permite você fazer transformação nós dados, isso mesmo não existe ferramenta perfeita, ou seja, se eu quiser transformar esses dados eu tenho que carregar no Data Lake e aplicar depois algum processo. Podendo aplicar o ODI.

![27]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/27.png

Então o ODI ele poderia ser usado para pegar os dados por exemplo lá no Hive. Sendo um Staging Area eu pego o ODI conecto nesse Hive processo esses dados transformo os dados de acordo com os requisitos de negócio e carrego em uma outra instancia do Hive e assim alimentar uma ferramenta analítica. O ODI tem uma vantagem que você pode isolar o modelo lógico, ou seja, se hoje eu tenho o Hive eu extraio os dados e levo para um destino, mas a lógica dessa transformação fica no ODI se amanhã não estiver usando o HIVE é só tirar ele e colocar a nova solução e a minha lógica de transformação é a mesma. Se você não quiser usar o ODI você pode também usar uma linguagem Python, R, Java, Scala desenvolve uma aplicação para fazer a manipulação de dados roda o processo no banco de dados

![28]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/28.png
![29]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/29.png
![30]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/30.png



## irei implementar 2 projetos eles são: 

![7]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/7.png

No cenário 1, iremos trabalhar com replicação entre bancos relacionais. Vamos montar 2 Databases relacionais e faremos uma replicação em tempo real usando streaming relacional. A medida que uma transação for feita no Database1 nós vamos selecionar quais dados dessa transação serão levados para o DataBase2. Existe várias replicações desse cenário podemos criar um banco de dados de Backup, podemos cria um banco de dados de leitura considerando claro o DataBase2, podemos criar um banco de dados apenas para consulta, poderíamos criar uma espécie de Subset do Database1. O database1 seria o banco principal de uma aplicação transacional qualquer como um CRM, ERP e você não precisa de todos aqueles dados transacionais então iremos selecionar um Subset “alguns” e leva isso para um 2 Database e nesse 2 você pode utilizar uma ferramenta de análise de dado ou você pode aplicar um outro modelo de Machine Learning e etc.



![8]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/8.png

Esse é um trabalho detalhista precisa ficar atento a tudo que está sendo feito eventualmente o DBA tem que ser envolvido o engenheiro de dados não tem que realizar todas as configurações de privilégio do banco de dados quem faz isso é o DBA o Engenheiro de dados configura o pipeline de dados então a configuração do Golden Gate pode ser feito pelo engenheiro de dados mas a configuração do banco de dados em si normalmente e trabalho de um DBA. No momento que você implementa a ligação entre os dois bancos o que nós temos é na verdade um Pipeline de Streaming transacional em tempo real se o destino cair por algum motivo eu não perco as transações quando o banco de dados destino voltar nós teremos todas as transações na fila para serem executadas. Fiz outro exemplo deletando um dos inserts que fiz e ele faz a remoção no destino na mesma hora. O da Esquerda é o banco fonte de produção e o do lado direito é a replica em REAL TIME das transações da fonte.
Temos um Streaming transacional em tempo real onde os dados da fonte são automaticamente atualizados no destino em nível de TRANSAÇÃO, aqui eu fiz a transação da tabela inteira, mas eu poderia selecionar apenas algumas colunas dessa tabela, apenas algumas linhas especificas dentro da minha transação, eu poderia eventualmente colocar uma regra para geração de conflitos se eu tiver dois registros conflitando no destino eu posso definir qual vai ser a regra final tudo isso pode ser feito com Golden Gate.

![9]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/9.png


Iremos construir um ambiente de replicação entre um Banco Relacional e o HDFS considerando claro que o HDFS seria o nosso Data Lake.

A instância é uma área de memória que gerencia os arquivos físicos que são os bancos de dados é um conceito do banco oracle nós inclusive podemos ter duas áreas de memória, duas instâncias gerenciando os mesmos arquivos físicos quando trabalhamos com cluster Oracle principalmente com Oracle Rack um conceito bastante comum para alta disponibilidade no Oracle.
Comandos >>
Lsnrctl start 
Sqlplus / as sysdba Vamos iniciar o Banco > startup nomount  (nesse momento você faz a inicialização da instância mas não monta o banco de dados)
Agora vamos montar o banco > alter database mount; (quando você faz isso você apenas monta o banco de dados mas ainda não abri o banco de dados não está aberto para acesso externo eu estou acessando porque eu sou o admin o usuário system.
Agora com o banco montado eu posso fazer configuração uma delas e o > alter database archivelog; (o arquive log tem que estar habilitado se não estiver você não gera as copias das transações do banco de dados. O que é arquivelog? E você pegar o arquivo de log da transação e fazer uma cópia, toda transação no Banco Oracle por padrão é gravada em um arquivo de log mas quando esse arquivo fica cheio ele e substituído por outro vazio e depois ele fica rotacionando são 3 arquivos por padrão então ele fica limpando esses arquivo de log resultado eu perco o histórico de transações do banco para não perde o histórico temos que ATIVAR o archivelog isso claro tem o efeito colateral que eu fico com dezenas de arquivos de archivelog mas é também uma forma de voltar um Backup caso você tenha uma perda do banco de dados eu consigo voltar todas as transações até o último ponto. Com o archivelog como eu tenho as transações o que o GoldenGate faz ele pega exatamente esses arquivos de transações e envia para o destino isso é basicamente a replicação de streaming de dados.
Agora podemos abrir o banco> alter database open; (agora sim o banco está em operação)
Feito isso usaremos> alter database add supplemental log data; (neste momento estou ativando o supplemental log data)
Vamos agora ativar o force logging> alter database force logging; 
Vamos verificar se foi> select supplemental_log_data_min, force_logging from v$database;
Ok está perfeito isso é necessário para que possamos utilizar o Golden Gate para fazer a replicação dos dados.
Por último vamos alterar também o parâmetro de replicação do Golden Gate para ativa-lo, para garantir que eu não tenho problemas mais tarde durante a replicação o comando é o >>>> alter system set enable_goldengate_replication=true sid=’*’ scope=both;
(isso é alterar um parâmetro do banco online eu também posso fazer o parâmetro off-line e reiniciar o banco são 2 formas de você trabalhar com o banco de dados, existem mais de 205 parametros do banco de dados oracle esse é um parâmetro enable_goldengate_replication eu estou dizendo que é igual a true porque eu quero ativar esse parâmetro para qual banco de dados? Sid é o nome do banco e para todos ‘*’ e o scope eu estou alterando esse parâmetro tanto online quanto off-line, ou seja, esse parâmetro é gravado localmente no arquivo de parâmetro do Oracle então quando eu reiniciar o banco de dados eu não preciso executar esse comando porque já está ativado o parâmetro de replicação.
E para concluir as configurações no banco de dados fonte precisamos criar um Squema que será o responsável pelos dados que serão replicados desse banco transacional para o cluster HDFS.
Abre o banco de dados> sqlplus / as sysdba
E vamos criar um usuário> create user ggtest identified by “senha” default tablespace users temporary tablespace temp; 
E vamos conceder privilegio a esse usuário> grant connect, resource to ggtest (esse é o nosso usuário de aplicação é um usuário que é o Squema no banco de dados Oracle e dentro dele estarão os dados que serão replicados. O Oracle é dividido em Squema cada Squema é um usuário dentro de cada Squema nós criamos a tabelas, índices, funções e outros objetos de banco de dados isso nos permite isolar completamente um Squema do outro cada Squema no Oracle é como se fosse um mini banco de dados para verificar uma view de sistema> desc dba_users 
Próximo passo é verificar como esta as configurações do Golden Gate Manager e inicializar os serviços. Vamos alterar esses parâmetros para poder preparar a 1 extração de dados e então a replicação On-line, ou seja, vou deixar a fonte toda pronta e depois nós vamos para o nosso destino que é o Apache Hadoop.
Entrando no diretório de parâmetros cd dirprm/ no cd $GGH você pode fazer tudo pelo console do .ggscin do Golden Gate mas uma vez que você entende que tudo não passa de arquivo fica muito mais fácil veja que temos 3 arquivos. MGR / INSRC / PUMPINT no mgr nós temos a porta do gerenciador no INSRC temos extração de dados do banco oracle utilizando o ggadmin aqui temos as informações do parâmetros e tamanho de memória o EXTTRAIL, ou seja, o diretório onde ele vai colocar todo os trail q ele extrair nada mais é que o conjunto de transações  trocaremos o usuário que criamos TABLE ggtest.*.; então todas as tabelas e todos os objetos do ggtest que vamos extrair. É possível você criar mais de 1 usuário para gerenciar o Golden Gate eu posso deixar o ggadmin apenas para gerenciar a replicação de transação entre banco relacionais e podemos criar por exemplo ggadmin2 para gerenciar a replicação entre o banco transacional e o HDFS assim eu consigo segmentar completamente até porque eu posso ter 2 administradores diferentes com configurações diferentes, arquivos diferentes e etc. e no PUMPINT ele vai extrair o pump nada mais é que o conjunto de transações e vai enviar para o HDPMASTER que é o nosso destino o hdfs. O que estou dizendo é depois que você tiver feito a extração colete isso como um pump e enviar para o outro servidor o HDFS na port 7809 ele vai extrair a partir do diretório dirdat/pn e vai pegar tudo que for de ggtest porque eu posso ter no arquivo de trail outros Squemas tabelas de outros usuários mas quero apenas do ggtest
Agora a fonte de dados está perfeitamente pronta podemos ir para o destino.
Agora vamos configurar a outra perna um cluster do Apache Hadoop especificamente o HDFS que é o nosso Data Lake. E como vamos configurar o HDFS? Nós precisamos de um software que é o HDFS Handler. Um dos objetivos do Golden Gate é movimentar dados entre ambientes heterogêneos se você tiver como fonte de dados o Oracle, Mysql eu posso levar dados transacionais para qualquer um desses ambiente FLUME, HBASE, KAFKA e etc. mas pra isso eu preciso do adaptador o HANDLER mas lembre-se caso o seu destino permita conexão via JDBC por exemplo no site da oracle não tem o HANDLE para sqlserver não tem nem um adaptador mas banco SQL permite você conectar via JDBC.
Instalando o Oracle Golden Gate Big Data Adapter nada mais é que você descompactar o arquivo coloca no diretório ajusta as variáveis de ambiente e pronto já tenho o Adaptador lembrando que precisa ser feito onde está o hadoop o NameNode o Master. 
Eu instalei o Golden Gate lá no banco Oracle, poderia ser mysql ou outro banco e agora estou instalando o adapter no meu destino que nesse caso está com Apache Hadoop.
Configurando o Adaptador com o console aberto ./ggsin no diretório $GGH você precisa criar os subdirs comando> create subdirs (nesse momento ele cria diretorio de parâmetros, report, checkpoint e etc... 
Na sequência vamos editar os parâmetros do Manager> edit params mgr (colocando a PORT) e depois digita start manager e pronto manager startado. A partir daqui tudo que precisamos fazer é editar os arquivos com aquilo que eu quero replicar para o HDFS.
Precisamos agora configurar os Arquivos de parâmetro do Golden Gate adapter para replicação e carga inicial. Para ficar mais fácil a Oracle já disponibiliza alguns arquivos de exemplo uns teamplates e podemos utilizar para começar nossa configuração. Ele fica no diretorio $GGH e depois no diretório adapter depois entra no diretorio big-data e tem alguns exemplos. E fazemos uma cópia desses arquivos para o diretório de parâmetros cp *.* /u01/oggbd/dirprm (quando você entra você percebe o MGR com a PORT, um arquivo de parâmetro com o manager do Golden Gate um arquivo de parâmetro para replicação que é o .props e um arquivo de parâmetro para carga inicial ou outras operações que é o arquivo .prm
Primeiro configuramos o arquivo de replicação .props todos os parâmetros estão especificado na documentação do Oracle
Depois configuramos o Arquivo de carga inicial de dados no hdfs e depois para manter a carga rotineira, ou seja, em tempo real. Não é necessário utilizar o Golden Gate para carga inicial de dados você pode perfeitamente utilizar uma outra plataforma como por exemplo o Apache Sqoop para efetuar carga de dados em Batch. Imagina o seguinte eu quero replicar dados do Oracle para o HDFS eu já tenho uma tabela com 1 milhão de linhas eu posso pegar essa tabela com Apache SQOOP e carregar os dados no HDFS isso é carga inicial depois eu configuro o Golden Gate para fazer a replicação do Streaming Transacional em tempo Real ou então eu uso o Golden Gate para carga inicial e depois para replicação do Streaming como nossa tabela é pequena compensa usar o Golden Gate se a tabela estivesse muito grande talvez fosse melhor fazer a carga em Batch e podemos usar o ODI ou Pentaho, claro e alguma ferramenta que leve até o HDFS esses são alguns exemplo.
Repare que o arquivo que copiamos do Teamplate da oracle HDFS o arquivo rhdfs.rpm não é carga inicial na verdade ele é para replicação então precisamos fazer uma cópia desse arquivo que eu vou chamar de irhdfs.rpm e esse arquivo eu vou configurar para carga inicial e depois a configuração de replicação que é o rhdfs.rpm
A possibilidade de dar de cara com erro durante todo esse processo é muito grande no meu caso tive que configurar o Sistema Operacional Linux, Banco de dados Oracle, Cluster HDFS, configurar o Golden Gate na Fonte e no destino, e agora inicializar a replicação, ou seja, são grandes as chances de você ter algum erro absolutamente normal somos todos seres humanos esteja preparado para o erro. O erro é uma excelente oportunidade de aprendizado!

Vamos lá !!!

![10]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/10.png


Com as 4 VM inicializadas elas são o DataBase server – Prod com a fonte e o Cluster hadoop com o NameNode(máster) e os 2 DataNode(slaves)
Vamos inicializar os serviços da Fonte, primeiro o listen comando > lsnrctl start 
Depois vamos inicializar o banco sqlplus / as sysdba depois o comando > startup 
Pronto inicializado pode dar um exit
Agora damos um > source .bash_profile para ir para o diretório cd $GGH e vamos abrir o console do Golden Gate ./ggsci
Agora vamos inicializar o Manager do Golden Gate na fonte > start manager 
Pronto a fonte está pronta agora no Destino no cluster hadoop vamos dar um stop no firewall dos cluster > sudo service firewalld stop nas 3 máquinas Master, Slave1 e Slave2

![11]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/11.png

Para que isso não atrapalhe. E agora vamos inicializar o cluster com o comando >> $HADOOP_HOME/sbin/start-dfs.sh

![12]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/12.png


Comando jps para verificar se está tudo ok! E pronto o cluster está perfeitamente rodando.
Agora vou abrir o ./ggsci no Master e iniciar o manager > start manager pronto !!!
Agora precisamos checar os parâmetros lá na fonte do Golden Gate mais uma vez e trocar a PORT que estava como PORT 7809 e a gente colocou no nosso destino 7839 
Agora tenta fazer uma conexão de ping da fonte para o hdpmaster > ping hdpmaster aqui foi perfeitamente caso tenha algum problema verifique o arquivo hosts no diretório home >>>>>>> vi /etc/hosts e coloca o ip das máquinas hdpmaster e faz a mesma coisa lá no destino só que adiciona o id da fonte e tende novamente lembrando que quando dar erro é uma excelente forma de aprendizado e hora de treinar troubleshooting pesquisa no google, verifica se na hora da criação das VM você colocou lá nas configuração de Rede Bridged Adapter, tenta verificar os parâmetros da fonte e do destino e qualquer coisa estou à disposição só me chamar!!! 
Nosso ambiente está totalmente ligado agora preciso inicializar a replicação.
Agora lá na fonte iremos criar uma Tabela no Squema e inserir alguns registros vou então fazer a primeira extração e vou ativar a replicação On-Line depois vamos para o destino e vamos fazer a mesma coisa para que eu possa receber os dados lá no Hadoop. Lembrando que os comandos estão em anexo do projeto e não esquece do commit; depois de inserir registro!!!

Ainda na fonte precisamos criar um arquivo lá no ./ggscin porque nesse caso nós temos uma tabela com apenas 3 registros então o Golden gate vai dar conta do recado sem nem um problema se a tabela tivesse milhões de registro o ideal seria fazer uma carga em Batch Então vamos criar um arquivo de parâmetro chamada init_ext.prm o que nós temos nesse arquivo basicamente é conexão ggadmin no banco orcl que é o meu banco com a senha eu então vou coletar os dados e vou levar para o hdpmaster na porta 7839 e vou levar os dados e grava-los no diretório initld com arquivos de 2 MEGABYTES e vou fazer isso extraindo todos os dados do ggtest, ou seja, essa primeira extração simplesmente pega as transações do banco grava em um arquivo de TRAIL e leva para o destino só isso mais nada, ainda não efetuando a carga no HDFS primeiro eu estou extraindo para carga inicial e vou levar para o destino. 

Agora vamos digitar o comando para extração no diretorio cd $GGH diretório raiz onde você também executa o ./ggsci o comando é > ./extract paramfile dirprm/init_ext.rpm reportfile dirrpt/init_ext.rpt (o extract é o meu binário é o executável, paramfile é o nome de arquivo de parâmetro que acabamos de criar dirprm/init_ext.rmp e o arquivo de relatório  para saber tudo q foi feito o report e também o endereço onde encontramos esse arquivo) nesse momento estamos fazendo a primeira extração do banco de dados Oracle e os dados são levados para o destino você pode verificar o arquivo de report que acabamos de criar init_ext.rpt no diretorio dirrpt.
Perfeito conseguimos fazer a extração inicial do nosso banco fonte e levamos o arquivo para o destino depois vamos pegar esse arquivo e gravar no HDFS como carga inicial e então na sequência ativamos a replicação on-line entre os 2 ambientes.

Agora vamos ativar a replicação esse é o último passo na fonte agora cada vez que um registro foi inserido no banco de dados Oracle ele seja automaticamente enviado para o HDFS. Agora abrimos o console do Golden Gate > no diretório cd $GGH não esquece do source .bash_profile e usamos o comando > ./ggsci e agora vamos fazer a editar o parâmetro para replicação em tempo real comando> edit params ggext (ou seja, a extração do squema, ggtest) colocando os parâmetros vamos ativar a extração online> dblogin userid ggadmin@orcl, password ggadmin pronto agora o Golden Gate conectou no banco de dados vamos agora registrar a extração comando> register extract GGEXT database e nesse momento ele vai ativar a extração uma vez que você ativa a extração ela fica ativa até que você execute um comando para desativar

![13]https://github.com/pand-eX/Alta_disponibilidade_Streaming/blob/main/Alta%20Disponibilidade%20em%20Streaming%20de%20dados%20Transacionais/assets/13.png


Pronto minha extração já está registrada agora vou mandar inicializar minha extração comando é > add extract ggext, INTEGRATED TRANLOG, BEGIN NOW (perfeito extração já começou a replicação já está acontecendo online. Agora temos que configurar o destino
Na verdade, já configuramos os arquivos só precisamos executar a replicação agora as é feito no hpdmaster no NameNode no diretório raiz cd $GGH executamos a replicação com o comando> ./replicat paramfile dirprm/irhdfs.prm reportfile dirrpt/ini_rhdfs.rpt (replicat, ou seja, para executar a replicação / paramfile para que eu possa indicar o arquivo de parâmetro / que está no dirprm/irhdfs.rpm e quero o arquivo de report )
Então você executa ./extract lá na fonte para extrair e o ./replicat para que eu possa agora inserir os primeiro registro no HDFS lembrando que aqui é a carga inicial.
Agora toda vez que for inserido lá no banco de dados Oracle será trazido para seu Data Lake e claro podemos aplica filtros, customizar como nós vamos trazer esses dados não temos que trazer todo os registros ou todas as colunas podemos criar um Query SQL para trazer apenas os registros que seja do nosso interesse e assim vamos movendo os dados de um ambiente totalmente relacional com dados Estruturados para um Ambiente não estruturado que é exatamente o Data Lake.




