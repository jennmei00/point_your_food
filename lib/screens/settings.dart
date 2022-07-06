import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          secondary: Icon(Icons.lightbulb),
          title: const Text('Darkmode'),
          onChanged: (val) {},
          value: true,
        ),
        GestureDetector(
          child: ListTile(
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
            child: ListTile(
              leading: Icon(
                Icons.description,
              ),
              title: Text('Lizensen'),
            ),
            onTap: () => showLicensePage(
                  context: context,
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
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
