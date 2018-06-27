import 'package:komunitasku/Screens/pjKomunitas/profile_pj/profile.dart';
import 'package:komunitasku/Screens/pjKomunitas/event_pj/event.dart';
import 'package:komunitasku/Screens/pjKomunitas/absensi/absensi.dart';
import 'package:komunitasku/Screens/pjKomunitas/gallery_pj/gallery.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class UserDrawer extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Profile", Icons.person),
    new DrawerItem("Event", Icons.calendar_today),
    new DrawerItem("Forum", Icons.people),
    new DrawerItem("Gallery", Icons.image),
  ];

  @override
  State<StatefulWidget> createState() {
    return new UserDrawerState();
  }
}

class UserDrawerState extends State<UserDrawer> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ProfileScreen();
      case 1:
        return new EventScreen();
      case 2:
        return new AbsensiScreen();
      case 3:
        return new GalleryScreen();

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
      // appBar: new AppBar(
      //   // here we display the title corresponding to the fragment
      //   // you can instead choose to have a static title
      //   centerTitle: true,
      //   title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      // ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        hasNotch: true,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) => 
                new Drawer(
                  child: new Column(
                  children: <Widget>[
                  new Column(children: drawerOptions)
                ],
              ),
            ),
          );
          },
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
