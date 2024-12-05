import 'package:flutter/material.dart';
import 'package:lh_imoveis/autenticador.dart';

import 'package:lh_imoveis/repository/usuario_repositorio.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {

  @override
  void initState() {
    super.initState();
    _recuperarEstadoUsuario();
  }

  Future<void> _recuperarEstadoUsuario() async {
    final usuario = await Autenticador.recuperarUsuario();
    if (usuario != null) {
      setState(() {
        estadoUsuario.login(usuario);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    bool estaLogado = estadoUsuario.estaLogado;

    return Builder(
      builder: (context) => Drawer(
        child: Column(
          children: [
            estaLogado
                ? UserAccountsDrawerHeader(
                    accountName: Text(estadoUsuario.usuario!.nome),
                    accountEmail: Text(estadoUsuario.usuario!.email),
                  )
                : const UserAccountsDrawerHeader(
                    accountName: Text("Conecte-se"),
                    accountEmail: Text("Para ficar por dentro das novidades"),
                  ),
            estaLogado
                ? ListTile(
                    title: _logout(),
                    onTap: () async {
                      /* lOGOUT MANUAL
                      const snackBar = SnackBar(
                        content: Text('Você foi desconectado com sucesso!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      setState(() {
                        estadoUsuario.logoff();
                      });

                      Navigator.of(context).pop(); */

                      await Autenticador.logout();

                      const snackBar = SnackBar(
                        content: Text('Você foi desconectado com sucesso!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      setState(() {
                        estadoUsuario.logoff();
                      });

                      Navigator.of(context).pop();


                    },
                  )
                : ListTile(
                    title: _loginGoogle(),
                    onTap: () async {
                      /* lOGIN MANUAL
                      Usuario usuario = Usuario(
                        nome: 'Morgan Freeman',
                        email: 'morgan@outlook.com',
                      );

                      const snackBar = SnackBar(
                        content: Text('Você foi conectado com sucesso!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      setState(() {
                        estadoUsuario.login(usuario);
                      });

                      Navigator.of(context).pop(); */
                      try {
                        final usuario = await Autenticador.login();

                        const snackBar = SnackBar(
                          content: Text('Você foi conectado com sucesso!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          estadoUsuario.login(usuario);
                        });
                      } catch (e) {
                        const snackBar = SnackBar(
                          content: Text('Falha ao conectar. Tente novamente'),
                        );
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      Navigator.of(context).pop();

                    },
                  ),
          ],
        ),
      ),
    );
  }
}

Widget _loginGoogle(){
  return SizedBox(
    height: 35,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Image.network(
            height: 30,
            'https://i.ibb.co/z5jZdQy/google.webp'
          ),
          const SizedBox(width: 10),
          const Text('Continuar com Google')
        ],
      ),
    ),
  );
}

Widget _logout(){
  return SizedBox(
    height: 35,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logout', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
        ],
      ),
    ),
  );
}