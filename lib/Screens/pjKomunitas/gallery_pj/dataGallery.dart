import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Post {

  final int id;

  final String title;

  final String body;

  final String label;
  
  final String time;

  final String url;
  

  Post({
    this.id,
    this.title,
    this.body,
    this.label,
    this.time,
    this.url

  });

  static List<Post> fromJsonArray(String jsonArrayString){
    List data = json.decode(jsonArrayString);
    List<Post> result = [];
    for(var i=0; i<data.length; i++){
      result.add(new Post(
          id: data[i]["id"],
          title: data[i]["title"],
          body: data[i]["body"],
          label: data[i]["label"],
          time: data[i]["time"],
          url: data[i]["url"]
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
      var request = await httpClient.getUrl(Uri.parse('http://64.56.78.116:8080/gallery'));
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