import unittest
from teste_imoveis import *
from teste_comentarios import *
from teste_likes import *
from teste_usuarios import *

if __name__ == '__main__':
    carregador = unittest.TestLoader()
    testes = unittest.TestSuite()

    testes.addTests(carregador.loadTestsFromTestCase(TestImoveis))
    testes.addTests(carregador.loadTestsFromTestCase(TestComentarios))
    testes.addTests(carregador.loadTestsFromTestCase(TestLikes))
    testes.addTests(carregador.loadTestsFromTestCase(TestUsuarios))

    executar = unittest.TextTestRunner()
    executar.run(testes)