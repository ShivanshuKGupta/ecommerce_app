import 'package:ecommerce_app/models/firestore/firestore_document.dart';
import 'package:ecommerce_app/models/globals.dart';

class FirestoreCollection {
  static const String users = 'users/';
  static const String products = 'products/';
  static const String cart = 'cart/';

  String? path;
  String id = "";
  List<FirestoreDocument> documents = [];

  // this fetches the collection from firestore
  Future<void> get() async {
    assert(path != null);
    assert(path!.isNotEmpty);
    assert(id.isNotEmpty);
    path = path!.replaceAll(' ', '');
    if (!path!.endsWith('/')) {
      path = '$path/';
    }
    final value = await firestore.collection(path!).get();
    documents = value.docs
        .map((e) =>
            FirestoreDocument(id: e.id, data: e.data(), path: path! + id))
        .toList();
  }
}
