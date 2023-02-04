import 'package:bingo/views/screens/create_room_screen.dart';
import 'package:bingo/views/screens/join_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => CreateRoomScreen()),
              child: const Text('Create Room'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => JoinRoomScreen()),
              child: const Text('Join Room'),
            )
          ],
        ),
      ),
    );
  }
}
