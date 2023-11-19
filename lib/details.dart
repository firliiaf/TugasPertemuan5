import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'editdata.dart';
import 'main.dart';

class Details extends StatefulWidget {
  List list;
  int index;
  Details({required this.list, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    var url =
        Uri.parse('http://192.168.56.1/tugas5/delete.php'); //deletion api
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Hapus Data?"),
      actions: [
        MaterialButton(
          child: const Text("Hapus"),
          onPressed: () {
            delete();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MyApp(),
            ));
          },
        ),
        MaterialButton(
          child: const Text("Tidak"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Data Karyawan",
            style: TextStyle(
              fontSize: 20.0,
              // color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color.fromARGB(255, 7, 255, 164))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Name  : ${widget.list[widget.index]['name']}"),
                            SizedBox(height: 3),
                            Text(
                                "Address : ${widget.list[widget.index]['address']}"),
                            SizedBox(height: 3),
                            Text(
                                "Salary  : ${widget.list[widget.index]['salary']}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: MaterialButton(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.cyan,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Edit(list: widget.list, index: widget.index),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: MaterialButton(
                        child: Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.cyan,
                        onPressed: () {
                          confirm();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}