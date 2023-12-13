import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube/models/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDC3uLIEds8hPyAuO43R5DEGJdqMICRTp4";
const ID_CANAL = "UCu4zVwlEkj5PhLiIPibUlbg";
const URL_BASE_YOUTUBE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(Uri.parse(
        "${URL_BASE_YOUTUBE}search?part=snippet&type=video&maxResults=20&order=date&key=$CHAVE_YOUTUBE_API&channelId=$ID_CANAL&q=$pesquisa"));

    Map<String, dynamic> dadosJson = json.decode(response.body);

    List<Video> videos = dadosJson["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videos;
  }
}
