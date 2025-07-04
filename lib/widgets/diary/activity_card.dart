import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class ActivityCard extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey;
  final Color color;
  final IconData icon;
  final String title;
  final double points;
  final bool addField;
  final Function? onAddPressed;
  final Function? onRemovePressed;

  const ActivityCard({
    super.key,
    required this.cardKey,
    required this.color,
    required this.icon,
    required this.title,
    required this.points,
    required this.addField,
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: !addField
          ? FlipCard(
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
                        Text(title),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${decimalFormat(points)} P.',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        )
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
                        ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: onRemovePressed == null
                                    ? null
                                    : () => onRemovePressed!(),
                                icon: const Icon(Icons.remove),
                                iconSize: 50,
                              )),
                        ),
                      ],
                    ),
                  )),
            )
          : Card(
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
                    Text(title),
                    Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: onAddPressed == null
                              ? null
                              : () => onAddPressed!(),
                          icon: const Icon(Icons.add),
                          iconSize: 50,
                        )),
                  ],
                ),
              )),
    );
  }
}
