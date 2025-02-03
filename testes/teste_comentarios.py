import unittest
import json
import urllib.request
from urllib.parse import quote

URL_COMENTARIOS = "http://localhost:5002/comentarios"

TAMANHO_DA_PAGINA = 3

class TestComentarios (unittest.TestCase):
    
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
    
    def testar_01_lazy_loading(self):
        id_comentario = "679792587c03170178544caa"
        dados = self.acessar(f"{URL_COMENTARIOS}/0/{TAMANHO_DA_PAGINA}")
        comentarios = json.loads(dados.read().decode())

        self.assertLessEqual(len(comentarios), TAMANHO_DA_PAGINA)
        if len(comentarios) > 0:
            self.assertEqual(comentarios[0]['_id'], comentarios[0]['_id'])

        dados = self.acessar(f"{URL_COMENTARIOS}/{id_comentario}/{TAMANHO_DA_PAGINA}")
        comentarios = json.loads(dados.read().decode())

        self.assertLessEqual(len(comentarios), TAMANHO_DA_PAGINA)
        if len(comentarios) > 0:
            self.assertEqual(comentarios[0]['_id'], comentarios[0]['_id'])

    def testar_02_adicionar_comentario_apagar_comentario(self):
        novo_comentario = {
            "texto": "Este é um comentário de teste.",
            "imovelId": "123456",
            "nota": 5,
            "usuario": {
                "nome": "Teste Usuario",
                "email": "teste@usuario.com"
            }
        }

        # Adiciona um novo comentário
        response = self.post(URL_COMENTARIOS, data=json.dumps(novo_comentario))
        self.assertEqual(response.status, 201)

        dados = json.loads(response.read().decode())
        self.assertIn('_id', dados)
        self.assertEqual(dados['texto'], novo_comentario['texto'])
        self.assertEqual(dados['imovelId'], novo_comentario['imovelId'])
        self.assertEqual(dados['nota'], novo_comentario['nota'])
        self.assertEqual(dados['usuario']['nome'], novo_comentario['usuario']['nome'])
        self.assertEqual(dados['usuario']['email'], novo_comentario['usuario']['email'])

        comentario_id = dados["_id"]

        # Apaga o comentário
        response_delete = self.delete(f"{URL_COMENTARIOS}/{comentario_id}")
        self.assertEqual(response_delete.status, 200)      
       
        data_delete = json.loads(response_delete.read().decode())
        self.assertEqual(data_delete["mensagem"], "Comentário apagado com sucesso")

        # Verifica se o comentário foi apagado
        try:
            self.acessar(f"{URL_COMENTARIOS}/{comentario_id}")
        except urllib.error.HTTPError as e:
            self.assertEqual(e.code, 404) 

            res = json.loads(e.read().decode())
            self.assertIn("erro", res)
            self.assertEqual(res["erro"], "Comentário não encontrado")    

if __name__ == '__main__':
    unittest.main()