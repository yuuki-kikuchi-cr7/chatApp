import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepository = Provider(
  (ref) => CommonFirebaseStorageRepository(
    storage: FirebaseStorage.instance
    )
  );

class CommonFirebaseStorageRepository{
  final FirebaseStorage storage;
  CommonFirebaseStorageRepository({
   required this.storage
  });

Future<String> uploadFile({required String ref, required File file})async{
  Reference profilePic = storage.ref().child(ref);
  UploadTask uploadTask = profilePic.putFile(file);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl =  await snap.ref.getDownloadURL();
  return downloadUrl;
}

}