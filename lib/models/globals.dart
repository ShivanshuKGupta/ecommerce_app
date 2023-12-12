import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user/user.dart';
import 'package:ecommerce_app/providers/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Instead of creating multiple instances of the same object
/// I created then altogether here
final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
final settings = SharedPreferenceInstance();

final UserData currentUser = UserData();
