import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class EditActivity extends StatefulWidget {
  const EditActivity({Key? key}) : super(key: key);
  static const routeName = '/editActivity';

  @override
  State<EditActivity> createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  List<ActivityTile> listActivity = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pointController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    fillListActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktivitäten  bearbeiten')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                physics: const BouncingScrollPhysics(),
                children: listActivity.map((e) {
                  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
                  TextEditingController titleController2 =
                      TextEditingController(text: e.activity.title);
                  TextEditingController pointController2 =
                      TextEditingController(
                          text: decimalFormat(e.activity.points!));

                  return ListTile(
                    leading: Icon(e.activity.icon, color: Colors.black),
                    title: !e.edit
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text('${e.activity.title}'),
                                Text('${decimalFormat(e.activity.points!)} P.'),
                              ])
                        : Form(
                            key: formKey2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: titleController2,
                                  validator: (value) {
                                    if ((value == null ||
                                        value.isEmpty ||
                                        value == '')) {
                                      return '*';
                                    }
                                    return null;
                                  },
                                )),
                                const SizedBox(width: 10),
                                SizedBox(
                                    width: 60,
                                    child: TextFormField(
                                      controller: pointController2,
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
                                    )),
                                const Text('P.'),
                              ],
                            )),
                    trailing: !e.edit
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => edit(e),
                              ),
                              IconButton(
                                onPressed: () => delete(e),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )
                        : IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: () => save(
                                e, titleController2, pointController2, formKey2),
                          ),
                  );
                }).toList()),
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
                          if ((value == null || value.isEmpty || value == '')) {
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
      ),
    );
  }

  addActivityToList() {}

  void fillListActivity() {
    listActivity = [];
    AllData.activities.sort((a, b) {
      int title = a.title!.compareTo(b.title!);
      if (title != 0) {
        return title;
      } else {
        return a.points!.compareTo(b.points!);
      }
    });
    for (var element in AllData.activities) {
      listActivity.add(ActivityTile(edit: false, activity: element));
    }
  }

  edit(ActivityTile e) {}

  delete(ActivityTile e) {}

  save(ActivityTile e, TextEditingController titleController,
      TextEditingController pointController, GlobalKey<FormState> formKey) {}
}

class ActivityTile {
  bool edit;
  Activity activity;

  ActivityTile({required this.edit, required this.activity});
}
