import 'dart:io';

import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/functions/edit_contact_bottom_modal.dart';
import 'package:callapp/functions/validator.dart';
import 'package:callapp/services/sqlite_serice.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
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
  late SqliteService db;
File? image;

  static List<Contact> _contacts = [];
  List<Contact> _searchResult = [];
  String result = '';
  bool _loading=true;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
   db=SqliteService();
    db.initizateDb().whenComplete(() async {

    _refreshContact();
    });

  }
   _refreshContact() async {
    final data = await db.getItems();
  setState(() {
    _contacts = data;
    if(_searchResult.isNotEmpty) {
        _searchResult = _contacts;
        txtSearchController.clear();
      }

      _loading=false;
  });
  }

    TextEditingController txtNameController = TextEditingController(),
        txtLastController = TextEditingController(),
        txtSearchController = TextEditingController(),
        txtPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    onSearchTextChanged(String text) async {
      setState(() {
        result = text;

        if (text.isEmpty) {
          _searchResult = _contacts;
          return;
        } else {
          _searchResult = _contacts
              .where((item) =>
                  item.name.toLowerCase().contains(text.toLowerCase()) ||
                  item.lastName.toLowerCase().contains(text.toLowerCase()))
              .toList();
        }
      });
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
                builder: (_) => StatefulBuilder(
                      builder: (context, builder) => Expanded(
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
                                      image == null
                                          ? avatarColor
                                          : ClipOval(
                                              child: Image.file(
                                                image!,
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
                                                         setState(()=>image =
                                                             temp);
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
                                                        setState(() =>
                                                          image =
                                                              File(img!.path)
                                                        );
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
                                    onCLick: () {
                                      if (_formKey.currentState!.validate()) {
                                        Contact newContact = Contact(
                                            name: txtNameController.text,
                                            phone: txtPhoneController.text,
                                            lastName: txtLastController.text,
                                            image: image);
                                        image = null;
                                        txtLastController.clear();
                                        txtNameController.clear();
                                        txtPhoneController.clear();
                                        setState(() {

                                        });
                                          db.createContact(newContact);
                                          _refreshContact();

                                        FocusScope.of(context).unfocus();
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
                      ),
                    ));
          },
          child: addIcon),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: SafeArea(
          child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: decorationSearch,
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
                onChanged: (value) => onSearchTextChanged(value),
                maxLines: 1,
                controller:txtSearchController ,
                decoration: searchDecoration,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                child:_loading?const Center(child: CircularProgressIndicator(),):
                (result.isEmpty && _contacts.isEmpty) ||
                        (result.isNotEmpty && _searchResult.isEmpty)
                 ? const Center(
                        child: Text(
                        'No data found',
                        style: TextStyle(color: strokeTextColor, fontSize: 20),
                      ),)
                    :
                 ListView.separated(
                                separatorBuilder: (context, index) => devide,
                                itemCount: _searchResult.isNotEmpty
                                    ? _searchResult.length
                                    : _contacts.length,
                                itemBuilder: (context, index) {
                                  print('$index ${_searchResult.length}  ${_contacts.length}');

                                  Contact _user = _searchResult.isNotEmpty
                                      ? _searchResult[index]
                                      : _contacts[index];
                                  return InkWell(
                                    onLongPress: () {


                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          content: Text(
                                              'Are you sure you want to delete${_user}'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                  if (_searchResult
                                                      .isNotEmpty) {
                                                    Contact userDel =
                                                        _searchResult[index];
                                                    db.deleteContact(
                                                        userDel.id);
                                                  } else {
                                                    db.deleteContact(
                                                        _contacts[index].id);
                                                  }
                                                  _refreshContact();


                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                                child: const Text('No'),
                                                onPressed: () =>
                                                    Navigator.pop(context)),
                                          ],
                                        ),
                                      );

                                    },
                                    child: Container(
                                      height: 70,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          _user.image == null
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  radius: 50)
                                              : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: ClipOval(
                                                    child: Image.file(
                                                      _contacts[index].image!,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(_user.name),
                                                Text(_user.phone)
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 5,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    _makingPhoneCall(
                                                        _searchResult.isNotEmpty
                                                            ? _searchResult[
                                                                    index]
                                                                .phone
                                                            : _contacts[index]
                                                                .phone);
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
                                                      setState(() {

                                                      txtLastController
                                                          .text = _user
                                                              .lastName;
                                                      txtNameController
                                                          .text = _user.name;
                                                      txtPhoneController
                                                          .text = _user
                                                              .phone;
                                                      editContactModalBottomSheet(
                                                          context,
                                                          _user,
                                                          txtNameController,
                                                          txtLastController,
                                                          txtPhoneController,
                                                          () {

                                                              print('controllers ${txtLastController
                                                                  .text} ${ txtNameController
                                                                  .text} ${txtPhoneController
                                                                  .text}');
                                                              Contact updated=Contact(name: txtNameController
                                                                  .text, phone: txtPhoneController
                                                                  .text, lastName: txtLastController
                                                                  .text,image:_user.image);
                                                            updated.id=_user.id;

                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          Navigator.pop(
                                                              context);
                                                              txtLastController.clear();
                                                              txtNameController.clear();
                                                              txtPhoneController.clear();
                                                          db.updateContact(updated);
                                                      _refreshContact();

                                                      });
                                                      });

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
                                  );
                                })


              ),
            ),
          ],
        ),
      )),
    );
  }
}
