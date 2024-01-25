import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, Params>((ref, params) async {
  final resp = await http.post(Uri.parse("https://reqres.in/api/login"),
      body: {'email': params.email, 'password': params.password});

  final Map<String, dynamic> responseData = json.decode(resp.body);
  if (resp.statusCode == 200) {
    return responseData;
  } else {
    return responseData;
  }
});

final usersProvider = FutureProvider<Map<String,dynamic>>((ref) async {
  try{
    final resp = await http.get(Uri.parse("https://reqres.in/api/users"));
    if(resp.statusCode == 200) {
      final Map<String, dynamic> result = json.decode(resp.body);
      return result;
    } else {
      throw Exception('Kullanıcılar yüklenemedi.');
    }
  }catch(err) {
    throw Exception("Kullanıcılar yüklenemedi - $err");
  }
});

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}
