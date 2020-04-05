import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/domain.dart';
import 'infrastructure/cognito_service.dart';
import 'view/auth_view.dart';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'main.iconfig.dart';

import 'test.dart';

class CounterStore with ChangeNotifier {
  var count = 0;

  void incrementCounter() {
    count++;
    notifyListeners();
  }
}

final getIt = GetIt.instance;

@injectableInit
void configure() => $initGetIt(getIt);

void main() {
  configure();
  var myApp = getIt.get<MyApp>();
  runApp(myApp);
}

@injectable
class MyApp extends StatelessWidget {
  MyTop my_top;
  LoginTopScreen loginTopScreen;
  MySignup my_signup;

  MyApp(this.my_top, this.loginTopScreen, this.my_signup);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: my_top, routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyCenter(),
      '/test': (BuildContext context) => my_signup,
      '/login': (BuildContext context) => loginTopScreen,
      '/afterlogin': (BuildContext context) => new MyAuthTest(),
      '/aftersingup': (BuildContext context) => my_signup
    });
  }
}

@injectable
class MyTop extends StatelessWidget {
  ServiceB sb;
  MyTop(this.sb);
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
                  child: Text('homeへ'),
                  onPressed: () => Navigator.of(context).pushNamed('/home')),
              RaisedButton(
                  child: Text('sinupテスト'),
                  onPressed: () => Navigator.of(context).pushNamed('/test')),
              RaisedButton(
                  child: Text('Login'),
                  onPressed: () => Navigator.of(context).pushNamed('/login')),
              RaisedButton(
                  child: Text(sb.test()),
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
