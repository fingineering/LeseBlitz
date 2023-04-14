import 'package:flutter/material.dart';
import 'package:worte_lesen/models.dart';

class SettingsOverlayDialog<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Settings Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  final List<String> list = <String>['1', '2', '3'];
  String dropdownValue = '1';
  String dropdownValue2 = '3';
  TextEditingController textController = TextEditingController();
  TextEditingController fontSizeTextController = TextEditingController();

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      // alignment: Alignment.center,
      child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: UnconstrainedBox(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Einstellungen',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("Level Auswählen"),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['1', '2', '3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Wortliste auswählen'),
                        const SizedBox(
                          width: 10,
                        ),
                        // DropdownButton<String>(
                        //     value: dropdownValue2,
                        //     icon: const Icon(Icons.arrow_drop_down),
                        //     items: <String>['Liste 1', 'Liste2', 'Liste 3']
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     onChanged: (String? newValue) {
                        //       setState(() {
                        //         dropdownValue2 = newValue!;
                        //       });
                        //     })
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Anzeige Dauer eintippen:'),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 100,
                            child: TextField(
                              onChanged: (value) {},
                              controller: textController,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Font größe eingeben'),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 100,
                            child: TextField(
                              onChanged: (value) {},
                              controller: fontSizeTextController,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Abbrechen"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(onPressed: null, child: Text('Save'))
                      ],
                    )
                  ],
                )),
          )),
    );
  }
}
