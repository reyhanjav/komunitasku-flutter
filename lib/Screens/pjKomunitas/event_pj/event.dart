import 'package:flutter/material.dart';
import './dataEvent.dart';
import 'package:http/http.dart' as http;
import 'package:sticky_headers/sticky_headers.dart';

class EventPage extends StatefulWidget {
  EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage>{
  final PostState postState = new PostState();
  BuildContext context;

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  _getPosts() async {
    if (!mounted) return;

    await postState.getFromApi();
    setState((){
      if(postState.error){
        _showError();
      }
    });
  }

  _retry(){
    Scaffold.of(context).removeCurrentSnackBar();
    postState.reset();
    setState((){});
    _getPosts();
  }

  void _showError(){
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("An unknown error occurred"),
        duration: new Duration(days: 1), // Make it permanent
        action: new SnackBarAction(
            label : "RETRY",
            onPressed : (){_retry();}
        )
    ));
  }

  

  Widget _getLoadingStateWidget(){
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget _getSuccessStateWidget(){
    return new ListView.builder(
        itemCount: postState.posts.length,
        itemBuilder: (context, index) {
          return new Material(
					color: Colors.white,
					child:  new Container(
							child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: new Text(
                postState.posts[index].nama,
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle:
                  new Text(postState.posts[index].deskripsi),
            ),
            new ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('DELETE'),
                    onPressed: () {
                      var url="http://64.56.78.116:8080/gath/";
                      var endpoint=postState.posts[index].id;
                      String testing = endpoint.toString();
                      http.delete(url + testing);
                    },
                  ),
                  new FlatButton(
                    child: const Text('EDIT'),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
            //this is not the list example, so when you add new cards, it won't be inside of the list.
          ],
        ), 
						),

				);
        }
    );
  }
  
  
  Widget _getErrorState(){
    return new Center(
      child: new Row(),
    );
  }

  Widget getCurrentStateWidget(){
    Widget currentStateWidget;
    if(!postState.error && !postState.loading) {
      currentStateWidget = _getSuccessStateWidget();
    }
    else if(!postState.error){
      currentStateWidget = _getLoadingStateWidget();
    }
    else{
      currentStateWidget = _getErrorState();
    }
    return currentStateWidget;
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = getCurrentStateWidget();
    return new Scaffold(
        body: new Builder(builder: (BuildContext context) {
          this.context = context;
          return currentWidget;
        })
    );
  }
}

class myCardLayout extends StatelessWidget {
  // default constructor
  myCardLayout({this.id, this.title, this.description, this.location});

  // init variables
  final int id;
  final String title;
  final String description;
  final String location;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: new Text(
                title,
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle:
                  new Text(description),
            ),
            new ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('DELETE'),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                  new FlatButton(
                    child: const Text('EDIT'),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
