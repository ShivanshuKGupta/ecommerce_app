import 'dart:io';

import 'package:ecommerce_app/models/user/user.dart';
import 'package:ecommerce_app/providers/image.dart';
import 'package:ecommerce_app/utils/profile_image.dart';
import 'package:ecommerce_app/utils/section.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'loading_elevated_button.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, UserData? user}) {
    this.user = user ?? UserData();
  }

  late UserData user;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  File? img;

  Future<void> save(context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    widget.user.imgUrl = img != null
        ? await uploadImage(
            context, img, widget.user.email, "profile-image.jpg")
        : widget.user.imgUrl;
    widget.user.name = widget.user.name == null
        ? null
        : widget.user.name!.trim().toPascalCase();
    await widget.user.update();
    Navigator.of(context).pop(true); // to show that a change was done
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Hero(
                  tag: 'profile-image',
                  child: ProfileImage(
                    url: widget.user.imgUrl,
                    onChanged: (value) {
                      img = value;
                    },
                  ),
                ),
                Text(
                  widget.user.email ?? "",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const Divider(),
                Section(title: 'Personal Information', children: [
                  TextFormField(
                    maxLength: 50,
                    enabled: false,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                    ),
                    initialValue: widget.user.name,
                    validator: (name) {
                      return Validate.name(name);
                    },
                    onSaved: (value) {
                      widget.user.name = value!.trim();
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      label: Text("Phone Number"),
                    ),
                    initialValue: widget.user.phoneNumber,
                    validator: (name) {
                      return Validate.phone(name, required: false);
                    },
                    onSaved: (value) {
                      widget.user.phoneNumber = value!.trim();
                    },
                  ),
                  TextFormField(
                    maxLength: 200,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      label: Text("Address"),
                    ),
                    initialValue: widget.user.address,
                    validator: (name) {
                      return Validate.text(name, required: false);
                    },
                    onSaved: (value) {
                      widget.user.address = value!.trim();
                    },
                    //   ),
                    //   if (false)
                    //     DropdownButtonFormField(
                    //         decoration: const InputDecoration(label: Text('Type')),
                    //         value: widget.user.type,
                    //         items:
                    //             ['attender', 'warden', 'student', 'other', "club"]
                    //                 .map(
                    //                   (e) => DropdownMenuItem(
                    //                     value: e,
                    //                     child: Text(e),
                    //                   ),
                    //                 )
                    //                 .toList(),
                    //         onChanged: (value) {
                    //           widget.user.type = value ?? "student";
                    //         }),
                    //   if (widget.user.email != currentUser.email &&
                    //       false)
                    //     DropdownButtonFormField(
                    //         decoration: const InputDecoration(label: Text('Admin')),
                    //         value: widget.user.isAdmin,
                    //         items: [true, false]
                    //             .map(
                    //               (e) => DropdownMenuItem(
                    //                 value: e,
                    //                 child: Text(e.toString()),
                    //               ),
                    //             )
                    //             .toList(),
                    //         onChanged: (value) {
                    //           widget.user.isAdmin = value ?? false;
                    //         }
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LoadingElevatedButton(
                      onPressed: () async {
                        await save(context);
                      },
                      icon: Icon(
                        widget.user.email == null
                            ? Icons.person_add_rounded
                            : Icons.save_rounded,
                      ),
                      label: Text(widget.user.email == null ? 'Add' : 'Save'),
                    ),
                    TextButton.icon(
                      onPressed: () => _formKey.currentState!.reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
