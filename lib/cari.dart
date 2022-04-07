import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomer/apiService.dart';
import 'package:nomer/dataMurid.dart';
import 'package:http/http.dart' as http;

class CariPage extends StatefulWidget {
  late String keyword;
  CariPage({required this.keyword});

  @override
  _CariPageState createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {
  late Future data;
  List murid = [];
  bool cekData = true;

  @override
  void initState() {
    data = ApiService().dataMurid();
    data.then((value) {
      setState(() {
        murid = value;
        murid = murid
            .where((element) =>
                element.nameMurid
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()) ||
                element.kelasId
                    .toString()
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()))
            .toList();
        if (murid.length == 0) {
          cekData = false;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hasil Pencarian'),
        ),
        body: murid.length != 0
            ? ListView.builder(
                itemCount: murid.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: ListTile(
                        leading: Text(murid[index].nameMurid),
                        trailing: Text(murid[index].numberPhoneMurid),
                      ),
                    ),
                  );
                })
            : !cekData
                ? Center(child: Text('Data Tidak Ada'))
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
