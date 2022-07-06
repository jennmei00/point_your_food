import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Theme.of(context).primaryColor,
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
                  'Jenny',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'jennmei00@yahoo.de',
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
                trailing: const Text('22'),
              ),
            ),
            Card(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              child: ListTile(
                textColor: Colors.white,
                title: Row(
                  children: const [
                    FaIcon(Icons.start, color: Colors.white),
                    Text('  Startgewicht'),
                  ],
                ),
                trailing: const Text('70'),
              ),
            ),
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
                trailing: const Text('60'),
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
                trailing: const Text('60'),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
