import 'package:flutter/material.dart';

import 'package:app_front/usuarioManager.dart';
import 'package:app_front/model/usuario.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
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
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Logout'),
                    onTap: () {
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
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Login'),
                    onTap: () {
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

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
