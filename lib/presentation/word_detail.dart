import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordDetailViewModel with ChangeNotifier {
}

@injectable
class WordDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => WordDetailViewModel(), child: WordDetail()
        )
    );
  }
}

class WordDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordDetailViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
            appBar: AppBar(title: const Text("単語帳")),
            body: Text("test")
        );
      },
    );
  }
}
