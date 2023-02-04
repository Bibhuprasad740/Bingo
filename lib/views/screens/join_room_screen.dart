import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals.dart';
import 'game_screen.dart';

class JoinRoomScreen extends StatefulWidget {
  JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _playerNoController = TextEditingController();
  final TextEditingController _noOfPlayersController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _roomIdController.dispose();
    _playerNoController.dispose();
    _noOfPlayersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _roomIdController,
              decoration: const InputDecoration(labelText: 'Room ID'),
              onChanged: (value) => Globals.authController.email.value = value,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter a valid room id';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _noOfPlayersController,
              decoration: const InputDecoration(labelText: 'Number of players'),
              onChanged: (value) => Globals.authController.email.value = value,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter no of players to play';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _playerNoController,
              decoration: const InputDecoration(labelText: 'Your No.'),
              onChanged: (value) => Globals.authController.email.value = value,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter your no.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_roomIdController.text != '' &&
                    _playerNoController.text != '') {
                  Get.to(
                    () => GameScreen(
                      totalNoOfPlayers:
                          int.parse(_noOfPlayersController.text.trim()),
                      playerNumber: int.parse(_playerNoController.text.trim()),
                      roomId: _roomIdController.text.trim(),
                    ),
                  );
                } else {
                  Get.snackbar('Error', 'Please fill all the details.');
                }
              },
              child: const Text('Join!'),
            )
          ],
        ),
      ),
    );
  }
}
