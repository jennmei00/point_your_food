import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDiary extends StatelessWidget {
  const FoodDiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime(2020, 4, 20),
          firstDate: DateTime(2019, 1, 15),
          lastDate: DateTime(2020, 11, 20),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          // monthColor: Colors.,
          dayColor: const Color.fromARGB(255, 207, 107, 100),
          activeDayColor: const Color.fromARGB(255, 238, 178, 178),
          activeBackgroundDayColor: const Color.fromARGB(255, 107, 16, 7),
          dotsColor: const Color.fromARGB(255, 58, 66, 82),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'de',
        ),
        Expanded(
            child: ListView(
          children: [
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text('Frühstück'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ]),
                trailing: Icon(
                  Icons.free_breakfast_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                textColor: Colors.white,
              ),
            ),
            Card(elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text('Mittag'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ]),
                trailing: Icon(
                  Icons.dinner_dining,
                  size: 50,
                  color: Colors.white,
                ),
                textColor: Colors.white,
              ),
            ),
            Card(elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text('Abend'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ]),
                trailing: Icon(
                  Icons.dining_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                textColor: Colors.white,
              ),
            ),
            Card(elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text('Snacks'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ]),
                trailing: Icon(
                  Icons.cake,
                  size: 50,
                  color: Colors.white,
                ),
                textColor: Colors.white,
              ),
            ),
            // Card(
            // ),
            // Card(
            // ),
          ],
        )),
        SizedBox(height: 15)
      ],
    );
  }
}
