import 'package:flutter/material.dart';

class MuridBaru extends StatefulWidget {
  const MuridBaru({Key? key}) : super(key: key);

  @override
  _MuridBaruState createState() => _MuridBaruState();
  
}
TextEditingController nisn = TextEditingController();
class _MuridBaruState extends State<MuridBaru> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: nisn,
          )
        ],
      ),
    );
  }
}
