import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/customTextField.dart';
import '../widgets/customTitle.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

_makingPhoneCall(phoneNumber) async {
  var url = Uri.parse("tel:" + phoneNumber.toString());
  print("-----------------------------" + phoneNumber.toString());

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _HomeState extends State<Home> {
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please fill the missing informations';
    }
    return null;
  }

  static List<Contact> contacts = [];
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController txtNameController = TextEditingController(),
        txtLastController = TextEditingController(),
        txtPhoneController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: strokeTextColor,
        onPressed: () {
          showModalBottomSheet(
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
                        CustomTitle('New Contact', bottom: 15, top: 10),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Stack(children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 60,
                                  ),
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
                                onCLick: () {
                                  if (_formKey.currentState!.validate()) {
                                    Contact newContact = new Contact(
                                        name: txtNameController.text,
                                        phone: txtPhoneController.text,
                                        lastName: txtLastController.text);
                                    setState(() {
                                      contacts.add(newContact);
                                      print(contacts);
                                    });
                                  }
                                },
                                text: 'Add',
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  ));
        },
        child: const Icon(Icons.person_add_alt_sharp),
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTitle('Contacts', bottom: 20, top: 10),
          Flexible(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: deviderColor,
                endIndent: 30,
                indent: 30,
              ),
              itemCount: contacts.length,
              itemBuilder: (context, index) => Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.amber[100], radius: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(contacts[index].name),
                          Text(contacts[index].phone)
                        ],
                      ),
                    ),
                    Positioned(
                        right: 5,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _makingPhoneCall(contacts[index].phone);
                              },
                              radius: 30,
                              child: const Icon(
                                Icons.phone,
                                color: strokeTextColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  txtLastController.text =
                                      contacts[index].lastName;
                                  txtNameController.text = contacts[index].name;
                                  txtPhoneController.text =
                                      contacts[index].phone;
                                  showModalBottomSheet(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTitle('Edit',
                                                    bottom: 15, top: 10),
                                                Form(
                                                  key: _formKey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 20),
                                                    child: Column(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: Stack(children: [
                                                          const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.amber,
                                                            radius: 60,
                                                          ),
                                                          Positioned(
                                                            bottom: 15,
                                                            right: 20,
                                                            child: InkWell(
                                                              onTap: () {},
                                                              child: const Icon(
                                                                  color:
                                                                      strokeTextColor,
                                                                  Icons
                                                                      .camera_alt_rounded),
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                      CustomTextField(
                                                        'enter name',
                                                        keyboardType:
                                                            TextInputType.name,
                                                        controller:
                                                            txtNameController,
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .user),
                                                        validator: (value) =>
                                                            validator(value),
                                                      ),
                                                      CustomTextField(
                                                        'enter last name',
                                                        controller:
                                                            txtLastController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .user),
                                                        validator: (value) =>
                                                            validator(value),
                                                      ),
                                                      CustomTextField(
                                                        'enter number',
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        controller:
                                                            txtPhoneController,
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .phone),
                                                        validator: (value) =>
                                                            validator(value),
                                                      ),
                                                      CustomButton(
                                                        onCLick: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            Contact newContact = new Contact(
                                                                name:
                                                                    txtNameController
                                                                        .text,
                                                                phone:
                                                                    txtLastController
                                                                        .text,
                                                                lastName:
                                                                    txtLastController
                                                                        .text);
                                                            setState(() {
                                                              contacts[index] =
                                                                  newContact;
                                                              print(contacts);
                                                            });
                                                          }
                                                        },
                                                        text: 'Add',
                                                      )
                                                    ]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: strokeTextColor,
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
