import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.lightbulb),
          title: const Text('Darkmode'),
          onChanged: (val) {},
          value: true,
        ),
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
      ],
    );
  }
}
