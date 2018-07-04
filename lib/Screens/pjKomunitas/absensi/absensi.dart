import 'package:collection/collection.dart' show lowerBound;

import 'package:flutter/material.dart';

enum LeaveBehindDemoAction {
  reset,
  horizontalSwipe,
  leftSwipe,
  rightSwipe
}

class LeaveBehindItem implements Comparable<LeaveBehindItem> {
  LeaveBehindItem({ this.index, this.name, this.subject, this.body });

  LeaveBehindItem.from(LeaveBehindItem item)
    : index = item.index, name = item.name, subject = item.subject, body = item.body;

  final int index;
  final String name;
  final String subject;
  final String body;

  @override
  int compareTo(LeaveBehindItem other) => index.compareTo(other.index);
}

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({ Key key }) : super(key: key);

  static const String routeName = '/material/leave-behind';

  @override
  AbsensiScreenState createState() => new AbsensiScreenState();
}

class AbsensiScreenState extends State<AbsensiScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DismissDirection _dismissDirection = DismissDirection.horizontal;
  List<LeaveBehindItem> leaveBehindItems;

  void initListItems() {
    leaveBehindItems = new List<LeaveBehindItem>.generate(16, (int index) {
      return new LeaveBehindItem(
        index: index,
        name: '$index Anggota baru',
        subject: 'Locality: $index',
        body: "Tambahan"
      );
    });
  }

  @override
  void initState() {
    super.initState();
    initListItems();
  }

  void handleDemoAction(LeaveBehindDemoAction action) {
    setState(() {
      switch (action) {
        case LeaveBehindDemoAction.reset:
          initListItems();
          break;
        case LeaveBehindDemoAction.horizontalSwipe:
          _dismissDirection = DismissDirection.horizontal;
          break;
        case LeaveBehindDemoAction.leftSwipe:
          _dismissDirection = DismissDirection.endToStart;
          break;
        case LeaveBehindDemoAction.rightSwipe:
          _dismissDirection = DismissDirection.startToEnd;
          break;
      }
    });
  }

  void handleUndo(LeaveBehindItem item) {
    final int insertionIndex = lowerBound(leaveBehindItems, item);
    setState(() {
      leaveBehindItems.insert(insertionIndex, item);
    });
  }

  Widget buildItem(LeaveBehindItem item) {
    final ThemeData theme = Theme.of(context);
    return new Dismissible(
      key: new ObjectKey(item),
      direction: _dismissDirection,
      onDismissed: (DismissDirection direction) {
        setState(() {
          leaveBehindItems.remove(item);
        });
        final String action = (direction == DismissDirection.endToStart) ? 'archived' : 'deleted';
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text('You $action item ${item.index}'),
          action: new SnackBarAction(
            label: 'UNDO',
            onPressed: () { handleUndo(item); }
          )
        ));
      },
      background: new Container(
        color: Colors.red,
        child: const ListTile(
          leading: const Icon(Icons.delete, color: Colors.white, size: 36.0)
        )
      ),
      secondaryBackground: new Container(
        color: Colors.green,
        child: const ListTile(
          trailing: const Icon(Icons.archive, color: Colors.white, size: 36.0)
        )
      ),
      child: new Container(
        decoration: new BoxDecoration(
          color: theme.canvasColor,
          border: new Border(bottom: new BorderSide(color: theme.dividerColor))
        ),
        child: new ListTile(
          title: new Text(item.name),
          subtitle: new Text('${item.subject}\n${item.body}'),
          isThreeLine: true
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: leaveBehindItems.isEmpty
          ? new Center(
              child: new RaisedButton(
                onPressed: () => handleDemoAction(LeaveBehindDemoAction.reset),
                child: const Text('Reset the list'),
              ),
            )
          : new ListView(
             children: leaveBehindItems.map(buildItem).toList()
            ),
    );
  }
}