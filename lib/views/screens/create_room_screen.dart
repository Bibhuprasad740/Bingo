import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals.dart';
import 'game_screen.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
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
        title: const Text('Create Room'),
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
              decoration:
                  const InputDecoration(labelText: 'Total no of players'),
              onChanged: (value) => Globals.authController.email.value = value,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter total players count';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _playerNoController,
              decoration: const InputDecoration(labelText: 'Your NO.'),
              onChanged: (value) => Globals.authController.email.value = value,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter player no';
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
              child: const Text('Create!'),
            )
          ],
        ),
      ),
    );
  }
}
