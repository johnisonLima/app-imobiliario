db = db.getSiblingDB('lh_imoveis');

db.imoveis.drop();
db.comentarios.drop();
db.likes.drop();
db.imoveis.drop();
db.usuarios.drop();

db.imoveis.insertMany(
  [
    {
      "_id": ObjectId('6782d16fd828c3511bd85524'),
      "tipo": "Apartamento",
      "sobre": "O Residencial RIVERSIDE tem 54,81m2 de área privativa, bem distribuídos em 2 quartos, Sala, banheiro social, cozinha e área de serviço, 1 vaga de estacionamento e vagas para visitante. Localizado no B. Felícia _ Lot. Alameda dos Pássaros, 555 (Próximo ao Shopping Conquista Sul) ponto de Transporte coletivo em frente, padarias e farmácias. Possui Piscina adulto e infantil, área de fitness, quadra, jardim, churrasqueira, playground e Salão para festas. Além disso, segurança garantida 24 horas. ",
      "valor": 235.11,
      "titulo": "Candeias Premium Residencial",
      "cliente": {
        "nome": "James",
        "Sobrenome": "Hetfield",
        "email": "metallica@email.com",
        "telefone": "(77) 98854-8796"
      },
      "endereco": {
        "bairro": "Candeias",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Alameda dos Pássaros",
        "location": {
          "lat": -42.043982,
          "long": -107.590829
        }
      },
      "operacao": "Venda",
      "areaTotal": 8578.21,
      "comodidades": [
        {
          "qtd": 2,
          "tipo": "banheiro"
        },
        {
          "qtd": 4,
          "tipo": "garagem"
        },
        {
          "qtd": 4,
          "tipo": "quarto"
        },
        {
          "qtd": "",
          "tipo": "climatizada"
        }
      ],
      "dataLancamento": "2024-02-16",
      "dataEncerramamento": "2024-07-30",
      "imagemDestaque": "/apartamentos/venda/apto-002/apartamento.webp",
      "imagens": [
        {
          "url": "/apartamentos/venda/apto-002/fachada.webp",
          "descricao": "Fachada do imóvel",
          "tipo": "frontal"
        },
        {
          "url": "/apartamentos/venda/apto-002/sala.webp",
          "descricao": "Sala de estar ampla",
          "tipo": "interna"
        },
        {
          "url": "/apartamentos/venda/apto-002/Cobertura-da-Colina.webp",
          "descricao": "Quarto com armário embutido",
          "tipo": "interna"
        }
      ],
      "likesCount": 150
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd85525'),
      "tipo": "Galpão em Condomínio",
      "sobre": "Condomínio de galpões modulares com todas as facilidades para as empresas que necessitam de espaços para armazenagem, oferecendo aos usuários todos os benefícios e vantagens de uma infraestrutura.",
      "valor": 89490,
      "titulo": "Parque Logistico Sudoeste",
      "cliente": {
        "nome": "Axl",
        "Sobrenome": "Rose",
        "email": "gunsnroses@email.com",
        "telefone": "(77) 2105-8856"
      },
      "endereco": {
        "bairro": " Aírton Senna",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "BR-116",
        "location": {
          "lat": -14.910357,
          "long": -40.8721725
        }
      },
      "operacao": "Aluguel",
      "areaTotal": 6497.95,
      "comodidades": [
        {
          "qtd": 1,
          "tipo": "portaria blindada"
        },
        {
          "qtd": "4",
          "tipo": "garagem"
        },
        {
          "qtd": "",
          "tipo": "vigilancia"
        }
      ],
      "dataLancamento": "2024-10-01",
      "imagemDestaque": "/comerciais/aluguel/comercial-001/galpao.webp",
      "imagens": [
        {
          "url": "/comerciais/aluguel/comercial-001/fachada.webp",
          "descricao": "Fachada do galpão",
          "tipo": "frontal"
        },
        {
          "url": "/comerciais/aluguel/comercial-001/estrutura.webp",
          "descricao": "Estutura do galpão com pé direito alto",
          "tipo": "interna"
        },
        {
          "url": "/comerciais/aluguel/comercial-001/ampla.webp",
          "descricao": "Visão ampla do galpão",
          "tipo": "interna"
        }
      ],
      "likesCount": 111      
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd85526'),
      "tipo": "Aluguel",
      "sobre": "Galpão A com 13 módulos disponíveis a partir de 1.731m² até 23.344m² podendo locar juntos ou separados",
      "valor": 611.52,
      "titulo": "Condomínio Industrial",
      "cliente": {
        "nome": "Tina",
        "Sobrenome": "Turner",
        "email": "tina@email.com",
        "telefone": "(77) 98855-0554"
      },
      "endereco": {
        "bairro": "Distrito Industrial dos Imborés",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Rua G",
        "location": {
          "lat": -14.8224183,
          "long": -40.8057139
        }
      },
      "operacao": "Aluguel",
      "areaTotal": 1623.16,
      "comodidades": [
        {
          "qtd": 1,
          "tipo": "refeitorio"
        },
        {
          "qtd": 3,
          "tipo": "garagem"
        },
        {
          "qtd": "",
          "tipo": "vigilancia"
        },
        {
          "qtd": "",
          "tipo": "wifi"
        }
      ],
      "dataLancamento": "24-12-11",
      "imagemDestaque": "/comerciais/aluguel/comercial-002/fachada.webp",
      "imagens": [
        {
          "url": "/comerciais/aluguel/comercial-002/galpao.webp",
          "descricao": "Galpão com 13 módulos disponíveis",
          "tipo": "frontal"
        },
        {
          "url": "/comerciais/aluguel/comercial-002/fachada.webp",
          "descricao": "Fachada do galpão",
          "tipo": "frontal"
        },
        {
          "url": "/comerciais/aluguel/comercial-002/aeria.webp",
          "descricao": "Visão aérea do galpão",
          "tipo": "interna"
        },
        {
          "url": "/comerciais/aluguel/comercial-002/ampla.webp",
          "descricao": "Amplitude do galpão",
          "tipo": "interna"
        }
      ],
      "likesCount": 100
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd85527'),
      "tipo": "Casa",
      "sobre": "Casa residencial espaçosa com 3 quartos, suíte, cozinha ampla e quintal com área para lazer. Localizada em bairro tranquilo e próximo a escolas, mercados e transporte público.",
      "valor": 320,
      "titulo": "Residencial Lagoa Azul",
      "cliente": {
        "nome": "Freddie",
        "Sobrenome": "Mercury",
        "email": "freddie@email.com",
        "telefone": "(77) 98860-7766"
      },
      "endereco": {
        "bairro": "Boa Vista",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Rua das Flores",
        "location": {
          "lat": -14.861918,
          "long": -40.844733
        }
      },
      "operacao": "Venda",
      "areaTotal": 150,
      "comodidades": [
        {
          "qtd": 2,
          "tipo": "banheiro"
        },
        {
          "qtd": 2,
          "tipo": "garagem"
        },
        {
          "qtd": 3,
          "tipo": "quarto"
        }
      ],
      "dataLancamento": "2023-05-15",
      "imagemDestaque": "/casas/venda/casa-002/fachada.webp",
      "dataEncerramamento": "2024-11-15",
      "imagens": [
      {
        "url": "/casas/venda/casa-002/fachada.webp",
        "descricao": "Fachada do imóvel",
        "tipo": "frontal"
      },
        {
          "url": "/casas/venda/casa-002/varanda.webp",
          "descricao": "Varanda com vista para o jardim",
          "tipo": "frontal"
        },
        {
          "url": "/casas/venda/casa-002/lavanderia.webp",
          "descricao": "Lavanderia com espaço para máquina de lavar",
          "tipo": "frontal"
        },
        {
          "url": "/casas/venda/casa-002/sala.webp",
          "descricao": "Sala de estar ampla",
          "tipo": "interna"
        },
        {
          "url": "/casas/venda/casa-002/sala2.webp",
          "descricao": "Sala de café da manhã",
          "tipo": "interna"
        }
      ],
      "likesCount": 200
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd85528'),
      "tipo": "Cobertura",
      "sobre": "Cobertura duplex de alto padrão com vista panorâmica, 4 suítes, piscina privativa, e área gourmet. Localizada em área nobre com fácil acesso a restaurantes e shoppings.",
      "valor": 950.75,
      "titulo": "Cobertura da Colina",
      "cliente": {
        "nome": "Elton",
        "Sobrenome": "John",
        "email": "elton@email.com",
        "telefone": "(77) 98870-1234"
      },
      "endereco": {
        "bairro": "Recreio",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Av. da Colina",
        "location": {
          "lat": -14.85412,
          "long": -40.84822
        }
      },
      "operacao": "Venda",
      "areaTotal": 350,
      "comodidades": [
        {
          "qtd": 4,
          "tipo": "quarto"
        },
        {
          "qtd": 3,
          "tipo": "garagem"
        },
        {
          "qtd": 1,
          "tipo": "wifi"
        }
      ],
      "dataLancamento": "2024-03-20",
      "imagemDestaque": "/apartamentos/venda/apto-003/fachada.webp",
      "dataEncerramamento": "2025-03-20",
      "imagens": [
        {
          "url": "/apartamentos/venda/apto-003/fachada.webp",
          "descricao": "Fachada do imóvel",
          "tipo": "frontal"
        },
        {
          "url": "/apartamentos/venda/apto-003/vista.webp",
          "descricao": "Vista panorâmica da cidade",
          "tipo": "interna"
        },
        {
          "url": "/apartamentos/venda/apto-003/sala.webp",
          "descricao": "Sala de estar ampla e aconchegante",
          "tipo": "interna"
        }
      ],
      "likesCount": 58
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd85529'),
      "tipo": "Sala Comercial",
      "sobre": "Sala comercial em edifício moderno, com recepção, segurança e fácil acesso. Ideal para escritórios e consultórios.",
      "valor": 115,
      "titulo": "Edifício Empresarial Conquista",
      "cliente": {
        "nome": "David",
        "Sobrenome": "Bowie",
        "email": "bowie@email.com",
        "telefone": "(77) 2105-2215"
      },
      "endereco": {
        "bairro": "Centro",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Av. Bartolomeu de Gusmão",
        "location": {
          "lat": -14.8655,
          "long": -40.8369
        }
      },
      "operacao": "Aluguel",
      "areaTotal": 45,
      "comodidades": [
        {
          "qtd": "",
          "tipo": "wifi"
        },
        {
          "qtd": 1,
          "tipo": "garagem"
        },
        {
          "qtd": "",
          "tipo": "climatizada"
        }
      ],
      "dataLancamento": "2024-01-05",
      "imagemDestaque": "/comerciais/aluguel/comercial-003/sala.webp",
      "imagens": [
        {
          "url": "/comerciais/aluguel/comercial-003/sala.webp",
          "descricao": "Sala comercial moderna",
          "tipo": "frontal"
        },
        {
          "url": "/comerciais/aluguel/comercial-003/corredor.webp",
          "descricao": "Espaço amplo e bem iluminado",
          "tipo": "interna"
        },
        {
          "url": "/comerciais/aluguel/comercial-003/elevadores.webp",
          "descricao": "Dois elevadores para acesso",
          "tipo": "interna"
        }
      ],
      "likesCount": 30
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd8552a'),
      "tipo": "Apartamento",
      "sobre": "Apartamento aconchegante e bem localizado, com 3 quartos, sendo uma suíte, cozinha integrada à sala, varanda e vaga de garagem coberta. Ideal para quem busca conforto e praticidade no dia a dia.",
      "valor": 280,
      "titulo": "Residencial Primavera",
      "cliente": {
        "nome": "Kurt",
        "Sobrenome": "Cobain",
        "email": "kurt@email.com",
        "telefone": "(77) 98850-2020"
      },
      "endereco": {
        "bairro": "Morada Real",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Rua das Acácias",
        "location": {
          "lat": -14.861218,
          "long": -40.847319
        }
      },
      "operacao": "Venda",
      "areaTotal": 120,
      "comodidades": [
        {
          "qtd": 2,
          "tipo": "banheiro"
        },
        {
          "qtd": 1,
          "tipo": "garagem"
        },
        {
          "qtd": 3,
          "tipo": "quarto"
        }
      ],
      "dataLancamento": "2024-02-20",
      "imagemDestaque": "/apartamentos/venda/apto-004/sala.webp",
      "imagens": [
        {
          "url": "/apartamentos/venda/apto-004/sala.webp",
          "descricao": "Sala luxuosa e aconchegante",
          "tipo": "frontal"
        },
        {
          "url": "/apartamentos/venda/apto-004/varanda.webp",
          "descricao": "Varanda com vista para a cidade",
          "tipo": "interna"
        },
        {
          "url": "/apartamentos/venda/apto-004/cozinha.webp",
          "descricao": "Cozinha integrada à sala",
          "tipo": "interna"
        }
      ],
      "likesCount": 80
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd8552b'),
      "tipo": "Chácara",
      "sobre": "Chácara completa com piscina, churrasqueira, ampla área verde e um belo lago. Ideal para quem busca tranquilidade e contato com a natureza.",
      "valor": 1200,
      "titulo": "Refúgio do Lago",
      "cliente": {
        "nome": "Janis",
        "Sobrenome": "Joplin",
        "email": "janis@email.com",
        "telefone": "(77) 98845-3344"
      },
      "endereco": {
        "bairro": "Zona Rural",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Estrada do Lago",
        "location": {
          "lat": -14.855312,
          "long": -40.900123
        }
      },
      "operacao": "Venda",
      "areaTotal": 5000,
      "comodidades": [
        {
          "qtd": 4,
          "tipo": "quarto"
        },
        {
          "qtd": 3,
          "tipo": "banheiro"
        },
        {
          "qtd": 5,
          "tipo": "garagem"
        }
      ],
      "dataLancamento": "2023-11-10",
      "imagemDestaque": "/casas/venda/casa-003/fachada.webp",
      "dataEncerramamento": "2025-01-30",
      "imagens": [
        {
          "url": "/casas/venda/casa-003/fachada.webp",
          "descricao": "Fachada do imóvel",
          "tipo": "frontal"
        }
      ],
      "likesCount": 120
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd8552c'),
      "tipo": "Kitnet",
      "sobre": "Kitnet compacta, mobiliada, ideal para estudantes e profissionais solteiros. Localização central, próxima a transporte público e comércio.",
      "valor": 100,
      "titulo": "Kitnet Central",
      "cliente": {
        "nome": "Jimi",
        "Sobrenome": "Hendrix",
        "email": "jimi@email.com",
        "telefone": "(77) 98856-4412"
      },
      "endereco": {
        "bairro": "Centro",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Praça da Liberdade",
        "location": {
          "lat": -14.8663,
          "long": -40.8391
        }
      },
      "operacao": "Aluguel",
      "areaTotal": 30,
      "comodidades": [
        {
          "qtd": 1,
          "tipo": "quarto"
        },
        {
          "qtd": 1,
          "tipo": "banheiro"
        },
        {
          "qtd": "",
          "tipo": "wifi"
        }
      ],
      "dataLancamento": "2024-05-05",
      "imagemDestaque": "/apartamentos/aluguel/apto-005/sala.webp",
      "imagens": [
        {
          "url": "/apartamentos/aluguel/apto-005/sala.webp",
          "descricao": "Sala compacta e funcional",
          "tipo": "frontal"
        },
        {
          "url": "/apartamentos/aluguel/apto-005/banheiro.webp",
          "descricao": "Banheiro com box de vidro",
          "tipo": "interna"
        }
      ],
      "likesCount": 90
    },
    {
      "_id": ObjectId('6782d16fd828c3511bd8552d'),
      "tipo": "Ponto Comercial",
      "sobre": "Loja ampla, pronta para comércio, com ótima localização em rua movimentada. Possui espaço para depósito e dois banheiros.",
      "valor": 450,
      "titulo": "Loja Central",
      "cliente": {
        "nome": "Mick",
        "Sobrenome": "Jagger",
        "email": "mick@email.com",
        "telefone": "(77) 98859-1221"
      },
      "endereco": {
        "bairro": "Centro",
        "cidade": "Vitória da Conquista",
        "estado": "Bahia",
        "logradouro": "Rua Grande",
        "location": {
          "lat": -14.865712,
          "long": -40.838251
        }
      },
      "operacao": "Aluguel",
      "areaTotal": 80,
      "comodidades": [
        {
          "qtd": 2,
          "tipo": "banheiro"
        },
        {
          "qtd": "",
          "tipo": "wifi"
        },
        {
          "qtd": 2,
          "tipo": "garagem"
        }
      ],
      "dataLancamento": "2024-06-20",
      "imagemDestaque": "/comerciais/aluguel/comercial-004/fachada.webp",
      "imagens": [
        {
          "url": "/comerciais/aluguel/comercial-004/fachada.webp",
          "descricao": "Fachada do imóvel",
          "tipo": "frontal"
        }
      ],
      "likesCount": 70
    }
  ]
);

db.comentarios.insertMany(
  [
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "João Silva",
        "email": "jaoo@email.com"
      },
      "texto": "Adorei o imóvel! Parece ser uma ótima oportunidade.",
      "data":  ISODate("2024-11-12T10:15:00Z"),
      "nota": 5
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "Catarina A.",
        "email": "catarina@email.com"
      },
      "texto": "Este é um ótimo bairro. Acho que é muito seguro e ando sozinho à noite com frequência. As ruas, calçadas e parques são bem cuidados.",
      "data":  ISODate("2023-11-12T10:15:00Z"),
      "nota": 5
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "Ivete Sangalo",
        "email": "ivete@email.com"
      },
      "texto": "Muito rápido para o trabalho, alguns motoristas irritantes /  rudes, mas eu sou do sul, então não estou acostumado com isso",
      "data":  ISODate("2024-06-12T10:15:00Z"),
      "nota": 4
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "Caetano Veloso",
        "email": "caetano@email.com"
      },
      "texto": "Excelente deslocamento. A vida caminhável torna as coisas acessíveis no bairro, de lojas a restaurantes.",
      "data":  ISODate("2024-08-12T10:15:00Z"),
      "nota": 4
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "Mara Maravilha",
        "email": "mara@email.com"
      },
      "texto": "Você não precisa ter carro neste bairro se não quiser. Tudo Pertinho.",
      "data":  ISODate("2024-08-12T10:15:00Z"),
      "nota": 4
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "usuario": {
        "nome": "Dinho Ouro Preto",
        "email": "dinho@email.com"
      },
      "texto": "O bairro é incrível. Ótimas opções de transporte público ao redor. As estradas são agradáveis e bem pavimentadas.",
      "data":  ISODate("2024-02-12T10:15:00Z"),
      "nota": 4
    },
    {
      "imovelId": "6782d16fd828c3511bd85525",
      "usuario": {
        "nome": "Maria Oliveira",
        "email": "maria@email.com"
      },
      "texto": "Gostei, mas gostaria de mais detalhes sobre o bairro.",
      "data":  ISODate("2024-11-11T14:30:00Z"),
      "nota": 4
    },
    {
      "imovelId": "6782d16fd828c3511bd85527",
      "texto": "Ótimas lojas, bares e restaurantes na Avenida, excelentes vistas sobre a Reserva Alki & Schmidts para passear com cães.",
      "data":  ISODate("2024-11-28T15:22:51.757559"),
      "nota": 5,
      "usuario": {
        "nome": "Johnison",
        "email": "johnisonbsi@outlook.com"
      }
    },
    {
      "imovelId": "6782d16fd828c3511bd85527",
      "texto": "É toda a vibe alki, você pode aproveitar a vida um pouco mais, lits de restaurantes, caminhadas ao longo da avenida, parques locais. Acesso aos jogos do centro da cidade a pé na balsa.",
      "data":  ISODate("2024-11-28T15:28:34.188705"),
      "nota": 5,
      "usuario": {
        "nome": "Lindsay Lohan",
        "email": "lindsay@outlook.com"
      }
    },
    {
      "imovelId": "6782d16fd828c3511bd85525",
      "texto": "Os carros podem dirigir de forma um pouco imprudente, mas na maioria das vezes eu diria que este é o bairro mais seguro da cidade.",
      "data":  ISODate("2024-11-28T15:35:40.050252"),
      "nota": 5,
      "usuario": {
        "nome": "Lindsay Lohan",
        "email": "lindsay@outlook.com"
      }
    },
    {
      "imovelId": "6782d16fd828c3511bd85526",
      "texto": "Muitos lugares para comer, belas vistas. Destino turístico popular. Vida selvagem, ótima para crianças. Vizinhos amigáveis",
      "data":  ISODate("2024-11-28T15:54:48.306877"),
      "nota": 5,
      "usuario": {
        "nome": "Lindsay Lohan",
        "email": "lindsay@outlook.com"
      }
    },
    {
      "imovelId": "6782d16fd828c3511bd85527",
      "texto": "Eu pego ônibus para o centro da cidade 3 vezes por semana e é um trajeto muito fácil de 50 minutos. Os ônibus que saem de alki são seguros e higiênicos. O trajeto de carro também não é tão ruim, embora as rodovias do outro lado da ponte não sejam as",
      "data":  ISODate("2024-11-28T16:08:04.627073"),
      "nota": 5,
      "usuario": {
        "nome": "Morgan Freeman",
        "email": "morgan@outlook.com"
      }
    },
    {
      "imovelId": "6782d16fd828c3511bd85524",
      "texto": "Destino turístico popular. Vida selvagem, ótima para crianças. Vizinhos amigáveis",
      "data": "2024-11-28T16:34:56.975910",
      "nota": 5,
      "usuario": {
        "nome": "Morgan Freeman",
        "email": "morgan@outlook.com"
      }
    }
  ]
);

db.likes.insertMany(
  [
    {
      "_id": ObjectId('679bccc53b695c005e544cb4'),
      "imovelId": '6782d16fd828c3511bd85524',
      "usuarioId": '6782d16fd828c3511bd85524',
      "data": ISODate("2024-11-28T15:22:51.757559")
    }
    
  ]
);

db.usuarios.insertMany(
  [
    {
      "_id": '6782d16fd828c3511bd85524',
      "nome": "João Silva",
      "email": "joao@email.com",
      "criadoEm": ISODate("2024-11-28T15:22:51.757559")
    }
  ]
);