// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donnors_choice/firebase/auth_methods.dart';
import 'package:donnors_choice/pages/donate_organs.dart';
import 'package:donnors_choice/pages/forget_password.dart';
import 'package:donnors_choice/pages/login_page.dart';
import 'package:donnors_choice/pages/ngo_list.dart';
import 'package:donnors_choice/pages/organs_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final spinkit = SpinKitDualRing(
    color: Colors.red,
    size: 50.0,
  );
  final currentUser = FirebaseAuth.instance;

  void logout() async {
    await Auth().SignOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    OrganList(),
    Donation(),
    NGOList(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: const Center(child: Text('Donnors Choice')),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('Email', isEqualTo: currentUser.currentUser?.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data?.docs[0]['Name']),
                  accountEmail: Text(snapshot.data?.docs[0]['Email']),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data?.docs[0]['Photo']),
                  ),
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    logout();
                  },
                ),
                ListTile(
                    title: const Text('Change Password'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    }),
              ],
            );
          } else {
            return spinkit;
          }
        },
      )),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heartCircleBolt),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseMedical),
            label: 'NGO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[400],
        onTap: _onItemTapped,
      ),
    );
  }
}
