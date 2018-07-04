import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({ Key key, DateTime dateTime, @required this.onChanged })
    : assert(onChanged != null),
      date = new DateTime(dateTime.year, dateTime.month, dateTime.day),
      time = new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new DefaultTextStyle(
      style: theme.textTheme.subhead,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: new BoxDecoration(
                border: new Border(bottom: new BorderSide(color: theme.dividerColor))
              ),
              child: new InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: date.subtract(const Duration(days: 30)),
                    lastDate: date.add(const Duration(days: 30))
                  )
                  .then<Null>((DateTime value) {
                    if (value != null)
                      onChanged(new DateTime(value.year, value.month, value.day, time.hour, time.minute));
                  });
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(new DateFormat('EEE, MMM d yyyy').format(date)),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ]
                )
              )
            )
          ),
          new Container(
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: new BoxDecoration(
              border: new Border(bottom: new BorderSide(color: theme.dividerColor))
            ),
            child: new InkWell(
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: time
                )
                .then<Null>((TimeOfDay value) {
                  if (value != null)
                    onChanged(new DateTime(date.year, date.month, date.day, value.hour, value.minute));
                });
              },
              child: new Row(
                children: <Widget>[
                  new Text('${time.format(context)}'),
                  const Icon(Icons.arrow_drop_down, color: Colors.black54),
                ]
              )
            )
          )
        ]
      )
    );
  }
}

class TambahGallery extends StatefulWidget {
  @override
  TambahGalleryState createState() => new TambahGalleryState();
}

class TambahGalleryState extends State<TambahGallery> {
  DateTime _fromDateTime = new DateTime.now();
  DateTime _toDateTime = new DateTime.now();
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;
  String _eventName;

TextEditingController controllerName = new TextEditingController();
TextEditingController controllerDesc = new TextEditingController();
TextEditingController controllerMateri = new TextEditingController();
TextEditingController controllerLocation = new TextEditingController();
TextEditingController controllerXp = new TextEditingController();
TextEditingController controllerPoints = new TextEditingController();

void addData() async {
  String url =
      'http://192.168.1.10:8080/gath';
  Map map = {
    'nama': controllerName.text,
    'deskripsi': controllerDesc.text, //controllerDesc.text,
    'materi': controllerMateri.text,
    'lokasi': controllerLocation.text,
    'reward_points': controllerPoints.text,
    'reward_xp': controllerXp.text,
  };

  print(await apiRequest(url, map));
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}




  Future<bool> _onWillPop() async {
    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded)
      return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new Text(
            'Discard new documentation?',
            style: dialogTextStyle
          ),
          actions: <Widget>[
            new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false); // Pops the confirmation dialog but not the page.
              }
            ),
            new FlatButton(
              child: const Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop(true); // Returning true to _onWillPop will pop again.
              }
            )
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_hasName ? _eventName : 'Add Documentation'),
        actions: <Widget> [
          new FlatButton(
            child: new Text('SAVE', style: theme.textTheme.body1.copyWith(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
            }
          )
        ]
      ),
      body: new Form(
        onWillPop: _onWillPop,
        child: new ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: new TextField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Title',
                  filled: true
                ),
                style: theme.textTheme.headline,
                onChanged: (String value) {
                  setState(() {
                    _hasName = value.isNotEmpty;
                    if (_hasName) {
                      _eventName = value;
                    }
                  });
                }
              )
            ),
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: new TextFormField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Body',
                  hintText: 'add your body',
                  filled: true
                ),

              )
            ),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Tell us about yourself',
                    labelText: 'Description',
                  ),
                  maxLines: 20,
                ),
            
          ]
          .map((Widget child) {
            return new Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 96.0,
              child: child
            );
          })
          .toList()
        )
      ),
    );
  }
}