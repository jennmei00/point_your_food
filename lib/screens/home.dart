import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punkte_zaehler/models/profiledata.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProfileData profileData = ProfileData.getDummyData();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(150)),
          color: Theme.of(context).primaryColor,
        ),
        // color: Theme.of(context).primaryColor,
        width: double.infinity,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Icon(
                Icons.emoji_people,
                size: 50,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  // profileData.name,
                  'NAME',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  // profileData.email,
                  '',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width / 2 * 0.9,
            //       height: 200,
            //       child:
            Card(
              elevation: 5,
              // shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(50),
              //   topLeft: Radius.circular(10),
              //   bottomLeft: Radius.circular(10),
              //   bottomRight: Radius.circular(10),
              // )),
              color: Theme.of(context).primaryColor,
              child:
                  // Column(
                  //   children: [
                  //     FaIcon(Icons.start, color: Colors.white, size: 70,),
                  //     Text('Startgewicht', textAlign: TextAlign.left,),
                  //     Text('${profileData.startWeight!.weight}'),
                  //   ],
                  // )
                  ListTile(
                textColor: Colors.white,
                title: Row(
                  children: const [
                    FaIcon(Icons.start, color: Colors.white),
                    Text('  Startgewicht'),
                  ],
                ),
                trailing: Text('${profileData.startWeight!.weight}'),
              ),
            ),
            // ),
            // SizedBox(
            //     width: MediaQuery.of(context).size.width / 2 * 0.9,
            //     height: 200,
            //     child:
            //  Card(
            //     elevation: 5,
            //     shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.only(
            //       topRight: Radius.circular(50),
            //       topLeft: Radius.circular(10),
            //       bottomLeft: Radius.circular(10),
            //       bottomRight: Radius.circular(10),
            //     )),
            //     color: Theme.of(context).primaryColor,
            //     child: Column(
            //       children: [],
            //     ))),
            // ],
            // ),
            Card(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              child: ListTile(
                textColor: Colors.white,
                title: Row(
                  children: const [
                    FaIcon(Icons.start, color: Colors.white),
                    Text(' Zielgewicht'),
                  ],
                ),
                trailing: Text('${profileData.targetWeight!.weight}'),
              ),
            ),
            Card(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              child: ListTile(
                textColor: Colors.white,
                title: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.weightScale, color: Colors.white),
                    Text(' Aktuelles Gewicht'),
                  ],
                ),
                trailing: Text('${profileData.currentWeight!.weight}'),
              ),
            ),
            Card(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              child: ListTile(
                textColor: Colors.white,
                title: Row(
                  children: const [
                    FaIcon(
                      Icons.today,
                      color: Colors.white,
                    ),
                    Text(' Tagespunkte'),
                  ],
                ),
                trailing: Text('${profileData.dailyPoints}'),
              ),
            ),
            OutlinedButton(
                onPressed: () => calcDailypointsPressed(context),
                child: const Text('Tagespunkte berechnen'))
          ],
        ),
      )
    ]);
  }

  void calcDailypointsPressed(BuildContext ctx) {
    TextEditingController ageController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    int genderValue = 0;
    int moveDropdown = 0;
    int purposeDropdown = 0;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(ctx).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: genderValue,
                              onChanged: (val) {
                                setState(() {
                                  genderValue = val as int;
                                });
                              },
                            ),
                            GestureDetector(
                              child: const Text('Männlich'),
                              onTap: () {
                                setState(() {
                                  genderValue = 0;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: genderValue,
                              onChanged: (val) {
                                setState(() {
                                  genderValue = val as int;
                                });
                              },
                            ),
                            GestureDetector(
                              child: const Text('Weiblich'),
                              onTap: () {
                                setState(() {
                                  genderValue = 1;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    CustomTextField(
                      onChanged: () {},
                      controller: ageController,
                      mandatory: false,
                      labelText: 'Alter',
                      hintText: '',
                    ),
                    CustomTextField(
                      onChanged: () {},
                      controller: weightController,
                      mandatory: false,
                      labelText: 'Gewicht',
                      hintText: 'in kg',
                    ),
                    CustomTextField(
                      onChanged: () {},
                      controller: heightController,
                      mandatory: false,
                      labelText: 'Größe',
                      hintText: 'in cm',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Bewegung'),
                        DropdownButton(
                            value: moveDropdown,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('Keine Bewegung'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Etwas Bewegung'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('Viel Bewegung'),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text('Täglich viel Bewegung'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                moveDropdown = val as int;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ziel'),
                        DropdownButton(
                            value: purposeDropdown,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('Gewicht halten'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Gewicht senken'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                purposeDropdown = val as int;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Abbrechen')),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Übernehmen')),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
