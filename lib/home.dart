import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'category_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduHut',
      theme: ThemeData(),
      home: HomeList(),
    );
  }
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  List<Category> _list = List<Category>();
  List<Category> _forDisplay;

  @override
  void initState() {
    {
      setState(() {
        _list = [
          Category('English', 'assets/images/English.jpg'),
          Category('Mathematics', 'assets/images/Mathematics.jpg'),
          Category('History', 'assets/images/History.jpg'),
          Category('Science', 'assets/images/Science.jpg'),
          Category('Biology', 'assets/images/Biology.jpg'),
          Category('Chemistry', 'assets/images/Chemistry.jpg'),
          Category('Physics', 'assets/images/Physics.jpg'),
          Category('Sanskrit', 'assets/images/Sanskrit.jpg'),
        ];
        _forDisplay = _list;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduHut',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Edu',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 40.0,
                  fontFamily: 'Ledgewood',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Hut",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontFamily: 'Panorama',
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
        body: Column(children: <Widget>[
          Container(child: _searchBar()),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text(
              "Courses",
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Ledgewood'),
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(5),
                crossAxisCount: 2,
                itemCount: _forDisplay.length,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                mainAxisSpacing: 15,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage(_list[index].image),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Row(children: <Widget>[
                              Container(
                                width: 15.0,
                              ),
                              Text(
                                _forDisplay[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ]),
                          ),
                          Container(
                              child: Row(children: <Widget>[
                            SizedBox(width: 62.0),
                            Text(
                              "Go to Course",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                                icon: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ))
                          ]))
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.2);
                }),
          )
        ]),
      ),
    );
  }

  _searchBar() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15.0),
        padding: EdgeInsets.symmetric(vertical: 3),
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: TextField(
            decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: new BorderSide(color: Colors.purpleAccent)),
                focusColor: Colors.lightBlueAccent,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                labelText: "Search for courses, subjects...."),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                _forDisplay = _list.where((note) {
                  var noteTitle = note.name.toLowerCase();
                  return noteTitle.contains(text);
                }).toList();
              });
            },
          ),
        ));
  }
}
