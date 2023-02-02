import 'package:bingo/controllers/auth_controller.dart';
import 'package:bingo/controllers/firestore_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
    Get.lazyPut<FirestoreController>(
      () => FirestoreController(),
      fenix: true,
    );
  }
}
