import 'package:flutter/material.dart';
import 'package:glossaryapp/presentation/word_detail.dart';
import 'package:glossaryapp/presentation/word_list.dart';
import 'package:provider/provider.dart';

import 'package:glossaryapp/presentation/login.dart';
import 'package:glossaryapp/presentation/verification_user.dart';

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
  LoginScreen login;
  VerificationUserScreen my_signup;
  WordListScreen _wordList;
  WordDetailScreen _wordDetail;

  MyApp(this.my_top, this.login, this.my_signup, this._wordList, this._wordDetail);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: my_top, routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyCenter(),
      '/test': (BuildContext context) => my_signup,
      '/login': (BuildContext context) => login,
      '/verificationUser': (BuildContext context) => my_signup,
      '/wordList': (BuildContext context) => _wordList,
      '/wordDetail': (BuildContext context) => _wordDetail,
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
              RaisedButton(
                  child: Text('word list'),
                  onPressed: () => Navigator.of(context).pushNamed('/wordList')),
              RaisedButton(
                  child: Text('word detail'),
                  onPressed: () => Navigator.of(context).pushNamed('/wordDetail')),
              Text("test"),
            ],
          ),
        ));
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
