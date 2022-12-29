import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  Map<String, String> organs = {
    'Kidney': 'Kidney',
    'Liver': 'Liver',
    'Heart': 'Heart',
    'Lungs': 'Lungs',
    'Pancreas': 'Pancreas',
    'Bone Marrow': 'Bone Marrow',
    'Corneas': 'Corneas',
    'Small Intestine': 'Small Intestine',
    'Platlets': 'Platlets',
  };
  List<String> organList = [
    'Kidney',
    'Liver',
    'Heart',
    'Lungs',
    'Pancreas',
    'Bone Marrow',
    'Corneas',
    'Small Intestine',
    'Platlets',
  ];
  late String selectedOrgan = organList[0];
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> addOrgan() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'organs': FieldValue.arrayUnion([organs[selectedOrgan]!])
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Organ added successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error, please try again later'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 100,
          color: Colors.redAccent,
          child: const Center(
            child: Text(
              'Select the organ you want to donate',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButton(
          value: selectedOrgan,
          items: organList.map((String organ) {
            return DropdownMenuItem(
              value: organ,
              child: Text(organ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedOrgan = value!;
            });
          },
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: const Offset(1, 1),
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
          child: TextButton(
              onPressed: () {
                addOrgan();
              },
              child: const Text(
                'Donate',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        )
      ],
    ));
  }
}
