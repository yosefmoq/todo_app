import 'package:flutter/cupertino.dart';
import 'package:to_do_app/DatabaseHelper.dart';

class Task extends ChangeNotifier{
   int id;
   String title;
   int status;

  Task({this.id, this.title, this.status});

  Map<String, dynamic> toMap() {
    return {
      DataHelper.columnTitle: title,
      DataHelper.columnStatus: status,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, title: $title, status: $status}';
  }
}