import 'package:image_picker/image_picker.dart';

abstract class FirebaseStorageModule {
  Future<String> uploadImageToUser(String user, XFile image);
}
