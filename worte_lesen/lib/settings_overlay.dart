import 'package:flutter/material.dart';
import 'package:worte_lesen/models.dart';
import 'package:worte_lesen/services/database.dart';

class SettingsOverlayDialog<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Settings Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  final _formKey = GlobalKey<FormState>();
  final List<String> list = <String>['1', '2', '3'];
  final List<int> fontSizes = <int>[32, 48, 64, 80, 96, 100, 128, 144, 160];
  List<WordSet> levelList = <WordSet>[];
  String? dropdownValue = '1';
  String? dropdownValue2;
  LeseConfig? config;

  DatabaseHandler handler;

  TextEditingController textController = TextEditingController();
  TextEditingController fontSizeTextController = TextEditingController();

  SettingsOverlayDialog(this.handler, this.config);

  @override
  void dispose() {
    textController.dispose();
    fontSizeTextController.dispose();
    super.dispose();
  }

  void loadConfig() async {
    config = await handler.getConfiguration();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      // alignment: Alignment.center,
      child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Einstellungen',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                hint: const Text("Level auswählen"),
                                isExpanded: true,
                                value: dropdownValue,
                                dropdownColor: Colors.tealAccent,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    print("newValue: $newValue");
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              FutureBuilder(
                                  future: handler.getWordSets(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      levelList = snapshot.data!;
                                      print(levelList.where(
                                        (element) {
                                          return element.name.split('_')[1] ==
                                              dropdownValue;
                                        },
                                      ).toList());
                                    } else if (snapshot.hasError) {
                                      levelList = <WordSet>[];
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          label: Text("Wort Liste"),
                                        ),
                                        hint:
                                            const Text("Wort Liste auswählen"),
                                        value: levelList
                                            .where((wordList) =>
                                                wordList.id ==
                                                    config!.wordSet &&
                                                wordList.name.split('_')[1] ==
                                                    dropdownValue)
                                            .first
                                            .name,
                                        isExpanded: true,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        items: levelList
                                            .map((element) => element.name)
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            print(
                                                "Selected new Wordlist value: $newValue");
                                            dropdownValue2 = newValue!;
                                          });
                                        });
                                  }),
                              const SizedBox(
                                height: 24,
                              ),
                              DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      label: Text("Schriftgröße")),
                                  hint: const Text("Schriftgröße auswählen"),
                                  value: config!.fontSize ?? 160,
                                  items: fontSizes
                                      .map((element) => DropdownMenuItem(
                                          value: element,
                                          child: Text(element.toString())))
                                      .toList(),
                                  onChanged: (value) {
                                    config!.fontSize = value;
                                  }),
                              const SizedBox(
                                height: 24,
                              ),
                              CheckboxFormField(
                                title: Text("Vokale anzeigen"),
                                initialValue: config!.highlightVowel == 1,
                                onSaved: (value) {
                                  config!.highlightVowel = value! ? 1 : 0;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Abbrechen"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {
                                  debugPrint("Save data");
                                  handler.saveConfiguration(config!);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}

// Row(
//                         children: <Widget>[
//                           const Text("Level Auswählen"),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           DropdownButton<String>(
//                             // isExpanded: true,
//                             value: dropdownValue,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             elevation: 16,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 dropdownValue = newValue!;
//                               });
//                             },
//                             items: <String>['1', '2', '3', '4', '5']
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       const Row(
//                         children: [
//                           Text('Wortliste auswählen'),
//                           SizedBox(
//                             width: 10,
//                           ),
//
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           const Text('Anzeige Dauer eintippen:'),
//                           const SizedBox(width: 10),
//                           SizedBox(
//                               width: 100,
//                               child: TextField(
//                                 onChanged: (value) {},
//                                 controller: textController,
//                                 keyboardType: TextInputType.number,
//                                 maxLength: 4,
//                               ))
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           const Text('Font größe eingeben'),
//                           const SizedBox(width: 10),
//                           SizedBox(
//                               width: 100,
//                               child: TextField(
//                                 onChanged: (value) {},
//                                 controller: fontSizeTextController,
//                                 keyboardType: TextInputType.number,
//                                 maxLength: 4,
//                               ))
//                         ],
//                       ),

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {super.key,
      Widget? title,
      super.onSaved,
      super.validator,
      bool super.initialValue = false,
      bool autovalidate = false})
      : super(builder: (FormFieldState<bool> state) {
          return CheckboxListTile(
            dense: state.hasError,
            title: title,
            value: state.value,
            onChanged: state.didChange,
            subtitle: state.hasError
                ? Builder(
                    builder: (BuildContext context) => Text(
                      state.errorText ?? "",
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  )
                : null,
            controlAffinity: ListTileControlAffinity.leading,
          );
        });
}
