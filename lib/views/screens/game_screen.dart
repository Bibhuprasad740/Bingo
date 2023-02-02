import 'package:bingo/globals.dart';
import 'package:bingo/views/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _roomId = "room1";
  List<int> _numbers = [];
  List<int> _selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    _generateNumbers();
    _firestore.collection('rooms').doc(_roomId).set({});
    _firestore.collection('rooms').doc(_roomId).get().then((snapshot) {
      if (snapshot.exists) {
        _firestore
            .collection('rooms')
            .doc(_roomId)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            List<int> selectedNumbers = [];
            snapshot.data()!.forEach((key, value) {
              selectedNumbers.add(value);
            });
            setState(() {
              _selectedNumbers = selectedNumbers;
            });
          } else {
            _firestore.collection('rooms').doc(_roomId).set({});
          }
        });
      }
    });
  }

  void _generateNumbers() {
    _numbers = List.generate(25, (index) => index + 1);
    _numbers.shuffle();
  }

  void _selectNumber(int index) {
    setState(() {
      _selectedNumbers.add(_numbers[index]);
      _selectedNumbers.sort();
      _firestore.collection('rooms').doc(_roomId).update({
        '${_selectedNumbers.length}': _numbers[index],
      });
    });
  }

  bool _isSelected(int index) {
    return _selectedNumbers.contains(_numbers[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Globals.accent1.withOpacity(0.99),
                    child: IconButton(
                      onPressed: () => Get.to(() => const ProfileScreen()),
                      icon: const Icon(
                        Icons.person,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  // margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Globals.accent1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemCount: _numbers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color:
                            _isSelected(index) ? Colors.yellow : Colors.white,
                        child: InkWell(
                          onTap: () => _selectNumber(index),
                          child: Center(
                            child: Text(
                              '${_numbers[index]}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
