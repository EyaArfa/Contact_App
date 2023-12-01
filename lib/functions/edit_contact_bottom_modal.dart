import 'dart:io';

import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:callapp/widgets/customTextField.dart';
import 'package:callapp/widgets/customTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'validator.dart';

Future<dynamic> editContactModalBottomSheet(
    BuildContext context,Contact user,
    TextEditingController txtNameController,
    TextEditingController txtLastController,
    TextEditingController txtPhoneController,
    void Function()? onclick) {
  final _formKey = GlobalKey<FormState>();

  return showModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTitle('Edit', bottom: 15, top: 10),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Stack(children: [
                            user.image == null
                                ? avatarColor
                                : ClipOval(
                              child: Image.file(
                                user.image!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              right: 20,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          focusColor: Colors.black26,
                                          onTap: () async {
                                            try {
                                              final img =
                                              await ImagePicker()
                                                  .pickImage(
                                                  source: ImageSource
                                                      .gallery);
                                              File temp=File(img!.path);
                                              if (img == null) {
                                                return;
                                              }
                                              user.image=File(img.path);
                                              Navigator.pop(context);



                                            } on PlatformException catch (e) {
                                              print(
                                                  "failed to pick image");
                                            }

                                          },
                                          child: Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    8.0),
                                                child: Icon(
                                                    FontAwesomeIcons
                                                        .images),
                                              ),
                                              Text(
                                                  "Pick from Gallery")
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            try {
                                              final img =
                                              await ImagePicker()
                                                  .pickImage(
                                                  source: ImageSource
                                                      .camera);
                                              if (img == null) {
                                                return;
                                              }
                                              user.image=File(img.path);

                                            } on PlatformException catch (e) {
                                              print(
                                                  "failed to pick image");
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    8.0),
                                                child: Icon(
                                                    FontAwesomeIcons
                                                        .camera),
                                              ),
                                              Text("Open Camera")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: const Icon(
                                    color: strokeTextColor,
                                    Icons.camera_alt_rounded),
                              ),
                            )
                          ]),
                        ),
                        CustomTextField(
                          'enter name',
                          keyboardType: TextInputType.name,
                          controller: txtNameController,
                          icon: const Icon(FontAwesomeIcons.user),
                          validator: (value) => validator(value),
                        ),
                        CustomTextField(
                          'enter last name',
                          controller: txtLastController,
                          keyboardType: TextInputType.name,
                          icon: const Icon(FontAwesomeIcons.user),
                          validator: (value) => validator(value),
                        ),
                        CustomTextField(
                          'enter number',
                          keyboardType: TextInputType.phone,
                          controller: txtPhoneController,
                          icon: const Icon(FontAwesomeIcons.phone),
                          validator: (value) => validator(value),
                        ),
                        CustomButton(
                          onCLick: onclick,
                          text: 'Edit',
                        )
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ));
}
