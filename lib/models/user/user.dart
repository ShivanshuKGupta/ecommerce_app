import 'package:ecommerce_app/models/firestore/firestore_collection.dart';
import 'package:ecommerce_app/models/firestore/firestore_document.dart';

class UserData extends FirestoreDocument {
  // The email and firestore id are the same for any user
  String get email {
    return super.id;
  }

  String? name;
  String? phoneNumber;
  String? address;
  String? imgUrl;
  String? role;

  UserData({
    super.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.imgUrl,
    this.role,
  }) : super(path: FirestoreCollection.users);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['email'] ?? json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      imgUrl: json['imgUrl'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name;
    json['phoneNumber'] = phoneNumber;
    json['address'] = address;
    json['imgUrl'] = imgUrl;
    json['role'] = role;
    return json;
  }

  @override
  Future<void> fetch() async {
    super.path = FirestoreCollection.users;
    return super.fetch();
  }

  @override
  Future<void> update() async {
    super.path = FirestoreCollection.users;
    return super.update();
  }
}
