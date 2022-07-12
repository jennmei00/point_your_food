import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/food.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.food,
    required this.activity,
    required this.isFood,
  }) : super(key: key);

  final Function onPressed;
  final String title;
  final IconData icon;
  final List<Food> food;
  final List<Activity> activity;
  final bool isFood;

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: 135,
    //   child: Card(
    //     elevation: 5,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(15),
    //           bottomLeft: Radius.circular(15),
    //           bottomRight: Radius.circular(15),
    //           topRight: Radius.circular(75)),
    //     ),
    //     color: Colors.blue,
    //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //       Icon(
    //         icon,
    //         size: 50,
    //         color: Colors.white,
    //         // color: Theme.of(context).primaryColor,
    //       ),
    //       Text(title),
    //       // Text()
    //     ]),
    //   ),
    // );

    // Container(
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(15),
    //                       bottomLeft: Radius.circular(15),
    //                       bottomRight: Radius.circular(15),
    //                       topRight: Radius.circular(75)),
    //                   color: Colors.blue,
    //                 ),
    //                 width: 150,
    //               ),
    //               // height: 70,
    //               // width: 150,

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 50,
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isFood
                        ? food.map((e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${e.title}'),
                                Text('${e.points}'),
                              ],
                            );
                          }).toList()
                        : activity.map((e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${e.title}'),
                                Text('${e.points}'),
                              ],
                            );
                          }).toList(),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          '${totalPoints()} Punkte',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      OutlinedButton(
                          onPressed: () => onPressed(),
                          child: Row(
                            children: const [
                              Icon(Icons.edit),
                              Text('Bearbeiten'),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      // color: Theme.of(context).primaryColor,
      // child: ListTile(
      //   contentPadding: EdgeInsets.all(10),
      //   title: Text('Frühstück'),
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: diary.breakfast.map((e) {
      //       print(e.description);
      //       return Text('${e.description} ${e.points}');
      //     }).toList(),
      //     //  [
      //     //   SizedBox(height: 10),
      //     //   Text('1'),
      //     //   Text('2'),
      //     //   Text('3'),
      //     // ]
      //   ),
      //   trailing: Icon(
      //     Icons.free_breakfast_rounded,
      //     size: 50,
      //     // color: Colors.white,
      //     color:Theme.of(context).primaryColor,
      //   ),
      //   // textColor: Colors.white,
      // ),
    );
  }

  double totalPoints() {
    double points = 0;

    for (var element in food) {
      points += element.points!;
    }

    return points;
  }
}
