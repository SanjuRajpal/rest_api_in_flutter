import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_api/api_list.dart';
import 'package:sample_api/beans/UsersBeans/UserBean.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<UserBean> _data;

  Future<String> getUsers() async {
    var response =
        await http.get(APIS.usersList, headers: {"Accept": "application/json"});

    setState(() {
      List res = json.decode(response.body);
      _data = res.map((data) => UserBean.fromJsonMap(data)).toList();
    });
    return "success";
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('USERS'),
        ),
        body: ListView.builder(
            itemCount: _data == null ? 0 : _data.length,
            itemBuilder: (context, index) {
              final item = _data[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.cyan,
                ),
                title: Text(item.name),
                subtitle: Text(item.username),
                isThreeLine: true,
                trailing: Text(item.website),
              );
            }));
  }
}
