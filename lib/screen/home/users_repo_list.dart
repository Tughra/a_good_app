import 'package:flutter/material.dart';

class UsersRepoList extends StatelessWidget {
  const UsersRepoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      title: Text("totalPower"),
      subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("totalStar"),
          Text("totalAttendance"),
        ],
      ),

    ));
  }
}
