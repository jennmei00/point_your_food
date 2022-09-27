import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/screens/settings/edit_activity.dart';
import 'package:punkte_zaehler/screens/settings/edit_food.dart';
import 'package:punkte_zaehler/screens/settings/profile.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  PointSafeDelete groupValue = PointSafeDelete.withWeigh;
  bool checkboxValue = true;
  TextEditingController pointController = TextEditingController();

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ListView(
        children: [
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text(
                'Profil',
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Profile.routeName);
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.food_bank),
              title: Text(
                'Essen bearbeiten',
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(EditFood.routeName);
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.local_activity),
              title: Text(
                'Aktivitäten bearbeiten',
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(EditActivity.routeName);
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.safety_check),
            title: const Text(
              'Punktetresor',
            ),
            subtitle: groupValue == PointSafeDelete.withWeigh
                ? const Text('Löschen bei Eingabe von Wiegedaten')
                : groupValue == PointSafeDelete.everyMonday
                    ? const Text('Jeden Montag löschen')
                    : const Text('Jeden Sonntag löschen'),
            children: [
              RadioListTile<PointSafeDelete>(
                groupValue: groupValue,
                onChanged: (PointSafeDelete? value) => changeGroupValue(value),
                value: PointSafeDelete.withWeigh,
                title: const Text('Eingabe von Wiegedaten'),
              ),
              RadioListTile<PointSafeDelete>(
                groupValue: groupValue,
                onChanged: (PointSafeDelete? value) => changeGroupValue(value),
                value: PointSafeDelete.everyMonday,
                title: const Text('Jeden Montag'),
              ),
              RadioListTile<PointSafeDelete>(
                groupValue: groupValue,
                onChanged: (PointSafeDelete? value) => changeGroupValue(value),
                value: PointSafeDelete.everySunday,
                title: const Text('Jeden Sonntag'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Punkte ändern (akt: ${decimalFormat(AllData.profiledata.pointSafe!)}): ',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
                                  ],
                                  controller: pointController,
                                ),
                              ),
                              const Text(' Punkte'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            if (pointController.text != '') {
                              AllData.profiledata.pointSafe =
                                  double.tryParse(pointController.text);
                              AllData.profiledata.pointSafeDate =
                                  DateTime.now();
                              DBHelper.update(
                                  'Profiledata', AllData.profiledata.toMap());
                              pointController.text = '';

                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ListTile(
              //   title: SizedBox(
              //         width: 90,
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: TextField(
              //                 inputFormatters: [
              //                   FilteringTextInputFormatter.allow(RegExp(
              //                       r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
              //                 ],
              //                 // controller: weightController,
              //                 // onChanged: (val) => onWeightChanged(),
              //               ),
              //             ),
              //             const Text(' Punkte'),
              //           ],
              //         ),
              //       ),
              //   // title: Expanded(
              //   //     child: TextField(
              //   //   decoration: InputDecoration(
              //   //     labelText: 'Punkte im Tresor',
              //   //     hintText: '${AllData.profiledata.pointSafe}',
              //   //     border: const OutlineInputBorder(
              //   //         borderRadius: BorderRadius.all(Radius.circular(10))),
              //   //   ),
              //   // )),
              //   trailing: IconButton(
              //     icon: Icon(Icons.save),
              //     onPressed: () {},
              //   ),
              // )
            ],
          ),
          GestureDetector(
            child: ListTile(
              leading: const Icon(Icons.calendar_view_day),
              title: const Text(
                'Tagespunkte',
              ),
              subtitle:
                  const Text('Automatisch bei Änderung des Gewichts anpassen?'),
              trailing: Checkbox(
                value: checkboxValue,
                onChanged: (val) => checkBoxChanged(val),
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(Credits.routeName);
            },
          ),
          // SwitchListTile(
          //   secondary: const Icon(Icons.lightbulb),
          //   title: const Text('Darkmode'),
          //   onChanged: (val) {},
          //   value: true,
          // ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.my_library_books),
              title: Text(
                'Credits',
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(Credits.routeName);
            },
          ),
          GestureDetector(
              child: const ListTile(
                leading: Icon(
                  Icons.description,
                ),
                title: Text('Lizensen'),
              ),
              onTap: () => showLicensePage(
                    context: context,
                    applicationIcon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      // child: Image.asset(
                      //   // 'assets/images/logo2.png',
                      //   width: 48,
                      // ),
                    ),
                    applicationName: 'PointYourFood',
                    // applicationVersion: '${Globals.version}'
                    //  '1.0.0',
                    // applicationLegalese: 'Copyright My Company'
                  )),

          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text(
                'Daten löschen',
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(Credits.routeName);
            },
          ),

          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Abmelden',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(Credits.routeName);
            },
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    groupValue =
        PointSafeDelete.values[AllData.prefs.getInt('deletePointsafeDay')!];
    checkboxValue = AllData.prefs.getBool('autoDailypointChange')!;
  }

  changeGroupValue(PointSafeDelete? value) {
    groupValue = value!;
    AllData.prefs.setInt('deletePointsafeDay', value.index);
    setState(() {});
  }

  checkBoxChanged(bool? value) {
    checkboxValue = value!;
    AllData.prefs.setBool('autoDailypointChange', value);
    setState(() {});
  }
}
