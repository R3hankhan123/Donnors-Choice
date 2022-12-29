import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrganList extends StatefulWidget {
  const OrganList({super.key});

  @override
  State<OrganList> createState() => _OrganListState();
}

class _OrganListState extends State<OrganList> {
  final curr = FirebaseAuth.instance;
  Map<String, String> organImages = {
    'Kidney': 'image/kidney.png',
    'Liver': 'image/liver.jpg',
    'Heart': 'image/heart.png',
    'Lungs': 'image/lungs.jpg',
    'Pancreas': 'image/pancreas.jpg',
    'Bone Marrow': 'image/bone_marrow.jpg',
    'Corneas': 'image/cornea.png',
    'Small Intestine': 'image/small_intestine.png',
    'Platlets': 'image/platelets.jpg',
  };
  final spinkit = const SpinKitDualRing(
    color: Colors.red,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: Colors.redAccent,
            child: const Center(
              child: Text(
                'Organs You have Donate',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('Email', isEqualTo: curr.currentUser?.email)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final organList = snapshot.data!.docs[0]['organs'];

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: organList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(organImages[organList[index]]!),
                          ),
                          Text(
                            organList[index],
                            style: const TextStyle(fontSize: 22),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(curr.currentUser!.uid)
                                  .update({
                                'organs':
                                    FieldValue.arrayRemove([organList[index]])
                              });
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              return spinkit;
            },
          )
        ],
      ),
    ));
  }
}
