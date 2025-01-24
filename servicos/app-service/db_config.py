from pymongo import MongoClient # type: ignore

MONGO_USER = "root"
MONGO_PASS = "admin@banco"
MONGO_PORT = 27017
MONGO_DB = "lh_imoveis"
MONGO_URI = f"mongodb://{MONGO_USER}:{MONGO_PASS}:{MONGO_PORT}/{MONGO_DB}?authSource=admin"

client = MongoClient(MONGO_URI)
db = client[MONGO_DB] 
