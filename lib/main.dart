import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Task.dart';
import 'DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yousef Ass Three',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> allTasks = List<Task>();
  List<Task> completedTasks;
  List<Task> notCompletedTasks;

  initState() {
    super.initState();
    getAllTasks2();
    getCompletedTasks2();
    getNotCompletedTasks2();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "All Tasks",
                ),
                Tab(
                  text: "Complete\nTasks",
                ),
                Tab(
                  text: "InComplete\nTasks",
                ),
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                Container(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: allTasks.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            new IconButton(
                                icon: new Icon(Icons.delete),
                                iconSize: 25.0,
                                onPressed: () {}),
                            new Text(
                              allTasks[position].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            new Container(
                                alignment: Alignment.centerRight,
                                child: new Checkbox(
                                    value: allTasks[position].status ==
                                        DataHelper.completed,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (value) {
                                          allTasks[position].status =
                                              DataHelper.completed;
                                        } else {
                                          allTasks[position].status =
                                              DataHelper.isNotComplete;
                                        }
                                        _updateH(
                                            new Task(
                                                id: allTasks[position].id,
                                                title: allTasks[position].title,
                                                status:
                                                    allTasks[position].status),
                                            allTasks[position].status);
                                      });
                                    })),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: completedTasks.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            new IconButton(
                                icon: new Icon(Icons.delete),
                                iconSize: 25.0,
                                onPressed: () {}),
                            new Text(
                              completedTasks[position].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            new Container(
                                alignment: Alignment.centerRight,
                                child: new Checkbox(
                                    value: completedTasks[position].status ==
                                        DataHelper.completed,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (value) {
                                          completedTasks[position].status =
                                              DataHelper.completed;
                                        } else {
                                          completedTasks[position].status =
                                              DataHelper.isNotComplete;
                                        }
                                        _updateH(
                                            new Task(
                                                id: completedTasks[position].id,
                                                title: completedTasks[position].title,
                                                status:
                                                completedTasks[position].status),
                                            completedTasks[position].status);
                                      });
                                    })),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: notCompletedTasks.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            new IconButton(
                                icon: new Icon(Icons.delete),
                                iconSize: 25.0,
                                onPressed: () {}),
                            new Text(
                              notCompletedTasks[position].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            new Container(
                                alignment: Alignment.centerRight,
                                child: new Checkbox(
                                    value: notCompletedTasks[position].status ==
                                        DataHelper.completed,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (value) {
                                          notCompletedTasks[position].status =
                                              DataHelper.completed;
                                        } else {
                                          notCompletedTasks[position].status =
                                              DataHelper.isNotComplete;
                                        }
                                        _updateH(
                                            new Task(
                                                id: notCompletedTasks[position].id,
                                                title: notCompletedTasks[position].title,
                                                status:
                                                notCompletedTasks[position].status),
                                            notCompletedTasks[position].status);
                                      });
                                    })),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _displayDialog(context);
              // _delete();
            },
            tooltip: 'Add Task To Table',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  _insertHY(String title) async {
    Database db = await DataHelper.instance.database;
    Map<String, dynamic> row = {
      DataHelper.columnTitle: title,
      DataHelper.columnStatus: DataHelper.isNotComplete
    };
    await db.insert(DataHelper.table, row);
  }

  _updateH(Task task, int newStatus) async {
    Database db = await DataHelper.instance.database;

    Map<String, dynamic> row = {
      DataHelper.columnTitle: task.title,
      DataHelper.columnId: task.id,
      DataHelper.columnStatus: newStatus
    };

    await db.update(DataHelper.table, row,
        where: "_id = ?", whereArgs: [task.id]);
  }

  ////////////////////////////////////////////////
  //Not Important

  getAllTasks2() async {
    allTasks = List<Task>();
    final Database db = await DataHelper.instance.database;
    var tasks = await db.query(DataHelper.table);
    tasks.forEach((element) {
      setState(() {
        var task = new Task();
        task.id = element["_id"];
        task.title = element["title"];
        task.status = element["status"];
        allTasks.add(task);
      });
    });
  }

  getCompletedTasks2() async {
    completedTasks = List<Task>();
    final Database db = await DataHelper.instance.database;
    var tasks = await db.query(DataHelper.table,
        where: "status = ?", whereArgs: [DataHelper.completed]);
    tasks.forEach((element) {
      setState(() {
        var task = new Task();
        task.id = element["_id"];
        task.title = element["title"];
        task.status = element["status"];
        completedTasks.add(task);
      });
    });
  }

  getNotCompletedTasks2() async {
    notCompletedTasks = List<Task>();
    final Database db = await DataHelper.instance.database;
    var tasks = await db.query(DataHelper.table,
        where: "status = ?", whereArgs: [DataHelper.isNotComplete]);
    tasks.forEach((element) {
      setState(() {
        var task = new Task();
        task.id = element["_id"];
        task.title = element["title"];
        task.status = element["status"];
        notCompletedTasks.add(task);
      });
    });
  }

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write Task Name'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: "Write Task Name"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  var enteredText = _textFieldController.text;
                  print('Entered Text is $enteredText');
                  if (enteredText.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Can't create empty task",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    _insertHY(_textFieldController.text);
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
