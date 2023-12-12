import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/user/profile_details_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ProfileDetailsScreen(
      user: currentUser,
      onEdit: () async {
        await navigatorPush(context, EditProfile(user: currentUser));
        setState(() {});
      },
    );
  }
}
