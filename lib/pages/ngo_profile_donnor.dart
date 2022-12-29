import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NGOProfilePage extends StatefulWidget {
  String name;
  String email;
  String phone;
  String location;
  String logo;
  NGOProfilePage(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.location,
      required this.logo});

  @override
  State<NGOProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<NGOProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('NGO Profile')),
          backgroundColor: Colors.red[900],
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red[900]!,
                      Colors.red,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.5, 0.9],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      minRadius: 80.0,
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(widget.logo),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.location,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.phone,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
