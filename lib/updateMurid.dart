import 'package:flutter/material.dart';
import 'package:nomer/apiService.dart';

import 'package:nomer/dataMurid.dart';

class UpdateMurid extends StatefulWidget {
  late Murid murid;
  UpdateMurid({required this.murid});
  @override
  _UpdateMuridState createState() => _UpdateMuridState();
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class _UpdateMuridState extends State<UpdateMurid> {
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
    setState(() {
      _controllerNisn.text = widget.murid.nisn.toString();
      _controllerName.text = widget.murid.nameMurid;
      _controllerEmail.text = widget.murid.emailMurid;
      _controllerNumberPhone.text = widget.murid.numberPhoneMurid.toString();
      _controllerAddress.text = widget.murid.address;
      _controllerGender.text = widget.murid.gender;
      _controllerKelas.text = widget.murid.kelasId.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.murid);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Update Data Murid'),
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
                keyboardType: TextInputType.text,
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
              
                    _apiService.updateProfile(dataMurid).then((isSuccess) {
                      setState(() => _isLoading = false);
                      if (isSuccess) {
                        Navigator.pop(context);
                        _scaffoldState.currentState!.showSnackBar(SnackBar(
                          content: Text("Update data Success"),
                        ));
                      } else {
                        _scaffoldState.currentState!.showSnackBar(SnackBar(
                          content: Text("Update data failed"),
                        ));
                      }
                    });

                    // UpdateMuridMurid(
                    //     _controllerNisn.toString(),
                    //     _controllerName.toString(),
                    //     _controllerEmail.toString(),
                    //     _controllerNumberPhone.toString(),
                    //     _controllerAddress.toString(),
                    //     _controllerGender.toString(),
                    //     _controllerKelas.toString());
                  },
                  child: Text(
                    "Update".toUpperCase(),
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

  void UpdateMuridMurid(String string, String string2, String string3,
      String string4, String string5, String string6, String string7) {}
}
