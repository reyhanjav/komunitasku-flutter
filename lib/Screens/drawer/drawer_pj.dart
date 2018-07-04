import 'package:komunitasku/Screens/Anggota/profile/Profile.dart';
import 'package:komunitasku/Screens/pjKomunitas/event_pj/event.dart';
import 'package:komunitasku/Screens/pjKomunitas/event_pj/addEvent.dart';
import 'package:komunitasku/Screens/pjKomunitas/gallery_pj/addGallery.dart';
import 'package:komunitasku/Screens/pjKomunitas/absensi/absensi.dart';
import 'package:komunitasku/Screens/Anggota/todo/todo_demo.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

 enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class PjDrawer extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Profile", Icons.person),
    new DrawerItem("Event", Icons.calendar_today),
    new DrawerItem("Absensi", Icons.people),
    new DrawerItem("Gallery", Icons.image),
  ];

  @override
  State<StatefulWidget> createState() {
    return new PjDrawerState();
  }
}

class PjDrawerState extends State<PjDrawer> {
  int _selectedDrawerIndex = 1;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Profile();
      case 1:
        return new EventPage();
      case 2:
        return new AbsensiScreen();
      case 3:
        return GalleryScreen(title: 'TODO');

      default:
        return new Text("Error");
    }
  }

 
  
  _getDrawerFabs(int pos) {
    switch (pos) {
      case 0:
        return new FloatingActionButton(child: new Icon(Icons.create),onPressed: (){},);
      case 1:
        return new FloatingActionButton(child: new Icon(Icons.add),onPressed: (){
           Navigator.push(context, new MaterialPageRoute<DismissDialogAction>(
                builder: (BuildContext context) => new TambahEvent(),
                fullscreenDialog: true,
              ));
        },);
      case 2:
        return new FloatingActionButton(child: new Icon(Icons.archive),onPressed: (){},);
      case 3:
        return new FloatingActionButton(child: new Icon(Icons.add),onPressed: (){
           Navigator.push(context, new MaterialPageRoute<DismissDialogAction>(
                builder: (BuildContext context) => new TambahGallery(),
                fullscreenDialog: true,
              ));
        },);

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0?true:false;
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: showFab?_getDrawerFabs(_selectedDrawerIndex):null,
      bottomNavigationBar: BottomAppBar(
        hasNotch: true,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) => 
                new Drawer(
                  child: new Center(
                    child:new Column(
                    children: <Widget>[
                    new Column(children: drawerOptions)
                    ],
                  ),
              ),
            ),
          );
          },
            ),
            new Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              new Text('Komunitasku', style: new TextStyle(color: Colors.black,fontFamily: 'Poppins', fontSize: 20.0, fontWeight: FontWeight.w700)),
              new Text('.', style: new TextStyle(color: Colors.pink, fontSize: 26.0, fontWeight: FontWeight.w800))
            ],
          ),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
