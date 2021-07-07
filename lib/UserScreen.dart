import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seen_users_flutter/Users.dart';

class UserScreen extends StatelessWidget {
  final User user;

  UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text('Nome :'),
            title: Text(user.name),
          ),
          ListTile(
            leading: Text('Username:'),
            title: Text(user.username),
          ),
          ListTile(
            leading: Text('Email:'),
            title: Text(user.email),
          ),
        ],
      ),
    );
  }
}
