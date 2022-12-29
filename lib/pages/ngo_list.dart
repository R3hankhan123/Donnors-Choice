import 'package:donnors_choice/pages/ngo_profile_donnor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NGOList extends StatefulWidget {
  const NGOList({super.key});

  @override
  State<NGOList> createState() => _NGOListState();
}

class _NGOListState extends State<NGOList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('NGOs').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final ngoList = snapshot.data!.docs;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ngoList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NGOProfilePage(
                                name: ngoList[index]['Name'],
                                email: ngoList[index]['Email'],
                                phone: ngoList[index]['Phone'],
                                location: ngoList[index]['Location'],
                                logo: ngoList[index]['Logo'],
                              )));
                },
                child: Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(ngoList[index]['Logo']),
                      radius: 60,
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          ngoList[index]['Name'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(ngoList[index]['Email'],
                            style: const TextStyle(fontSize: 18)),
                      ],
                    )
                  ],
                )),
              );
            },
          );
        } else {
          return const SpinKitDualRing(
            color: Colors.red,
            size: 50.0,
          );
        }
      },
    ));
  }
}
