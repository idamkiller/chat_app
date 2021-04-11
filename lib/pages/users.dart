import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    User(uid: '1', name: 'Ivan', email: 'ivan@gmail.com', online: true),
    User(uid: '2', name: 'Dario', email: 'dario@gmail.com', online: true),
    User(uid: '3', name: 'Avila', email: 'avila@gmail.com', online: true),
    User(
        uid: '4', name: 'Martinez', email: 'martinez@gmail.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.name,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black87,
            ),
            onPressed: () {
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadingUsers,
          header: WaterDropMaterialHeader(
            backgroundColor: Colors.blue[300],
          ),
          child: _listViewUsers(),
        ));
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _userListTitle(users[index]),
      separatorBuilder: (context, index) => Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTitle(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: (user.online) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _loadingUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
