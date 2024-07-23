import 'package:community_material_icon/community_material_icon.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:uuid/uuid.dart';

class Activities extends StatefulWidget {
  final String diaryId;

  const Activities({Key? key, required this.diaryId}) : super(key: key);
  static const routeName = '/activities';

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  Duration duration = const Duration(minutes: 30);
  double activityPoint = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aktivitäten'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                  children: AllData.activities
                      .map(
                        (e) => GestureDetector(
                          child: ListTile(
                            leading: Icon(e.icon, color: Colors.black),
                            title: Text('${e.title}'),
                            trailing: Text('${decimalFormat(e.points!)} P.'),
                          ),
                          onTap: () => onTapActivity(e),
                        ),
                      )
                      .toList()),
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
              child: Form(
                key: formKey,
                child: ListTile(
                  leading: const Icon(
                    CommunityMaterialIcons.human_handsup,
                    color: Colors.black,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        validator: (value) {
                          if ((value == null || value.isEmpty || value == '')) {
                            return '*';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: 'Titel'),
                        controller: titleController,
                      )),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          validator: (value) {
                            if ((value == null ||
                                value.isEmpty ||
                                value == '')) {
                              return '*';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
                          ],
                          decoration: const InputDecoration(hintText: 'Punkte'),
                          controller: pointController,
                        ),
                      ),
                    ],
                  ),
                  trailing: OutlinedButton(
                    child: const Icon(CommunityMaterialIcons.arrow_up_bold),
                    onPressed: () => addActivityToList(),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  onTapActivity(Activity a) {
    activityPoint = a.points!;
    duration = const Duration(minutes: 30);
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(
                          a.icon,
                          color: Colors.black,
                        ),
                        title: Text(
                          '${a.title}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${decimalFormat(activityPoint)} P.',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: const Text('Dauer'),
                        trailing: GestureDetector(
                          child: Text(duration.inMinutes.toString()),
                          onTap: () => onTapDuration(setState, a.points!),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => addFitpoint(a),
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                            shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text('   Übernehmen   '),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  onTapDuration(StateSetter setState, double oldPoints) async {
    var dur = await showDurationPicker(
      context: context,
      initialTime: duration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
    );

    if (dur != null) {
      setState(() {
        duration = dur;
        activityPoint = calcNewPoint(oldPoints);
      });
    }
  }

  double calcNewPoint(double oldPoints) {
    double d = 0;

    d = roundPoints(duration.inMinutes * oldPoints / 30);

    return d;
  }

  Future<void> addFitpoint(Activity a) async {
    FitPoint f = FitPoint(
        id: const Uuid().v1(),
        diaryId: widget.diaryId,
        activityId: a.id,
        duration: const Duration(minutes: 30),
        points: calcNewPoint(a.points!));
    DBHelper.insert('Fitpoint', f.toMap());
    AllData.fitpoints.add(f);
    AllData.diaries
        .firstWhere((element) => element.id == widget.diaryId)
        .activities!
        .add(AllData.activities.firstWhere((element) => element.id == a.id));
    AllData.diaries
        .firstWhere((element) => element.id == widget.diaryId)
        .fitpoints!
        .add(f);

    calcDailyRestPoints(add: false, diaryId: widget.diaryId, points: f.points!);

    await DBHelper.update(
        'Diary',
        AllData.diaries
            .firstWhere((element) => element.id == widget.diaryId)
            .toMap(),
        where: 'ID = "${widget.diaryId}"');

    popScreen();
  }

  void popScreen() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  addActivityToList() async {
    if (formKey.currentState!.validate()) {
      Activity a = Activity(
          id: const Uuid().v1(),
          title: titleController.text,
          points: roundPoints(doubleCommaToPoint(pointController.text)),
          icon: CommunityMaterialIcons.human_handsup);

      AllData.activities.add(a);
      await DBHelper.insert('Activity', a.toMap());

      setState(() {
        titleController.text = '';
        pointController.text = '';
      });
    }
  }
}
