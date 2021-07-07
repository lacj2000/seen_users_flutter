import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seen_users_flutter/UserScreen.dart';
import 'package:seen_users_flutter/Users.dart';

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  return parseUsers(response.body);
}

List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: FutureBuilder<List<User>>(
          future: fetchUsers(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? UserList(users: snapshot.data as List<User>)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;

  UserList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserScreen(user: users[index]),
            ),
          ),
        );
      },
    );
  }
}
