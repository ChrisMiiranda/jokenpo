import 'dart:math';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";

  // Função que gera a jogada do app e valida a escolha do usuário
  void _opcaoSelecionada(String escolhaUsuario) {
    final opcoes = ["pedra", "papel", "tesoura"];
    final escolhaApp = opcoes[Random().nextInt(3)];

    final regras = {"pedra": "tesoura", "papel": "pedra", "tesoura": "papel"};

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
      if (escolhaUsuario == escolhaApp) {
        _mensagem = "Empatou! Ninguém Ganhou...";
      } else if (regras[escolhaUsuario] == escolhaApp) {
        _mensagem = "Você Ganhou!!";
      } else {
        _mensagem = "Você Perdeu!!";
      }
    });
  }

  // Constantes para as imagens
  final List<String> opcoesImagens = [
    'images/pedra.png',
    'images/papel.png',
    'images/tesoura.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "JokenPo",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Escolha sua jogada",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: _imagemApp),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Usando o Row para as opções
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: opcoesImagens.map((imagem) {
              return GestureDetector(
                onTap: () => _opcaoSelecionada(imagem.split('/').last.split('.').first),
                child: Image.asset(
                  imagem,
                  height: 100,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
