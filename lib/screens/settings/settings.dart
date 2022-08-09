import 'package:flutter/material.dart';
import 'package:punkte_zaehler/screens/settings/edit_activity.dart';
import 'package:punkte_zaehler/screens/settings/edit_food.dart';
import 'package:punkte_zaehler/screens/settings/profile.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text(
              'Profil',
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(Profile.routeName);
          },
        ),
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(
              'Essen bearbeiten',
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(EditFood.routeName);
          },
        ),
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.local_activity),
            title: Text(
              'Aktivitäten bearbeiten',
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(EditActivity.routeName);
          },
        ),
        GestureDetector(
          child: ExpansionTile(
            leading: const Icon(Icons.safety_check),
            title: const Text(
              'Punktetresor',
            ),
            subtitle: const Text('Löschen bei Eingabe von Wiegedaten'),
            // trailing: DropdownButton<Text>(
            //   items: const [
            //     DropdownMenuItem(child: Text('Eingabe von Wiegedaten'))
            //   ],
            //   onChanged: (Object? value) {},
            // ),
            children: [
              RadioListTile<int>(
                groupValue: 0,
                onChanged: (Object? value) {},
                value: 0,
                title: const Text('Eingabe von Wiegedaten'),
              ),
              RadioListTile<int>(
                groupValue: 0,
                onChanged: (Object? value) {},
                value: 1,
                title: const Text('Jeden Montag'),
              ),
              RadioListTile<int>(
                groupValue: 0,
                onChanged: (Object? value) {},
                value: 1,
                title: const Text('Jeden Sonntag'),
              ),
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(Credits.routeName);
          },
        ),
        GestureDetector(
          child: ListTile(
            leading: const Icon(Icons.calendar_view_day),
            title: const Text(
              'Tagespunkte',
            ),
            subtitle: const Text('Automatisch Gewicht anpassen?'),
            trailing: Checkbox(value: true, onChanged: (val) {}),
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(Credits.routeName);
          },
        ),
        // SwitchListTile(
        //   secondary: const Icon(Icons.lightbulb),
        //   title: const Text('Darkmode'),
        //   onChanged: (val) {},
        //   value: true,
        // ),
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.my_library_books),
            title: Text(
              'Credits',
            ),
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(Credits.routeName);
          },
        ),
        GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.description,
              ),
              title: Text('Lizensen'),
            ),
            onTap: () => showLicensePage(
                  context: context,
                  applicationIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    // child: Image.asset(
                    //   // 'assets/images/logo2.png',
                    //   width: 48,
                    // ),
                  ),
                  applicationName: 'PointYourFood',
                  // applicationVersion: '${Globals.version}'
                  //  '1.0.0',
                  // applicationLegalese: 'Copyright My Company'
                )),

        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text(
              'Daten löschen',
            ),
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(Credits.routeName);
          },
        ),

        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Abmelden',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(Credits.routeName);
          },
        ),
      ],
    );
  }
}
