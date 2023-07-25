import 'package:flutter/material.dart';
import 'package:networking/networking/json_models/users.dart';
import 'package:networking/networking/json_parsers/json_user_parser.dart';
import 'package:networking/networking/json_parsers/list_of_users_parser.dart';
import 'package:networking/networking/services/request_rest.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user API'),
      ),
      body: const _MyWidget(),
    );
  }
}

class _MyWidget extends StatefulWidget {
  const _MyWidget();

  @override
  State<_MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<_MyWidget> {
  late final Future<List<Users>> _future;
  late final Future<Users> _future_user;
  @override
  void initState() {
    _future_user =
        RequestRest(endpoint: 'todos/1').executeGet<Users>(const UserParser());
    _future = RequestRest(endpoint: 'todos/')
        .executeGet<List<Users>>(const UsersParser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.hasError) {
          print('has erorrr');
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data != null) {
            // print(snapshot.connectionState);
            return _SuccesListOfUsersWidget(data);
            // return _SuccesListOfUsersWidget(data);
          }
          print('talex 2');
          print(snapshot.data);
          return const CircularProgressIndicator(
            color: Colors.red,
          );
        }
        print('inside widget');
        print(snapshot.connectionState);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// to display a single user
class _SuccessUserWidget extends StatelessWidget {
  final Users user;
  const _SuccessUserWidget(this.user);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${user.title}'),
    );
  }
}

//to display a list of users
class _SuccesListOfUsersWidget extends StatelessWidget {
  final List<Users>? user;

  const _SuccesListOfUsersWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: user?.length,
        itemBuilder: (context, index) {
          return Text(user?[index].title ?? '');
        },
      ),
    );
  }
}
