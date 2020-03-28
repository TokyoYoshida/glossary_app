import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/domain.dart';
import 'infrastructure/cognito_service.dart';
import 'view/auth_view.dart';
import 'test.dart';

import 'di/app_injector.dart';
import 'package:inject/inject.dart';

class CounterStore with ChangeNotifier {
  var count = 0;

  void incrementCounter() {
    count++;
    notifyListeners();
  }
}


void main() async {
  final container = await AppInjector.create();
  runApp(container.app);
}

@provide
class MyApp extends StatelessWidget {
  MyTop mytop;

  MyApp(this.mytop) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: mytop, routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyCenter(),
      '/test': (BuildContext context) => new MySignup(),
      '/login': (BuildContext context) => new LoginTopScreen(),
      '/afterlogin': (BuildContext context) => new MyAuthTest(),
      '/aftersingup': (BuildContext context) => new MySignup()
    });
  }
}

@provide
class MyTop extends StatelessWidget {
  Employee employee;
  MyTop(this.employee) : super();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('サンプル'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('ライセンスページの表示'),
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: 'Sample',
                  applicationVersion: '1.0.0',
                ),
              ),
              RaisedButton(
                  child: Text('起動'),
                  onPressed: () => Navigator.of(context).pushNamed('/home')),
              RaisedButton(
                  child: Text('sinupテスト'),
                  onPressed: () => Navigator.of(context).pushNamed('/test')),
              RaisedButton(
                  child: Text('Login'),
                  onPressed: () => Navigator.of(context).pushNamed('/login')),
              RaisedButton(
                  child: Text(employee.test()),
                  onPressed: () => Navigator.of(context).pushNamed('/battery')),
              Text("test"),
            ],
          ),
        ));
  }
}

class MyAuthTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Text(CognitoService.test())
    );
  }
}


class MyCenter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => CounterStore(), child: MyHomePage()
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterStore>(
      builder: (context, counterStore, _) {
        return Scaffold(
          body: Center(child: Text('${counterStore.count}')),
          floatingActionButton: FloatingActionButton(
            onPressed: counterStore.incrementCounter,
          ),
        );
      },
    );
  }
}
