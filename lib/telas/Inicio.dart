import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/models/Video.dart';

// ignore: must_be_immutable
class Inicio extends StatefulWidget {
  const Inicio({super.key});

  // String pesquisa = "";

  // Inicio(this.pesquisa, {super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos() {
    Api api = Api();
    return api.pesquisar("");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video> videos = snapshot.data!;
                  Video video = videos[index];

                  return Column(children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(video.imagem),
                      )),
                    ),
                    ListTile(
                      title: Text(video.titulo),
                      subtitle: Text(video.canal),
                    )
                  ]);
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 3,
                  color: Colors.red,
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text("Nenhum dado a ser exibido! else"),
              );
            }
          default:
            return const Center(
              child: Text("Nenhum dado a ser exibido! default"),
            );
        }
      },
    );
  }
}
