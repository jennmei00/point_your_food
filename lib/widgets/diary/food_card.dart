import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class FoodCard extends StatelessWidget {
  final Diary diary;
  final PointType type;
  final String title;
  final IconData icon;
  final List<Food> food;
  final Color color;
  final Function? onAddPressed;
  final GlobalKey<FlipCardState> cardKey;

  const FoodCard(
      {Key? key,
      required this.diary,
      required this.type,
      required this.title,
      required this.icon,
      required this.food,
      required this.color,
      required this.onAddPressed,
      required this.cardKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double points = calcPoints();

    return SizedBox(
      width: 135,
      child: FlipCard(
        key: cardKey,
        front: Card(
            color: color,
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(75))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 50,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: food.map((e) => Text(e.title!)).toList())),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${decimalFormat(points)} P.',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),
            )),
        back: Card(
            color: color,
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(75),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    icon,
                    size: 50,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: onAddPressed == null
                              ? null
                              : () => onAddPressed!(),
                          icon: const Icon(Icons.add),
                          iconSize: 50,
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  double calcPoints() {
    double points = 0;
    // if (type == PointType.activity) {
    //   for (var element in activity) {
    //     points += element.points!;
    //   }
    // } else {
    for (var element in food) {
      points += element.points!;
    }
    // }
    return points;
  }
}
