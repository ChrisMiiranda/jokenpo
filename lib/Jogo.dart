import 'dart:math';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  String _mensagem = "Escolha uma opção abaixo";
  final Random _random = Random();
  final List<String> _opcoes = ["pedra", "papel", "tesoura"];
  final Map<String, String> _regras = {"pedra": "tesoura", "papel": "pedra", "tesoura": "papel"};

  // Função que gera a jogada do app e valida a escolha do usuário
  void _opcaoSelecionada(String escolhaUsuario, {String? escolhaAppSimulada}) {
    final escolhaApp = escolhaAppSimulada ?? _opcoes[_random.nextInt(3)];

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
      _mensagem = _determineResultado(escolhaUsuario, escolhaApp);
    });
  }

  // Função para determinar o resultado do jogo
  String _determineResultado(String escolhaUsuario, String escolhaApp) {
    if (escolhaUsuario == escolhaApp) {
      return "Empatou! Ninguém Ganhou...";
    } else if (_regras[escolhaUsuario] == escolhaApp) {
      return "Você Ganhou!!";
    } else {
      return "Você Perdeu!!";
    }
  }

  // Lista de imagens para as opções
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
          // Usando GridView para as opções
          GridView.builder(
            shrinkWrap: true,
            itemCount: _opcoes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final escolha = _opcoes[index];
              return GestureDetector(
                key: Key(escolha),
                onTap: () => _opcaoSelecionada(escolha),
                child: Image.asset(
                  'images/$escolha.png',
                  height: 100,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
