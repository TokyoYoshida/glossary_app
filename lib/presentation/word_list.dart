import 'package:flutter/material.dart';
import 'package:glossaryapp/application/service/word_service.dart';
import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@injectable
class WordListViewModel with ChangeNotifier {
  WordService _wordService;
  Words _words;

  WordListViewModel(this._wordService) {
    _words = _wordService.getAll();
  }

  bool _sort = false;

  int itemCount() {
    return _words.getCount();
  }

  String getTheWord(int index) {
    return _words.get(index).getTheWord();
  }

  String getPronunciation(int index) {
    return _words.get(index).getPronunciation();
  }

  String getMeaning(int index) {
    return _words.get(index).getMeaning();
  }

  bool getSort() {
    return _sort;
  }
}

@injectable
class WordListScreen extends StatelessWidget {
  WordListViewModel _vm;

  WordListScreen(this._vm);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => _vm, child: WordList()));
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordListViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
            appBar: AppBar(title: const Text("単語帳")),
            body: ListView.builder(
                itemCount: vm.itemCount(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/wordDetail');
                      },
                      child: Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    vm.getTheWord(index),
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                  leading: Icon(Icons.subject),
                                  subtitle: Text(vm.getPronunciation(index)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 73.0),
                                    child: Text(vm.getMeaning(index)))
                              ],
                            )),
                      ));
                }));
      },
    );
  }
}
