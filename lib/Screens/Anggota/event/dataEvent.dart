import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Post {

  final int id;

  final int reward_xp;

  final int reward_points;

  final String nama;

  final String deskripsi;

  final String materi;
  
  final String lokasi;

  final String pengajar;

  Post({
    this.id,
    this.nama,
    this.materi,
    this.deskripsi,
    this.lokasi,
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
      var request = await httpClient.getUrl(Uri.parse('http://172.18.12.240:8080/gath'));
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