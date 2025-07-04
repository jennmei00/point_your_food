import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:uuid/uuid.dart';

class EditActivity extends StatefulWidget {
  const EditActivity({super.key});
  static const routeName = '/editActivity';

  @override
  State<EditActivity> createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  List<ActivityTile> listActivity = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pointController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool search = false;
  TextEditingController searchController = TextEditingController(text: '');
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    fillListActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !search
            ? const Text('Aktivitäten  bearbeiten')
            : TextField(
                onChanged: (query) => searchActivity(query),
                // autofocus: true,
                focusNode: searchFocusNode,
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Suche',
                  hintStyle: TextStyle(color: Colors.white30),
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                style: const TextStyle(color: Colors.white),
              ),
        actions: [
          search
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.text = '';
                      search = false;
                      fillListActivity();
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchFocusNode.requestFocus();
                      search = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text('Für je 30 Minuten', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
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
                                  focusNode: e.focusNode,
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
                                      enabled: !activityInUse(e, true),
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
                                onPressed: () => edit(e, e.focusNode),
                                color: Colors.black,
                              ),
                              IconButton(
                                  onPressed: e.activity.id!.startsWith('0') &&
                                          e.activity.id!.endsWith('0')
                                      ? null
                                      : () => delete(e),
                                  icon: const Icon(Icons.delete),
                                  color: activityInUse(e, true)
                                      ? Colors.grey
                                      : Colors.black),
                            ],
                          )
                        : IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: () => save(e, titleController2,
                                pointController2, formKey2),
                            color: Colors.black,
                          ),
                  );
                }).toList()),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha:0.5),
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

  addActivityToList() {
    if (formKey.currentState!.validate()) {
      Activity newActivity = Activity(
          id: const Uuid().v1(),
          title: titleController.text,
          points: roundPoints(doubleCommaToPoint(pointController.text)),
          icon: CommunityMaterialIcons.walk);
      AllData.activities.add(newActivity);
      DBHelper.insert('Activity', newActivity.toMap());
    }
    fillListActivity();
    setState(() {});
  }

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
      listActivity.add(
          ActivityTile(edit: false, activity: element, focusNode: FocusNode()));
    }
  }

  edit(ActivityTile e, FocusNode focusNode) {
    focusNode.requestFocus();
    focusNode.requestFocus();
    setState(() {
      listActivity
          .firstWhere((element) => element.activity.id == e.activity.id)
          .edit = true;
    });
  }

  delete(ActivityTile e) {
    bool inUse = false;
    inUse = activityInUse(e, inUse);

    if (inUse) {
      var text = Text.rich(
        TextSpan(
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: e.activity.title),
            const TextSpan(
              text: ' wird bereits verwendet. Kann nicht gelöscht werden.',
              style: TextStyle(fontWeight: FontWeight.normal),
            )
          ],
        ),
        textAlign: TextAlign.center,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          content: text));
    } else {
      AllData.activities.remove(e.activity);
      DBHelper.delete('Activity', where: 'ID = "${e.activity.id}"');
      fillListActivity();
      setState(() {});
      undoDelete(e.activity);
    }
  }

  undoDelete(Activity removed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Gelöscht'),
        action: SnackBarAction(
          label: 'Rückgängig',
          onPressed: () async {
            AllData.activities.add(removed);
            await DBHelper.insert('Activity', removed.toMap());
            fillListActivity();
            setState(() {});
          },
        )));
  }

  bool activityInUse(ActivityTile e, bool inUse) {
    for (var element in AllData.diaries) {
      for (var element in element.fitpoints!) {
        if (element.activityId == e.activity.id) {
          inUse = true;
          break;
        }
      }
    }
    return inUse;
  }

  save(ActivityTile e, TextEditingController titleController,
      TextEditingController pointController, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      Activity a = e.activity;
      a.title = titleController.text;
      a.points = roundPoints(doubleCommaToPoint(pointController.text));
      AllData.activities
          .firstWhere((element) => element.id == e.activity.id)
          .title = a.title;
      AllData.activities
          .firstWhere((element) => element.id == e.activity.id)
          .points = a.points;

      DBHelper.update('Activity', where: 'ID = "${e.activity.id}"', a.toMap());
      listActivity
          .firstWhere((element) => element.activity.id == e.activity.id)
          .activity = a;

      listActivity
          .firstWhere((element) => element.activity.id == e.activity.id)
          .edit = false;
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        titleController.text = '';
        pointController.text = '';
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
  }

  searchActivity(String query) {
    listActivity = [];

    for (var element in AllData.activities) {
      if (element.title!.contains(query)) {
        listActivity.add(ActivityTile(
            edit: false, activity: element, focusNode: FocusNode()));
      }
    }

    setState(() {});
  }
}

class ActivityTile {
  bool edit;
  Activity activity;
  FocusNode focusNode;

  ActivityTile({
    required this.edit,
    required this.activity,
    required this.focusNode,
  });
}
