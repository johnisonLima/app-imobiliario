import unittest
import json
import urllib.request

URL_USUARIOS = 'http://localhost:5004/usuarios'
URL_USUARIO = 'http://localhost:5004/usuario'

class TestUsuarios (unittest.TestCase):

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
        response = self.acessar(URL_USUARIOS)

        self.assertEqual(response.getcode() , 200) 

        usuarios = json.loads(response.read().decode())
        self.assertIsInstance(usuarios, list)

        for usuario in usuarios:
            self.assertIn('_id', usuario)
            self.assertIn('criadoEm', usuario)

            self.assertIsInstance(usuario['_id'], str)
            self.assertIsInstance(usuario['email'], str)
            self.assertIsInstance(usuario['nome'], str)
            self.assertIsInstance(usuario['criadoEm'], str)  

    def testar_02_get_usuario_por_id(self):
        # id existente
        usuario_id = "6782d16fd828c3511bd85524"

        response = self.acessar(f"{URL_USUARIO}/{usuario_id}")
        self.assertEqual(response.getcode(), 200)

        # id inexistente        
        id_inexistente = "64bfc8f6e4b0a35a56c47eee"
        try:
            self.acessar(f"{URL_USUARIO}/{id_inexistente}")
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 404)
            
            erro = json.loads(e.read().decode())
            self.assertIn("erro", erro)
            self.assertEqual(erro["erro"], "Usuário não encontrado")
    
    def testar_03_registrar_usuario_exluir_usuario(self):
        novo_usuario = {
            "uid": "123456",
            "email": "teste@eamil.com",
            "nome": "nome teste"
        }

        response = self.post(URL_USUARIOS, data=json.dumps(novo_usuario))
        self.assertEqual(response.getcode(), 201)

        res = json.loads(response.read().decode())
        self.assertIn("mensagem", res)
        self.assertEqual(res["mensagem"], "Usuário registrado com sucesso")

        # Tentar registrar o mesmo usuário
        response = self.post(URL_USUARIOS, data=json.dumps(novo_usuario))
        self.assertEqual(response.getcode(), 200)

        res = json.loads(response.read().decode())
        self.assertIn("mensagem", res)
        self.assertEqual(res["mensagem"], "Usuário já registrado")

        # Usuario inválido (faltando "uid")
        usuario_invalido = {
            "email": "teste2@email.com"
        }

        try:
            response = self.post(URL_USUARIOS, data=json.dumps(usuario_invalido))
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 400)   

            res = json.loads(e.read().decode())
            self.assertIn("erro", res)
            self.assertEqual(res["erro"], "UID e Email são obrigatórios")

        # Usuario inválido (faltando "email")
        usuario_invalido = {
            "uid": "123456"
        }

        try:
            response = self.post(URL_USUARIOS, data=json.dumps (usuario_invalido))
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 400)   

            res = json.loads(e.read().decode())
            self.assertIn("erro", res)
            self.assertEqual(res["erro"], "UID e Email são obrigatórios")

        # Remover Usuario
        response_delete = self.delete(f"{URL_USUARIO}/{novo_usuario['uid']}")
        self.assertEqual(response_delete.getcode(), 200)

        res = json.loads(response_delete.read().decode())

        self.assertIn("mensagem", res)
        self.assertEqual(res["mensagem"], "Usuário excluído com sucesso")

if __name__ == '__maim__':
    unittest.main()