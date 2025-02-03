import unittest
import json
import urllib.request
from bson.objectid import ObjectId # type: ignore

URL_LIKES = "http://localhost:5003/likes"
URL_LIKE = "http://localhost:5003/like"

class TestLikes (unittest.TestCase):    
    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        return resposta
    
    def post(self, url, data, content_type='application/json'):
        data_bytes = data.encode('utf-8')
        headers = {'Content-Type': content_type}
        requisicao = urllib.request.Request(url, data=data_bytes, headers=headers, method='POST')
        resposta = urllib.request.urlopen(requisicao)
        return resposta  
    
    def delete(self, url):
        requisicao = urllib.request.Request(url, method='DELETE')
        resposta = urllib.request.urlopen(requisicao)
        return resposta
    
    def testar_01_get_all(self):
        response = self.acessar(URL_LIKES)

        self.assertEqual(response.getcode() , 200) 

        likes = json.loads(response.read())
        self.assertIsInstance(likes, list)

        for like in likes:
            self.assertIn('_id', like)
            self.assertIn('data', like)

            self.assertTrue(ObjectId.is_valid(like['_id']))
            self.assertIsInstance(like['data'], str)  
    
    def testar_02_get_like_por_id(self):
        # id existente
        like_id = "679bccc53b695c005e544cb4"

        response = self.acessar(f"{URL_LIKE}/{like_id}")
        self.assertEqual(response.getcode(), 200)

        # id inexistente        
        id_inexistente = "64bfc8f6e4b0a35a56c47eee"
        try:
            self.acessar(f"{URL_LIKE}/{id_inexistente}")
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 404)
            
            erro = json.loads(e.read().decode())
            self.assertIn("erro", erro)
            self.assertEqual(erro["erro"], "Like não encontrado")

    def testar_03_get_likes_imovel(self):
        imovel_id = "6782d16fd828c3511bd85524"
        usuario_id = "6782d16fd828c3511bd85524"

        like = {
            "imovelId": imovel_id,
            "usuarioId": usuario_id
        }

        self.post(URL_LIKES, data=json.dumps(like))

        response = self.acessar(f"{URL_LIKES}/{imovel_id}")
        # responseCode = urllib.request.urlopen(f"{URL_LIKES}/{imovel_id}")
        self.assertEqual(response.getcode(), 200)
        
        likes = json.loads(response.read().decode())
        self.assertEqual(len(likes), 1)
        self.assertTrue(all(like["imovelId"] == imovel_id for like in likes))

        # Imóvel sem likes
        try:
            response = self.acessar(f"{URL_LIKES}/6782d16fd828c3511bd855bb")
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 404)
            
            erro = json.loads(e.read().decode())
            self.assertIn("erro", erro)
            self.assertEqual(erro["erro"], "Imóvel não possui likes")     

    def testar_04_get_like_usuario_imovel_curtiu(self):
        imovel_id = "6782d16fd828c3511bd85524"
        imovel_id_dois = "6782d16fd828c3511bd85528"
        usuario_id = "6782d16fd828c3511bd85524"        

        # Usuário curtiu o imóvel
        response = self.acessar(f"{URL_LIKES}/{imovel_id}/{usuario_id}")
        self.assertEqual(response.getcode(), 200)

        res = json.loads(response.read().decode())
        self.assertTrue(res["curtiu"]) 
        self.assertIn("like", res) 
        self.assertEqual(res["like"]["imovelId"], imovel_id)
        self.assertEqual(res["like"]["usuarioId"], usuario_id)

        # Usuário não curtiu o imóvel
        response = self.acessar(f"{URL_LIKES}/{imovel_id_dois}/{usuario_id}")        
        self.assertEqual(response.getcode(), 200)
        
        res = json.loads(response.read().decode())
        self.assertFalse(res["curtiu"])  
        self.assertNotIn("like", res)    

    def testar_05_registrar_like_exluir_like(self):
        novo_like = {
            "imovelId": "6782d16fd828c3511bd855bb",
            "usuarioId": "6782d16fd828c3511bd855bb"
        }

        response = self.post(URL_LIKES, data=json.dumps(novo_like))
        self.assertEqual(response.getcode(), 201)

        res = json.loads(response.read().decode())
        self.assertIn("_id", res)
        self.assertEqual(res["imovelId"], novo_like["imovelId"])
        self.assertEqual(res["usuarioId"], novo_like["usuarioId"])
        self.assertIn("data", res)

        # Segundo like (deve ser barrado)
        response = self.post(URL_LIKES, data=json.dumps(novo_like))
        self.assertEqual(response.getcode(), 200)

        res = json.loads(response.read().decode())
        self.assertIn("mensagem", res)
        self.assertEqual(res["mensagem"], "Usuário já deu like nesse imóvel")

        # Like inválido (faltando "usuarioId")
        like_invalido = {
            "imovelId": "654321"
            # Está faltando o "usuarioId"
        }

        try:
            response = self.post(URL_LIKES, data=json.dumps(like_invalido))
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 400) 

            res = json.loads(e.read().decode())
            self.assertIn("erro", res)
            self.assertEqual(res["erro"], "Imóvel ID e Usuário ID são obrigatórios")
        
        # Remover o like
        response_delete = self.delete(f"{URL_LIKES}/{novo_like['imovelId']}/{novo_like['usuarioId']}")
        self.assertEqual(response_delete.getcode(), 200)

        res = json.loads(response_delete.read().decode())
        self.assertIn("mensagem", res)
        self.assertEqual(res["mensagem"], "Like removido com sucesso")

    def testar_05_excluir_like_inexistente(self):
        try:
            self.delete(f"{URL_LIKES}/6782d16fd828c3511bd85524/6782d16fd828c3511bd855bb")
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 404)

            res = json.loads(e.read().decode())
            self.assertIn("erro", res)
            self.assertEqual(res["erro"], "Like não encontrado")


if __name__ == '__main__':
    unittest.main()