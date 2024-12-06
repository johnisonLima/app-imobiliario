# Passo a Passo para Configuração do Projeto Laís Heitz Imóveis

Este guia descreve as etapas necessárias para configurar e executar o projeto Laís Heitz Imóveis.

## 1. Clonar o Repositório

**Windows:**
```cmd
cd caminho\para\pasta-destino
git clone https://github.com/johnisonLima/app-imobiliario.git
```

**Linux:**
```bash
cd /caminho/para/pasta-destino
git clone https://github.com/johnisonLima/app-imobiliario.git
```

## 2. Fazer Reload no Arquivo `pubspec.yaml`

Acesse a pasta `app_front` dentro do repositório e rode o seguinte comando:

**Windows:**
```cmd
cd app-imobiliario\app_front
flutter pub get
```

**Linux:**
```bash
cd app-imobiliario/app_front
flutter pub get
```

## 3. Configurar o `local_db`

- Acesse a pasta `local_db` dentro do repositório. 
- O arquivo `package.json` e o banco de dados simulado (`db.json`) estão localizados na subpasta `db`.

**Windows:**
```cmd
cd app-imobiliario\local_db
```

**Linux:**
```bash
cd app-imobiliario/local_db
```

## 4. Instalar o `json-server`

Instale a versão `0.17.3` do `json-server`.

**Windows:**
```cmd
npm install json-server@0.17.3
```

**Linux:**
```bash
npm install json-server@0.17.3
```

## 5. Obter o IP da Máquina

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

## 6. Atualizar os Arquivos de Configuração

Substitua `seu_ip_aqui` pelo IP obtido na etapa anterior:

1. No arquivo `package.json`, localizado em `local_db`. Atualize o script `server-start`:
   ```json
   "scripts": {
       "server-start": "json-server --host seu_ip_aqui --port 8080 db/db.json"
   }
   ```

2. No arquivo `base_repositorio.dart`, localizado em `app-imobiliario/app_front/lib/repository`. Atualize a constante `IP`:
   ```dart
   class BaseRepositorio {
       final String BASE_API;
       static const String IP = 'seu_ip_aqui';

       BaseRepositorio() : BASE_API = 'http://$IP:8080/';
   }
   ```

**Windows (editar com Notepad ou outro editor):**
```cmd
notepad package.json
notepad ..\app_front\lib\repository\base_repositorio.dart
```

**Linux:**
```bash
nano package.json
nano ../app_front/lib/repository/base_repositorio.dart
```

Salve as alterações.

## 7. Rodar o `json-server`

Execute o comando para iniciar o servidor local:

**Windows:**
```cmd
npm run server-start
```

**Linux:**
```bash
npm run server-start
```

O servidor será iniciado e o banco de dados simulado ficará disponível.

## 8. Executar o Hot Start do Flutter

Na pasta `app_front`, execute o projeto Flutter:

**Windows:**
```cmd
cd app-imobiliario\app_front
flutter run
```

**Linux:**
```bash
cd app-imobiliario/app_front
flutter run
```

Pressione `r` no terminal para realizar o hot start.

