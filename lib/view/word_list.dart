import 'package:flutter/material.dart';
import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@injectable
class WordListViewModel with ChangeNotifier {
  Words _words = Words([Word("1", "test")]);
  bool _sort = false;

  List<Word> getWords() {
    return _words.getAll();
  }

  bool getSort() {
    return _sort;
  }
}

@injectable
class WordListScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => WordListViewModel(), child: WordList()
        )
    );
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordListViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          body: DataTable(
            sortAscending: vm.getSort(),
            sortColumnIndex: 0,
            columns: [
              const DataColumn(
                label: Text("単語")
              ),
            ],
            rows: vm.getWords().map(
                (itemRow) => DataRow(
                  cells: [
                    DataCell(
                      Text(itemRow.getId()),
                      showEditIcon: false,
                      placeholder: false,
                      )
                  ],
                )
            ).toList()
          )
        );
      },
    );
  }
}
