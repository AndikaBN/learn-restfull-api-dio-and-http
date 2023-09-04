import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restfull_api/widget/eror_dialog.dart';

import '../model/person.dart';
import 'package:http/http.dart' as http;

abstract class ReqresService {
  Future<Person?> getDataPerson(BuildContext context, String id);
  Future<Person?> postDataPerson(
      BuildContext context, String firstName, String lastName, String email);
}

class ReqresServiceWithHttp implements ReqresService {
  late final http.Client httpClinet;

  ReqresServiceWithHttp() {
    httpClinet = http.Client();
  }

  @override
  Future<Person?> getDataPerson(BuildContext context, String id) async {
    final Uri uri =
        Uri(scheme: "https", host: 'reqres.in', path: 'api/users/$id');

    try {
      final response = await httpClinet.get(uri);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final responseJson = jsonDecode(responseBody);
        final data = responseJson["data"];
        return Person.fromJson(data);
      }
      return null;
    } catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }

  @override
  Future<Person?> postDataPerson(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
  ) async {
    final Uri uri = Uri(
      scheme: "https",
      host: 'reqres.in',
      path: 'api/users',
    );

    try {
      final response = await httpClinet.post(
        uri,
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        },
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;
        final data = jsonDecode(responseBody);
        return Person(
          id: int.tryParse(data["id"].toString()) ?? 0,
          name: "${data["first_name"]} ${data["last_name"]}",
          email: email,
        );
      }
    } catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }
}

// DIO
class ReqresServiceWithdio implements ReqresService {
  late final Dio _dio;
  ReqresServiceWithdio() {
    _dio = Dio();
  }
  @override
  Future<Person?> getDataPerson(BuildContext context, String id) async {
    final Uri uri =
        Uri(scheme: "https", host: 'reqres.in', path: 'api/users/$id');
    try {
      final response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final data = responseJson["data"];
        return Person.fromJson(data);
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }

  @override
  Future<Person?> postDataPerson(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
  ) async {
    final Uri uri = Uri(
      scheme: "https",
      host: 'reqres.in',
      path: 'api/users',
    );

    try {
      final response = await _dio.post(
        "$uri",
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        final data = response.data;
        return Person(
          id: int.tryParse(data["id"]) ?? 0,
          name: "${data["first_name"]} ${data["last_name"]}",
          email: email,
        );
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }

  Future<List<Person>?> getListPerson(BuildContext context) async {
    try {
      final response = await _dio.get("https://reqres.in/api/users?page=2");
      final data = response.data;
      return List<Person>.from(
        data["data"].map((person) => Person.fromJson(person)),
      );
    } catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }
}
