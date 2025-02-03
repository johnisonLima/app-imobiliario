# Passo a Passo para Configuração do Projeto Laís Heitz Imóveis

Este guia descreve as etapas necessárias para configurar e executar o projeto Laís Heitz Imóveis.

## 1. Clonar o Repositório

**Windows:**
```cmd
cd caminho\para\pasta-destino
git clone https://github.com/johnisonLima/app-imobiliario.git
```

## 2. Fazer Reload no Arquivo `pubspec.yaml`

Acesse a pasta `app_front` dentro do repositório e rode o seguinte comando:

**Windows:**
```cmd
cd app-imobiliario\app_front
flutter pub get
```

## 3. Subir os Contêineres com Docker

- Acesse a pasta `servicos` dentro do repositório. 

**Windows:**
```cmd
cd app-imobiliario\servicos
docker-compose up -d --build
```
Isso irá:
* ✅ Subir o banco de dados MongoDB
* ✅ Iniciar o backend Flask com as APIs configuradas

**Se precisar parar os contêineres:**
```cmd
docker-compose down
```

**Para verificar os logs:**
```cmd
docker-compose logs -f
```

## 4. Obter o IP da Máquina

Obtenha o IP da máquina para configurá-lo nos arquivos do projeto:

**Windows:**
```cmd
ipconfig
```

**Linux:**
```bash
hostname -I
```

Anote o IP da sua máquina.

## 5. Atualizar os Arquivos de Configuração

Substitua `seu_ip_aqui` pelo IP obtido na etapa anterior:

1. No arquivo `base_repositorio.dart`, localizado em `app-imobiliario/app_front/lib/repository`. Atualize a constante `IP`:
   ```dart
   class BaseRepositorio {
       final String BASE_API;
       static const String IP = 'seu_ip_aqui';

       BaseRepositorio() : BASE_API = 'http://$IP';
   }
   ```

Salve as alterações.

## 6. Executar o Hot Start do Flutter

Na pasta `app_front`, execute o projeto Flutter:

**Windows:**
```cmd
cd app-imobiliario\app_front
flutter run
```
Pressione `r` no terminal para realizar o hot start.

