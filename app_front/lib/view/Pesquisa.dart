import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  static const rountName = '/Pesquisa';
  
  const Pesquisa({super.key});   

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {


  @override
  Widget build(BuildContext context) {
    return const Text('Pesquisar');
  }
}