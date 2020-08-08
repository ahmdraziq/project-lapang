import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_layout_1/components/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

const String url = "http://192.168.1.67:9090/api/";
// const String url = "https://localhost/api/";

Future<bool> login(dynamic credential, BuildContext context) async {
  bool isLogged = false;
  await http
      .post(url + "auth/authenticate",
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(credential))
      .then((value) async {
    if (value.statusCode != 404) {
      SharedPreferences shared = await SharedPreferences.getInstance();
      await shared.setString("token", jsonDecode(value.body));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: credential['email'], password: credential['password']);

      isLogged = true;
    } else {
      throw ("User account does not exist! Please register new account.");
    }
  }).catchError((onError) {
    showToast(onError, context, gravity: Toast.BOTTOM, duration: 5);
  });

  return isLogged;
}

Future<bool> registeruser(dynamic credential, BuildContext context) async {
  bool registered = false;
  await http
      .post(url + "auth/register",
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(credential))
      .then((value) {
    if (value.statusCode == 201)
      registered = true;
    else {
      var ex = jsonDecode(value.body);
      throw (ex['Message']);
    }
  }).catchError((onError) {
    showToast(onError, context, duration: 5, gravity: Toast.BOTTOM);
  });

  return registered;
}

Future<dynamic> authorizedgetrequest(
    String theLink, BuildContext context) async {
  dynamic json;
  SharedPreferences shared = await SharedPreferences.getInstance();
  await http.get(url + theLink, headers: <String, String>{
    "Content-Type": "application/json; charset=UTF-8",
    "Authorization": "Bearer ${shared.getString('token')}",
  }).then((value) {
    if (value.statusCode != 200) {
      throw ("Your token does not valid anymore! Please re-login.");
    } else {
      json = jsonDecode(value.body);
    }
  }).catchError((onError) {
    showToast(onError, context, gravity: Toast.BOTTOM, duration: 5);
  });

  return json;
}

Future<bool> authorizedpostrequest(
    String theLink, dynamic credential, BuildContext context) async {
  bool isSuccess = false;
  SharedPreferences shared = await SharedPreferences.getInstance();
  await http
      .post(url + theLink,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer ${shared.getString('token')}"
          },
          body: jsonEncode(credential))
      .then((value) async {
    if (value.statusCode != 201) {
      isSuccess = true;
    } else {
      throw (jsonDecode(value.body));
    }
  }).catchError((onError) {
    showToast(onError, context, gravity: Toast.BOTTOM, duration: 5);
  });

  return isSuccess;
}
