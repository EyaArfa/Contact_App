import 'package:callapp/Models/Conatct.dart';
import 'package:callapp/functions/edit_contact_bottom_modal.dart';
import 'package:callapp/functions/validator.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:callapp/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
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
  static List<Contact> _contacts = [];
  List<Contact> _searchResult = [];
  String result = '';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController txtNameController = TextEditingController(),
        txtLastController = TextEditingController(),
        txtPhoneController = TextEditingController();
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
                                  onCLick: () {
                                    if (_formKey.currentState!.validate()) {
                                      Contact newContact = Contact(
                                          name: txtNameController.text,
                                          phone: txtPhoneController.text,
                                          lastName: txtLastController.text);
                                      setState(() {
                                        _contacts.add(newContact);
                                      });
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
                child: (result.isEmpty || result.isNotEmpty) &&
                        _searchResult.isEmpty
                    ? const Center(
                        child: Text(
                        'No data found',
                        style: TextStyle(color: strokeTextColor, fontSize: 20),
                      ))
                    : ListView.separated(
                        separatorBuilder: (context, index) => devide,
                        itemCount: _searchResult.isNotEmpty
                            ? _searchResult.length
                            : _contacts.length,
                        itemBuilder: (context, index) => InkWell(
                          onLongPress: () {
                            String _user = _searchResult.isNotEmpty
                                ? _searchResult[index].name
                                : _contacts[index].name;

                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                content: Text(
                                    'Are you sure you want to delete${_user}'),
                                actions: [
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      setState(() {
                                        if (_searchResult.isNotEmpty) {
                                          Contact userDel =
                                              _searchResult[index];
                                          _searchResult.remove(userDel);

                                          _contacts.remove(userDel);
                                        } else {
                                          _contacts.remove(_contacts[index]);
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                      child: const Text('No'),
                                      onPressed: () => Navigator.pop(context)),
                                ],
                              ),
                            );
                            // _searchResult.remove(_searchResult[index]);
                            // _contacts.remove(_contacts[index]);
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.amber[100],
                                    radius: 50),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(_searchResult.isNotEmpty
                                          ? _searchResult[index].name
                                          : _contacts[index].name),
                                      Text(_searchResult.isNotEmpty
                                          ? _searchResult[index].phone
                                          : _contacts[index].phone)
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
                                                  ? _searchResult[index].phone
                                                  : _contacts[index].phone);
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
                                                _searchResult.isNotEmpty
                                                    ? _searchResult[index]
                                                        .lastName
                                                    : _contacts[index].lastName;
                                            txtNameController.text =
                                                _searchResult.isNotEmpty
                                                    ? _searchResult[index].name
                                                    : _contacts[index].name;
                                            txtPhoneController.text =
                                                _searchResult.isNotEmpty
                                                    ? _searchResult[index].phone
                                                    : _contacts[index].phone;
                                            editContactModalBottomSheet(
                                                context,
                                                txtNameController,
                                                txtLastController,
                                                txtPhoneController, () {
                                              setState(() {
                                                if (_searchResult.isNotEmpty) {
                                                  _searchResult[index]
                                                          .lastName =
                                                      txtLastController.text;
                                                  _searchResult[index].name =
                                                      txtNameController.text;
                                                  _searchResult[index].phone =
                                                      txtPhoneController.text;
                                                }
                                                _contacts[index].lastName =
                                                    txtLastController.text;
                                                _contacts[index].name =
                                                    txtNameController.text;
                                                _contacts[index].phone =
                                                    txtPhoneController.text;
                                                FocusScope.of(context)
                                                    .unfocus();
                                                Navigator.pop(context);
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
