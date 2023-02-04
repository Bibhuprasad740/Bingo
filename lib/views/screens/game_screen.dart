import 'package:bingo/globals.dart';
import 'package:bingo/views/screens/profile_screen.dart';
import 'package:bingo/views/widgets/bingo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final int playerNumber, totalNoOfPlayers;
  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerNumber,
    required this.totalNoOfPlayers,
  });

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  late AnimationController _controller;
  Color buttonColor = Colors.yellow;
  Color cardColor1 = Globals.lightRed;
  Color cardColor2 = Globals.lightRed;
  Color cardColor3 = Globals.lightRed;
  Color cardColor4 = Globals.lightRed;
  Color cardColor5 = Globals.lightRed;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<int> _numbers = [];
  List<int> _selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    _generateNumbers();
    _createRoom();
  }

  void _createRoom() {
    _firestore.collection('rooms').doc(widget.roomId).set({});
    _firestore.collection('rooms').doc(widget.roomId).get().then((snapshot) {
      if (snapshot.exists) {
        _firestore
            .collection('rooms')
            .doc(widget.roomId)
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
            _firestore.collection('rooms').doc(widget.roomId).set({});
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
      _firestore.collection('rooms').doc(widget.roomId).update({
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Room id: ${widget.roomId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Player No: ${widget.playerNumber}/${widget.totalNoOfPlayers}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                              _isSelected(index) ? buttonColor : Colors.white,
                          child: InkWell(
                            onTap: () => _selectedNumbers.length %
                                            widget.totalNoOfPlayers +
                                        1 ==
                                    widget.playerNumber
                                ? _selectNumber(index)
                                : null,
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
                const SizedBox(height: 10),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  children: [
                    BingoItem(
                      cardColor: cardColor1,
                      text: 'B',
                      onTap: () {
                        setState(() {
                          cardColor1 = Globals.accent1;
                        });
                      },
                    ),
                    BingoItem(
                      cardColor: cardColor2,
                      text: 'I',
                      onTap: () {
                        setState(() {
                          cardColor2 = Globals.accent1;
                        });
                      },
                    ),
                    BingoItem(
                      cardColor: cardColor3,
                      text: 'N',
                      onTap: () {
                        setState(() {
                          cardColor3 = Globals.accent1;
                        });
                      },
                    ),
                    BingoItem(
                      cardColor: cardColor4,
                      text: 'G',
                      onTap: () {
                        setState(() {
                          cardColor4 = Globals.accent1;
                        });
                      },
                    ),
                    BingoItem(
                      cardColor: cardColor5,
                      text: 'O',
                      onTap: () {
                        setState(() {
                          cardColor5 = Globals.accent1;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _selectedNumbers.length % widget.totalNoOfPlayers + 1 ==
                          widget.playerNumber
                      ? 'Its your turn!!'
                      : 'Opponent\'s turn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        _selectedNumbers.length % widget.totalNoOfPlayers + 1 ==
                                widget.playerNumber
                            ? Globals.accent1
                            : Globals.accent2,
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    _generateNumbers();
                    _createRoom();
                    setState(() {
                      cardColor1 = Globals.lightRed;
                      cardColor2 = Globals.lightRed;
                      cardColor3 = Globals.lightRed;
                      cardColor4 = Globals.lightRed;
                      cardColor5 = Globals.lightRed;
                    });
                  },
                  child: const Text('Restart The game!'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
