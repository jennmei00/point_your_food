import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/diary/add_food_sheet.dart';

class EditFood extends StatefulWidget {
  const EditFood({super.key});
  static const routeName = '/editFood';

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  List<FoodTile> listFood = [];
  bool search = false;
  TextEditingController searchController = TextEditingController(text: '');
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    fillListFood();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !search
            ? const Text('Essen bearbeiten')
            : TextField(
                onChanged: (query) => searchFood(query),
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
                      fillListFood();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => addCard(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: listFood.map((e) {
                GlobalKey<FormState> formKey = GlobalKey<FormState>();
                TextEditingController titleController =
                    TextEditingController(text: e.food.title);
                TextEditingController pointController =
                    TextEditingController(text: decimalFormat(e.food.points!));
                // FocusNode focusNode = FocusNode();

                return ListTile(
                  title: !e.edit
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(e.food.title!),
                              Text('${decimalFormat(e.food.points!)} P.')
                            ])
                      : Form(
                          key: formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: TextFormField(
                                focusNode: e.focusNode,
                                controller: titleController,
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
                                    enabled:  !foodInUse(e, true),
                                    controller: pointController,
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
                                color: Colors.black),
                            IconButton(
                                onPressed: () => delete(e),
                                icon: const Icon(Icons.delete),
                                color: foodInUse(e, true)
                                    ? Colors.grey
                                    : Colors.black),
                          ],
                        )
                      : IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () => save(
                              e, titleController, pointController, formKey),
                          color: Colors.black),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  edit(FoodTile e, FocusNode focusNode) {
    focusNode.requestFocus();
    focusNode.requestFocus();
    setState(() {
      listFood.firstWhere((element) => element.food.id == e.food.id).edit =
          true;
    });
  }

  delete(FoodTile e) {
    bool inUse = false;
    inUse = foodInUse(e, inUse);

    if (inUse) {
      var text = Text.rich(
        TextSpan(
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: e.food.title),
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
      AllData.foods.remove(e.food);
      DBHelper.delete('Food', where: 'ID = "${e.food.id}"');
      fillListFood();
      setState(() {});
      undoDelete(e.food);
    }
  }

  undoDelete(Food removed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Gelöscht'),
        action: SnackBarAction(
          label: 'Rückgängig',
          onPressed: () async {
            AllData.foods.add(removed);
            await DBHelper.insert('Food', removed.toMap());
            fillListFood();
            setState(() {});
          },
        )));
  }

  bool foodInUse(FoodTile e, bool inUse) {
    for (var element in AllData.diaries) {
      for (var element in element.breakfast!) {
        if (element.id == e.food.id) {
          inUse = true;
          break;
        }
      }
      for (var element in element.lunch!) {
        if (element.id == e.food.id) {
          inUse = true;
          break;
        }
      }
      for (var element in element.dinner!) {
        if (element.id == e.food.id) {
          inUse = true;
          break;
        }
      }
      for (var element in element.snack!) {
        if (element.id == e.food.id) {
          inUse = true;
          break;
        }
      }
    }
    return inUse;
  }

  save(FoodTile e, TextEditingController titleController,
      TextEditingController pointController, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      Food f = e.food;
      f.title = titleController.text;
      f.points = roundPoints(doubleCommaToPoint(pointController.text));
      AllData.foods.firstWhere((element) => element.id == e.food.id).title =
          f.title;
      AllData.foods.firstWhere((element) => element.id == e.food.id).points =
          f.points;

      DBHelper.update('Food', where: 'ID = "${e.food.id}"', f.toMap());

      listFood.firstWhere((element) => element.food.id == e.food.id).food = f;
      listFood.firstWhere((element) => element.food.id == e.food.id).edit =
          false;
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {});
    }
  }

  void fillListFood() {
    listFood = [];
    AllData.foods.sort((a, b) {
      int title = a.title!.compareTo(b.title!);
      if (title != 0) {
        return title;
      } else {
        return a.points!.compareTo(b.points!);
      }
    });
    for (var element in AllData.foods) {
      listFood
          .add(FoodTile(edit: false, food: element, focusNode: FocusNode()));
    }
  }

  addCard() {
    search = false;
    searchController.text = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodSheet(
          type: PointType.food,
          diaryId: '',
          onPressed: () async {
            Navigator.of(context).pop();
            fillListFood();
            setState(() {});
          }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }

  searchFood(String query) {
    listFood = [];

    for (var element in AllData.foods) {
      if (element.title!.contains(query)) {
        listFood
            .add(FoodTile(edit: false, food: element, focusNode: FocusNode()));
      }
    }

    setState(() {});
  }
}

class FoodTile {
  bool edit;
  Food food;
  FocusNode focusNode;

  FoodTile({
    required this.edit,
    required this.food,
    required this.focusNode,
  });
}
