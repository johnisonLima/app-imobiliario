from pymongo import MongoClient # type: ignore

# Configurações do MongoDB
MONGO_USER = "root"
MONGO_PASS = "admin@banco"
MONGO_PORT = 27017
MONGO_DB = "lh_imoveis"
MONGO_URI = f"mongodb://{MONGO_USER}:{MONGO_PASS}:{MONGO_PORT}/{MONGO_DB}?authSource=admin"

# Inicializa o cliente e retorna a conexão com o banco
client = MongoClient(MONGO_URI)
db = client[MONGO_DB] 
