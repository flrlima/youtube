// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/models/Video.dart';

// ignore: must_be_immutable
class Inicio extends StatefulWidget {
  String pesquisa;

  // ignore: use_key_in_widget_constructors
  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    // É chamado antes de tudo - 1
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // É chamado para carregar dependências - 2
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    // É chamado para atualizar exemplo da pesquisa - 2.1
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Encerra ou pausa processos - 4
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
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

                  return GestureDetector(
                    onTap: () {
                      FlutterYoutubeView(
                          scaleMode: YoutubeScaleMode.none,
                          params: YoutubeParam(
                            videoId: video.id,
                            showUI: true,
                            startSeconds: 0.1,
                            autoPlay: true,
                            showYoutube: true,
                            showFullScreen: true,
                          ));
                    },
                    child: Column(children: <Widget>[
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
                    ]),
                  );
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
