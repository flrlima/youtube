import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String resultado = "";
    List<Widget> telas = [
      const Inicio(),
      const EmAlta(),
      const Inscricao(),
      const Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "imagens/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          /*
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              print("ação: videocam");
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("ação: search");
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              print("ação: account_circle");
            },
          ),
          */

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String res = showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              ).toString();

              setState(() {
                resultado = res;
              });

              print("resultado digitado: $res");
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: "Em alta",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: "Inscrições",
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Bibliotecas",
          ),
        ],
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
