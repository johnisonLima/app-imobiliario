import unittest
import json
import urllib.request
from urllib.parse import quote

URL_IMOVEIS = "http://localhost:5001/imoveis"
URL_BUSCAR_IMOVEIS = "http://localhost:5001/buscar_imoveis"

TAMANHO_DA_PAGINA = 3

TIPO = 'casa'
OPERACAO = 'venda'
NOME_BAIRRO = 'candeias'
NOME_CIDADE = 'vitória da conquista'
NOME_ESTADO = 'bahia'

class TestImoveis(unittest.TestCase):
    
    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        return resposta

    def testar_01_lazy_loading(self):
        dados = self.acessar(f"{URL_IMOVEIS}/0/{TAMANHO_DA_PAGINA}")
        imoveis = json.loads(dados.read().decode())

        self.assertLessEqual(len(imoveis), TAMANHO_DA_PAGINA)
        if len(imoveis) > 0:
            self.assertEqual(imoveis[0]['_id'], imoveis[0]['_id'])

        dados = self.acessar(f"{URL_IMOVEIS}/6782d16fd828c3511bd85526/{TAMANHO_DA_PAGINA}")
        imoveis = json.loads(dados.read().decode())

        self.assertLessEqual(len(imoveis), TAMANHO_DA_PAGINA)
        if len(imoveis) > 0:
            self.assertEqual(imoveis[0]['_id'], imoveis[0]['_id'])

    def testar_02_pesquisa_imovel_pelo_id(self):
        dados = self.acessar(f"{URL_IMOVEIS}/0/{TAMANHO_DA_PAGINA}")
        imoveis = json.loads(dados.read().decode())

        if len(imoveis) > 0:
            primeiro_imovel_id = imoveis[1]['_id']
            dados = self.acessar(f"{URL_IMOVEIS}/{primeiro_imovel_id}")            
            imovel = json.loads(dados.read().decode())

            self.assertEqual(imovel['_id'], primeiro_imovel_id)
    
    def testar_03_pesquisa_imovel_pelo_tipo(self):
        dados = self.acessar(f"{URL_BUSCAR_IMOVEIS}/0/{TAMANHO_DA_PAGINA}?tipo={TIPO}")
        imoveis = json.loads(dados.read().decode())

        for imovel in imoveis:
            self.assertIn(TIPO, imovel['tipo'].lower())
    
    def testar_04_pesquisa_imovel_pela_operacao(self):
        dados = self.acessar(f"{URL_BUSCAR_IMOVEIS}/0/{TAMANHO_DA_PAGINA}?operacao={OPERACAO}")
        imoveis = json.loads(dados.read().decode())

        for imovel in imoveis:
            self.assertIn(OPERACAO, imovel['operacao'].lower())

    def testar_05_pesquisa_imovel_pelo_bairro(self):
        dados = self.acessar(f"{URL_BUSCAR_IMOVEIS}/0/{TAMANHO_DA_PAGINA}?bairro={NOME_BAIRRO}")
        imoveis = json.loads(dados.read().decode())

        for imovel in imoveis:
            self.assertIn(NOME_BAIRRO, imovel['endereco']['bairro'].lower())

    def testar_06_pesquisa_imovel_pela_cidade(self):
        dados = self.acessar(f"{URL_BUSCAR_IMOVEIS}/0/{TAMANHO_DA_PAGINA}?cidade={quote(NOME_CIDADE)}")
        imoveis = json.loads(dados.read().decode())

        for imovel in imoveis:
            self.assertIn(NOME_CIDADE, imovel['endereco']['cidade'].lower())

    def testar_07_pesquisa_imovel_pelo_estado(self):
        dados = self.acessar(f"{URL_BUSCAR_IMOVEIS}/0/{TAMANHO_DA_PAGINA}?estado={quote(NOME_ESTADO)}")
        imoveis = json.loads(dados.read().decode())

        for imovel in imoveis:
            self.assertIn(NOME_ESTADO, imovel['endereco']['estado'].lower())


if __name__ == '__main__':
    unittest.main()