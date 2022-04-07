import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nomer/cari.dart';
import 'package:nomer/dataMurid.dart';
import 'package:nomer/folder/tambahData.dart';
// import 'package:nomer/folder/tambahData.dart';
import 'package:nomer/updateMurid.dart';

import 'apiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future data;
  List<Murid> murid = [];
  bool isSearching = true;
  TextEditingController cari = TextEditingController();
  late BuildContext context;
  ApiService _apiService = ApiService();

  void refreshPage() {
    data = ApiService().dataMurid();
    data.then((value) {
      setState(() {
        murid = value;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    refreshPage();
  }

  @override
  void initState() {
    data = ApiService().dataMurid();
    data.then((value) {
      setState(() {
        murid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
          title: isSearching
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data Murid',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            // this.isSearching = !this.isSearching;
                            isSearching = false;
                          });
                        },
                        icon: Icon(Icons.search))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 12,
                      child: TextField(
                        controller: cari,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        decoration: InputDecoration(
                            hintText: 'Pencarian...',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSubmitted: (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariPage(
                                        keyword: cari.text,
                                      )));
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                        icon: Icon(Icons.close))
                  ],
                )),
      body: Container(
          margin: EdgeInsets.all(3),
          child: ListView.builder(
              itemCount: murid.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(murid[index].nameMurid),
                              )),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text("Warning"),
                                            content: Text(
                                                "Are you sure want to delete data profile ${murid[index].nameMurid}?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  _apiService
                                                      .hapusData(
                                                          murid[index].nisn)
                                                      .then((isSuccess) {
                                                    if (isSuccess) {
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                      AlertDialog(
                                                        title: Text(
                                                            'Delete data success'),
                                                      );
                                                      refreshPage();

                                                      Scaffold.of(this.context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Delete data success")));
                                                    } else {
                                                      Navigator.pop(context);
                                                      Scaffold.of(this.context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Delete data failed")));
                                                    }
                                                  });
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("No"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ]);
                                      });
                                },
                                icon: Icon(Icons.delete)),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateMurid(
                                                murid: murid[index])))
                                    .then(onGoBack);
                              },
                              icon: Icon(Icons.edit),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TambahData()))
              .then(onGoBack);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
