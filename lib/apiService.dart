import 'dart:convert';

  import 'package:http/http.dart' as http;
import 'package:nomer/dataMurid.dart';

class ApiService {
  static final String _baseUrl = 'https://app-sekolah.herokuapp.com/api/murid';

  Future dataMurid() async {
    Uri urlApi = Uri.parse(_baseUrl);
    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      return muridFromJson(response.body);
    } else {
      throw Exception('Failde To Load Top Headlines');
    }
  }

  Future<bool> dataBaru(Murid dataMurid) async {
    Uri urlApi = Uri.parse(_baseUrl);
    final response = await http.post(
      urlApi,
      headers: {"content-type": "application/json"},
      body: jsonEncode(dataMurid),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hapusData(int nisn) async {
    Uri urlApi = Uri.parse('$_baseUrl/$nisn');
    final response = await http.delete(
      urlApi,
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Murid dataMurid) async {
    String nisn = dataMurid.nisn.toString();
    Uri urlApi = Uri.parse("$_baseUrl/$nisn");
    print(urlApi);
    print(jsonEncode(dataMurid));
    final response = await http.put(
      urlApi,
      headers: {"content-type": "application/json"},
      body: jsonEncode(dataMurid),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
// (int _controllerNisn,String _controllerName,String _controllerEmail, int _controllerNumberPhone,String _controllerAddress,String _controllerGender,int _controllerKelas )
// ({
//         "nisn": _controllerNisn,
//         "name_murid": _controllerName,
//         "email_murid": _controllerEmail,
//         "number_phone_murid": _controllerNumberPhone,
//         "address": _controllerAddress,
//         "gender": _controllerGender,
//         "kelas_id": _controllerKelas,
//          "created_at": DateTime.now(),
//         "updated_at": DateTime.now()
//       })



// Future dataBaru(int _controllerNisn,String _controllerName,String _controllerEmail, int _controllerNumberPhone,String _controllerAddress,String _controllerGender,int _controllerKelas )async {
//     Uri urlApi = Uri.parse(_baseUrl);
//     final response = await http.post(
//       urlApi,
//       headers: {"content-type": "application/json"},
//       body: ({
//         "nisn": _controllerNisn,
//         "name_murid": _controllerName,
//         "email_murid": _controllerEmail,
//         "number_phone_murid": _controllerNumberPhone,
//         "address": _controllerAddress,
//         "gender": _controllerGender,
//         "kelas_id": _controllerKelas,
//          "created_at": DateTime.now(),
//         "updated_at": DateTime.now()
//       }),
//     );
//     if (response.statusCode == 201) {
//       print('Berhasil');
//     } else {
//       print('Gagal');
//     }
//   }