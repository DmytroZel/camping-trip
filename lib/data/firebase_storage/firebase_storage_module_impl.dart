import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'firebase_storage_module.dart';

@Injectable(as: FirebaseStorageModule)
class FirebaseStorageModuleImpl implements FirebaseStorageModule {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageModuleImpl({required this.firebaseStorage});

  @override
  Future<String> uploadImageToUser(String user, XFile image) async {
    const fileType = 'jpeg';
    final userImageRef = firebaseStorage.ref().child("images/$user.$fileType");
    final metadata = SettableMetadata(
      contentType: 'image/$fileType',
      customMetadata: {'picked-file-path': image.path},
    );
    await userImageRef.putData(await image.readAsBytes(), metadata);
    return getUserImageDownloadRef(userImageRef.fullPath);
  }

  Future<String> getUserImageDownloadRef(String image) {
    final userImageRef = firebaseStorage.ref().child(image);
    return userImageRef.getDownloadURL();
  }
}
