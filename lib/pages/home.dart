import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../widgets/customTextField.dart';
import '../widgets/customTitle.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

_makingPhoneCall(phoneNumber) async {
  await FlutterPhoneDirectCaller.callNumber(phoneNumber);
}

class _HomeState extends State<Home> {
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please fill the missing informations';
    }
    return null;
  }

  static List<Contact> _contacts = [];
  List<Contact> _searchResult = [];
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController txtNameController = TextEditingController(),
        txtLastController = TextEditingController(),
        txtSearchController = TextEditingController(),
        txtPhoneController = TextEditingController();
    onSearchTextChanged(String text) async {
      print(_contacts);
      _searchResult.clear();
      if (text.isEmpty) {
        _searchResult.addAll(_contacts);
        setState(() {});
        return;
      }

      _contacts.forEach((userDetail) {
        if (userDetail.name.contains(text) ||
            userDetail.lastName.contains(text)) _searchResult.add(userDetail);
      });

      setState(() {});
    }

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
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
                                      _searchResult.add(newContact);
                                      _contacts.add(newContact);
                                      print(_contacts);
                                    });
                                    Navigator.pop(context);
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
          Icons.person_add_alt_sharp,
          color: Colors.white,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: SafeArea(
          child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [strokeTextColor, CustomBlue],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTitle(
              'Contacts',
              bottom: 20,
              top: 10,
              color: const Color.fromARGB(204, 255, 255, 255),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                controller: txtSearchController,
                onChanged: onSearchTextChanged,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search contact",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(185, 255, 255, 255)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: deviderColor,
                    endIndent: 30,
                    indent: 30,
                  ),
                  itemCount: _searchResult.length,
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
                              Text(_searchResult[index].name),
                              Text(_searchResult[index].phone)
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _makingPhoneCall(_searchResult[index].phone);
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
                                        _searchResult[index].lastName;
                                    txtNameController.text =
                                        _searchResult[index].name;
                                    txtPhoneController.text =
                                        _searchResult[index].phone;
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
                                                          child:
                                                              Stack(children: [
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
                                                              TextInputType
                                                                  .name,
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
                                                              TextInputType
                                                                  .name,
                                                          icon: const Icon(
                                                              FontAwesomeIcons
                                                                  .user),
                                                          validator: (value) =>
                                                              validator(value),
                                                        ),
                                                        CustomTextField(
                                                          'enter number',
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
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
                                                              Contact newContact = Contact(
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
                                                                _searchResult[
                                                                        index] =
                                                                    newContact;
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
