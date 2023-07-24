import 'package:flutter/material.dart';
import 'package:networking/networking/json_models/users.dart';
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
  @override
  void initState() {
    _future = RequestRest(endpoint: 'todos/')
        .executeGet<List<Users>>(const UsersParser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('has erorrr');
          print(snapshot.error);
        }
        if (snapshot.hasData) {
          print('talex 2');
          print(snapshot.data);
          return _SuccesWidget(snapshot.data);
        }
        print('inside widget');
        print(snapshot.connectionState);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _SuccesWidget extends StatelessWidget {
  final List<Users>? user;

  const _SuccesWidget(this.user);

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
