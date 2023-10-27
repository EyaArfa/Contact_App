import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:callapp/widgets/customTextField.dart';
import 'package:callapp/widgets/customTitle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'validator.dart';

Future<dynamic> editContactModalBottomSheet(
    BuildContext context,
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
                            avatarColor,
                            Positioned(
                              bottom: 15,
                              right: 20,
                              child: InkWell(
                                onTap: () {},
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
