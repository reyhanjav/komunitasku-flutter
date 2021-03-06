import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Post {

  final int id;

  final String nama;

  final String deskripsi;

  final String materi;
  
  final String lokasi;
  
  final int reward_points;

  final int reward_xp;

  final String pengajar;

  Post({
    this.id,
    this.nama,
    this.materi,
    this.deskripsi,
    this.lokasi,
    this.reward_points,
    this.reward_xp,
    this.pengajar
  });

  static List<Post> fromJsonArray(String jsonArrayString){
    List data = json.decode(jsonArrayString);
    List<Post> result = [];
    for(var i=0; i<data.length; i++){
      result.add(new Post(
          id: data[i]["id"],
          nama: data[i]["nama"],
          materi: data[i]["materi"],
          deskripsi: data[i]["deskripsi"],
          lokasi: data[i]["lokasi"],
          reward_points: data[i]["reward_points"],
          reward_xp: data[i]["reward_xp"],
          pengajar: data[i]["pengajar"]
      ));
    }
    return result;
  }
}

class PostState{
  List<Post> posts;
  bool loading;
  bool error;

  PostState({
    this.posts = const [],
    this.loading = true,
    this.error = false,
  });

  void reset(){
    this.posts = [];
    this.loading = true;
    this.error = false;
  }

  Future<void> getFromApi() async{
    try {
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse('http://64.56.78.116:8080/gath'));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        this.posts = Post.fromJsonArray(json);
        this.loading = false;
        this.error = false;
      }
      else{
        this.posts = [];
        this.loading = false;
        this.error = true;
      }
    } catch (exception) {
      this.posts = [];
      this.loading = false;
      this.error = true;
    }
  }
}