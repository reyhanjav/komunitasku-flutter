import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
//import 'dart:async';
//import 'CustomIcons.dart';
import 'todo.dart';
import 'package:flutter/foundation.dart';
import 'CustomCheckboxTile.dart';
import 'package:intl/intl.dart';

class ColorChoies {
  static const List<Color> colors = [
    const Color(0xFF5A89E6),
    const Color(0xFFF77B67),
    const Color(0xFF4EC5AC),
  ];
}

List<TodoObject> todos = [
  // new TodoObject.import("SOME_RANDOM_UUID", "Custom", 1, ColorChoies.colors[0], Icons.alarm, [new TaskObject("Task", new DateTime.now()),new TaskObject("Task2", new DateTime.now()),new TaskObject.import("Task3", new DateTime.now(), true)]),
  new TodoObject.import("SOME_RANDOM_UUID", "Why blockchain is hard!", 1, ColorChoies.colors[1], Icons.alarm, {
    new DateTime(2018, 5, 3): [
      new TaskObject("Meet Clients", new DateTime(2018, 5, 3)),
      new TaskObject("Design Sprint", new DateTime(2018, 5, 3)),
      new TaskObject("Icon Set Design for Mobile", new DateTime(2018, 5, 3)),
      new TaskObject("HTML/CSS Study", new DateTime(2018, 5, 3)),
    ],
    new DateTime(2018, 5, 4): [
      new TaskObject("Meet Clients", new DateTime(2018, 5, 4)),
      new TaskObject("Design Sprint", new DateTime(2018, 5, 4)),
      new TaskObject("Icon Set Design for Mobile", new DateTime(2018, 5, 4)),
      new TaskObject("HTML/CSS Study", new DateTime(2018, 5, 4)),
    ]
  }),
  new TodoObject("Challenge", Icons.person),
  new TodoObject("Work", Icons.work),
  new TodoObject("Home", Icons.home),
  new TodoObject("Shopping", Icons.shopping_basket),
  new TodoObject("School", Icons.school),
];



class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GalleryScreenState createState() => new _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> with TickerProviderStateMixin {

  ScrollController scrollController;
  Color backgroundColor;
  Tween<Color> colorTween;
  int currentPage = 0;
  Color constBackColor;

  @override
  void initState() {
    colorTween = new ColorTween(begin: ColorChoies.colors[0], end: ColorChoies.colors[1]);
    backgroundColor = todos[0].color;
    scrollController = new ScrollController();
    scrollController.addListener(() {
      ScrollPosition position = scrollController.position;
      ScrollDirection direction = position.userScrollDirection;
      int page = (position.pixels ~/ (position.maxScrollExtent/(todos.length.toDouble()-1)));
      double pageDo = (position.pixels / (position.maxScrollExtent/(todos.length.toDouble()-1)));
      double percent = pageDo - page;
//      print("int page: " + page.toString());
//      print("double page: " + pageDo.toString());
//      print("percent " + percent.toString());
      if (direction == ScrollDirection.reverse) {
        //page begin 
        if (todos.length-1 < page+1) {
          return;
        }
        colorTween.begin = todos[page].color;
        colorTween.end = todos[page+1].color;
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });
      }else if (direction == ScrollDirection.forward) {
        //+1 begin page end
        if (todos.length-1 < page+1) {
          return;
        }
        colorTween.begin = todos[page].color;
        colorTween.end = todos[page+1].color;
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });
      }else {
        return;
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    final double _width = MediaQuery.of(context).size.width;
    //final double _ratioW =_width/375.0;

    //final double _height = MediaQuery.of(context).size.height;
    //final double _ratioH = _height/812.0;

    

    return new Container(
      // decoration: new BoxDecoration(
      //   image: new DecorationImage(
      //     image: new AssetImage('assets/login.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
          child: new Stack(
          children: <Widget>[
            new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50.0, right: 60.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black38,
                                  offset: new Offset(5.0, 5.0),
                                  blurRadius: 15.0
                                )
                              ],
                              //shape: BoxShape.circle,
                            ),
                            // child: new CircleAvatar(
                            //   backgroundColor: Colors.grey,
                            // ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: new Text(
                            "Agriweb",
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        new Text(
                          "Random shitposting will be placed here",
                          style: new TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        new Text(
                          "Just stay tune!",
                          style: new TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 440.0,
                    width: _width,
                    child: new ListView.builder(
                      itemBuilder: (context, index) {
                        
                        TodoObject gallery = todos[index];
                        EdgeInsets padding = const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 30.0);

                        double percentComplete = gallery.percentComplete();
                        
                        return new Padding(
                          padding: padding,
                          child: new InkWell(
                            onTap: () {
                              
                              Navigator.of(context).push(new PageRouteBuilder(
                                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => new DetailPage(gallery: gallery),
                                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
                                  
                                  return new SlideTransition(
                                    position: new Tween<Offset>(
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: new SlideTransition(
                                      position: new Tween<Offset>(
                                        begin: Offset.zero,
                                        end: const Offset(0.0, 1.0),
                                      ).animate(secondaryAnimation),
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 700)
                              ));
                            },
                            child: new Container(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(4.0),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black.withAlpha(50),
                                    offset: const Offset(0.7, 2.0),
                                    blurRadius: 15.0
                                  )
                                ]
                              ),
                              height: 440.0,
                              child: new Stack(
                                children: <Widget>[
                                  new Hero(
                                    tag: gallery.uuid + "_background",
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.circular(6.0),
                                      ),
                                    ),
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        
                                          new Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Hero(
                                                tag: gallery.uuid + "_icon",
                                                child: new Padding(
                                                  padding: const EdgeInsets.only(top: 12.0),
                                                  child: new Container(
                                                  height: 20.0,
                                                  width: 58.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: backgroundColor,
                                                    borderRadius: new BorderRadius.circular(16.0),
                                                  ),
                                                  child: new Center(
                                                    child: new Material(
                                                    color: Colors.transparent,
                                                    child: new Text('SHITPOSTING',
                                                  style: new TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 8.0,
                                                    fontWeight: FontWeight.w700,

                                                  ),
                                                  ),
                                                  ),
                                                  ),
                                                ),
                                                ),
                                              ),
                                              new Expanded(
                                                child: new Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: new Container(
                                                  alignment: Alignment.topRight,
                                                  child: new Hero(
                                                    tag: gallery.uuid + "share",
                                                    child: new Material(
                                                      color: Colors.transparent,
                                                      type: MaterialType.transparency,
                                                      child: new IconButton(
                                                        icon: new Icon(Icons.share, color: Colors.grey,),
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                  )
                                                ),
                                                ),
                                              )
                                            ],
                                          ),
                                       
                                        new Padding(
                                                  padding: const EdgeInsets.only(left: 1.0, right: 3.0, bottom: 10.0),
                                                  child: new Container(
                                                  alignment: Alignment.topRight,
                                                  child: new Hero(
                                                    tag: gallery.uuid + "photo",
                                                    child: new Material(
                                                      color: Colors.transparent,
                                                      type: MaterialType.transparency,
                                                      child: new Center( 
                                                        child:new Container(
                                                        
                                                        height: 150.0,
                                                        width: 300.0,
                                                        decoration: new BoxDecoration(
                                                        image: new DecorationImage(
                                                          image: new AssetImage('assets/marika.jpg'),
                                                          fit: BoxFit.cover,
                                                         ),
                                                        ),
                                                      ),
                                                      ),
                                                    ),
                                                  )
                                                ),
                                                ),
                                        new Padding(
                                          padding: const EdgeInsets.only(bottom: 10.0),
                                          child: new Align(
                                            alignment: Alignment.bottomLeft,
                                            child: new Hero(
                                              tag: gallery.uuid + "_title",
                                              child: new Material(
                                                color: Colors.transparent,
                                                child: new Text(
                                                  gallery.title,
                                                  style: new TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ),
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: new Align(
                                            alignment: Alignment.bottomLeft,
                                            child: new Hero(
                                              tag: gallery.uuid + "_number_of_tasks",
                                              child: new Material(
                                                color: Colors.transparent,
                                                child: new Text('''So what is a blockchain? Technically speaking, a blockchain is a linked list of blocks and a block is a group of ordered transactions. If you didn’t understand the last sentence,''',
                                                  style: new TextStyle(
                                                  color: Colors.grey[850],
                                                  fontSize: 12.0
                                                    )
                                                  ),
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ),
                          )
                        );

                      },
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      scrollDirection: Axis.horizontal,
                      physics: new CustomScrollPhysics(),
                      controller: scrollController,
                      itemExtent: _width - 80,
                      itemCount: todos.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}

class DetailPage extends StatefulWidget {

  DetailPage({@required this.gallery, Key key}) : super(key: key);

  final TodoObject gallery;

  @override
  _DetailPageState createState() => new _DetailPageState();

}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin{

  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  @override
  void initState() {
    scaleAnimation = new AnimationController(vsync: this, duration: const Duration(milliseconds: 1000), lowerBound: 0.0, upperBound: 1.0);

    percentComplete = widget.gallery.percentComplete();
    barPercent = percentComplete;
    animationBar = new AnimationController(vsync: this, duration: const Duration(milliseconds: 100))..addListener(() {
      setState(() {
        barPercent = animT.lerp(animationBar.value);
      });
    });
    animT = new Tween<double>(begin: percentComplete, end: percentComplete);
    scaleAnimation.forward();
    super.initState();
  }

  void updateBarPercent() async {
    double newPercentComplete = widget.gallery.percentComplete();
    if (animationBar.status == AnimationStatus.forward || animationBar.status == AnimationStatus.completed) {
      animT.begin = newPercentComplete;
      await animationBar.reverse();
    }else if (animationBar.status == AnimationStatus.reverse || animationBar.status == AnimationStatus.dismissed) {
      animT.end = newPercentComplete;
      await animationBar.forward();
    }else {
      print("wtf");
    }
    percentComplete = newPercentComplete;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return new Stack(
      children: <Widget>[
        new Hero(
          tag: widget.gallery.uuid + "_background",
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(0.0),
            ),
          ),
        ),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(Icons.navigate_before, color: Colors.grey,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              new Hero(
                tag: widget.gallery.uuid + "share",
                child: new Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  child: new IconButton(
                    icon: new Icon(Icons.share, color: Colors.grey,),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          body: new ListView(
          children: <Widget>[
            new Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new Hero(
                  tag: widget.gallery.uuid + "photo",
                  child: new Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  child: new Center( 
                    child:new Container(
                                                        
                      height: screenHeight*0.6,
                      width: screenWidth,
                      decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/marika.jpg'),
                        fit: BoxFit.cover,
                        ),
                        ),
                        ),
                        ),
                      ),
                      )
                      ),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.gallery.uuid + "_title",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Text(
                          widget.gallery.title,
                          style: new TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.gallery.uuid + "_icon",
                      child: new Container(
                      height: 20.0,
                      width: 58.0,
                      decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: widget.gallery.color,
                      borderRadius: new BorderRadius.circular(16.0),
                      ),
                      child: new Center(
                        child: new Material(
                        color: Colors.transparent,
                        child: new Text('SHITPOSTING',
                        style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 8.0,
                        fontWeight: FontWeight.w700,
                        ),
                       ),
                      ),
                     ),
                   ),
                  ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Align(
                  alignment: Alignment.bottomLeft,
                  child: new Hero(
                    tag: widget.gallery.uuid + "_number_of_tasks",
                    child: new Material(
                      color: Colors.transparent,
                      child: new Text('''So what is a blockchain? Technically speaking, a blockchain is a linked list of blocks and a block is a group of ordered transactions. If you didn’t understand the last sentence, you can think of a blockchain as a subset of a database, with a few additional properties.

The main thing distinguishing a blockchain from a normal database is that there are specific rules about how to put data into the database. That is, it cannot conflict with some other data that’s already in the database (consistent), it’s append-only (immutable), and the data itself is locked to an owner (ownable), it’s replicable and available. Finally, everyone agrees on what the state of the things in the database are (canonical) without a central party (decentralized).

It is this last point that really is the holy grail of blockchain. Decentralization is very attractive because it implies there is no single point of failure. That is, no single authority will be able to take away your asset or change “history” to suit their needs. This immutable audit trail where you don’t have to trust anyone is the benefit that everyone that’s playing with this technology is looking for. This benefit, however, come at a great cost.

The Cost of Blockchains
The immutable audit trail uncontrolled by any single party is certainly useful, but there are many costs to create such a system. Let’s examine some of the issues.

Development is stricter and slower
Creating a provably consistent system is not an easy task. A small bug could corrupt the entire database or cause some databases to be different than other ones. Of course, a corrupted or split database no longer has any consistency guarantees. Furthermore, all such systems have to be designed from the outset to be consistent. There is no “move fast and break things” in a blockchain. If you break things, you lose consistency and the blockchain becomes corrupted and worthless.''',
                        style: new TextStyle(
                        color: Colors.grey[850],
                        fontSize: 15.0
                  )
                 ),
                ),
                )
                )
                ),
                // new Expanded(
                //   child: new ScaleTransition(
                //     scale: scaleAnimation,
                //     child: new ListView.builder(
                //       padding: const EdgeInsets.all(0.0),
                //       itemBuilder: (BuildContext context, int index) {
                //         DateTime currentDate = widget.gallery.tasks.keys.toList()[index];
                //         DateTime _now = new DateTime.now();
                //         DateTime today = new DateTime(_now.year, _now.month, _now.day);
                //         String dateString;
                //         if (currentDate.isBefore(today)) {
                //           dateString = "Previous - " + new DateFormat.E().format(currentDate);
                //         }else if (currentDate.isAtSameMomentAs(today)) {
                //           dateString = "Today";
                //         }else if (currentDate.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
                //           dateString = "Tomorrow";
                //         }else {
                //           dateString = new DateFormat.E().format(currentDate);
                //         }
                //         List<Widget> tasks = [new Text(dateString)];
                //         widget.gallery.tasks[currentDate].forEach((task) {
                //           tasks.add(new CustomCheckboxListTile(
                //             activeColor: widget.gallery.color,
                //             value: task.isCompleted(),
                //             onChanged: (value) {
                //               setState(() {
                //                 task.setComplete(value);
                //                 updateBarPercent();
                //               });
                //             },
                //             title: new Text(task.task),
                //             secondary: new Icon(Icons.alarm),
                //           ));
                //         });
                //         return new Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: tasks,
                //         );
                //       },
                //       itemCount: widget.gallery.tasks.length,
                //     ),
                //   )
                // )
              ],
            ),
          ),
          ],
          ),
        )
      ],
    );
  }

}


class CustomScrollPhysics extends ScrollPhysics {

  CustomScrollPhysics({ ScrollPhysics parent, }) : super(parent: parent);

  final double numOfItems = todos.length.toDouble()-1;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return new CustomScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / (position.maxScrollExtent/numOfItems);
    // return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    // return page * position.viewportDimension;
    return page * (position.maxScrollExtent/numOfItems);
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity)
      page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return new ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }

}