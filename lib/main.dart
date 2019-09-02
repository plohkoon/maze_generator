import 'package:flutter/material.dart';
import 'package:maze_generator/ColorSlider/ColorSlider.dart';
import 'package:maze_generator/maze/Maze.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: "Maze Game"
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.title);
}

class _MyHomePageState extends State<MyHomePage> {
  //initializes the state
  bool accessibleControls = false;
  bool darkMode = false;
  final String title;
  //index of color to use
  int currentColor = 0;
  //page that currently on, 0 is home
  int page = 0;
  //constructor
   _MyHomePageState(this.title);
  //function to set the index of color to use in Colors.primaries
  void setColor(index) {
    setState(() {
      this.currentColor = index.toInt();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      //theme data toggles with dark mode toggle
      theme: ThemeData (
        primarySwatch: Colors.primaries[this.currentColor.toInt()]
      ),
      home: SafeArea(
        child: Scaffold(
          //appBar that contains the title and accessibility controls
          appBar: AppBar(
            title: Row(
              children: [
                Text(this.title),
                Expanded(child: Row(),),
                //renders accessibility controls label and a switch to toggle it
                Row(
                  children: [
                    Text("Accessibility Controls"),
                    Switch(
                      value: accessibleControls,
                      onChanged: (bool newVal) {
                        setState(() {
                          this.accessibleControls = !this.accessibleControls;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          //the maze is the body of the app
          body: [
            ColorSlider(
              currentValue: currentColor,
              setColor: setColor,
            ),
            Maze.blitz(
              accessibleControls: this.accessibleControls,
            ),
            Maze.timeRush(
              accessibleControls: this.accessibleControls,
            )
          ][page],
          //NavBar to switch between game modes and menu
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              print(index);
              setState(() {
                page = index;
              });
            },
            currentIndex: page,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("Blitz"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add_check),
                title: Text("Time Rush"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
