import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const Icon(
            Icons.account_circle,
            size: 100,
          ),
          const SizedBox(height: 30),
          ListTile(
            title: const Text('Name'),
            trailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  const Expanded(child: TextField()),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
           ListTile(
            title: const Text('Email'),
            trailing:SizedBox(
              width: 200,
              child: Row(
                children: [
                  const Expanded(child: TextField()),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
              onTap: () {},
              child: const Text(
                '    Passwort ändern',
                style: TextStyle(fontSize: 16),
              )),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Abmelden',
                      style: TextStyle(
                          color: Color.fromARGB(255, 182, 28, 28),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Konto löschen',
                        style: TextStyle(
                            color: Color.fromARGB(255, 182, 28, 28),
                            fontStyle: FontStyle.italic),
                      )),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
