import 'package:flutter/material.dart';
import 'package:nomer/apiService.dart';

import 'package:nomer/dataMurid.dart';

class TambahData extends StatefulWidget {
  // late Murid murid;
  // TambahData({required this.murid});
  _TambahDataState createState() => _TambahDataState();
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class _TambahDataState extends State<TambahData> {
  late Future data;
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  TextEditingController _controllerNisn = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNumberPhone = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerGender = TextEditingController();
  TextEditingController _controllerKelas = TextEditingController();

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Tambah Data Murid Baru'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _controllerNisn,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Nisn",
                ),
              ),
              TextFormField(
                controller: _controllerName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Nama",
                ),
              ),
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                controller: _controllerNumberPhone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Number Phone",
                ),
              ),
              TextFormField(
                controller: _controllerAddress,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: "Address",
                ),
              ),
              TextFormField(
                controller: _controllerGender,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Gender",
                ),
              ),
              TextFormField(
                controller: _controllerKelas,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Kelas",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    // simpanData();
                    // Navigator.pop(context);
                    int nisn = int.parse(_controllerNisn.text.toString());
                    String name = _controllerName.text.toString();
                    String email = _controllerEmail.text.toString();
                    String numberPhone = _controllerNisn.text.toString();
                    String address = _controllerAddress.text.toString();
                    String gender = _controllerGender.text.toString();
                    int kelas = int.parse(_controllerKelas.text.toString());
                    Murid dataMurid = Murid(
                        nisn: nisn,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        address: address,
                        gender: gender,
                        nameMurid: name,
                        emailMurid: email,
                        kelasId: kelas,
                        numberPhoneMurid: numberPhone);

                    _apiService.dataBaru(dataMurid).then((isSuccess) {
                      setState(() => _isLoading = false);
                      if (isSuccess) {
                        AlertDialog(
                          title: Text('Behasil'),
                        );
                        Navigator.pop(context);
                        _scaffoldState.currentState!.showSnackBar(SnackBar(
                          content: Text("Add data success"),
                        ));
                      } else {
                        _scaffoldState.currentState!.showSnackBar(SnackBar(
                          content: Text("Add data failed"),
                        ));
                      }
                    });
                    //  if (widget.murid == null) {
                    //     _apiService.updateProfile(dataMurid).then((isSuccess) {
                    //       setState(() => _isLoading = false);
                    //       if (isSuccess) {
                    //         Navigator.pop(context);
                    //       } else {
                    //         _scaffoldState.currentState!.showSnackBar(SnackBar(
                    //           content: Text("Submit data failed"),
                    //         ));
                    //       }
                    //     });
                    //   } else {
                    //     // m.id = widget.murid.id;
                    //     _apiService.updateProfile(dataMurid).then((isSuccess) {
                    //       setState(() => _isLoading = false);
                    //       if (isSuccess) {
                    //         Navigator.pop(_scaffoldState.currentState!.context);
                    //       } else {
                    //         _scaffoldState.currentState!.showSnackBar(SnackBar(
                    //           content: Text("Update data failed"),
                    //         ));
                    //       }
                    //     });
                    //   }

                  },
                  child: Text(
                    "Submit".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.orange[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
