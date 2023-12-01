import 'dart:ui';

import 'package:flutter/material.dart';

const widgetsColor = Color(0xFF328f9d);
const strokeTextColor = Color.fromARGB(255, 22, 93, 104);
const LiterTextColor = Color.fromARGB(255, 57, 119, 143);
const CustomBlue = Color.fromARGB(255, 0, 144, 201);

const lightWidgetsColor = Color.fromARGB(255, 109, 187, 201);
const darkWidgetsColor = Color(0xFF008EA8);
const deviderColor = Color.fromARGB(128, 22, 93, 104);
const darkColor = Color.fromARGB(255, 29, 104, 115);
const errorColor = Color.fromARGB(255, 158, 42, 44);
CircleAvatar avatarColor = CircleAvatar(
  backgroundColor: Colors.grey[100],
  radius: 60,
);
const decorationSearch = BoxDecoration(
  gradient: LinearGradient(
    colors: [lightWidgetsColor, darkWidgetsColor, darkColor],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  ),
);
const searchIcon = Icon(
  Icons.search,
  color: Colors.white,
);
const addIcon = Icon(
  Icons.person_add_alt_sharp,
  color: Colors.white,
  size: 25,
);
const searchHint = TextStyle(color: Color.fromARGB(185, 255, 255, 255));
InputDecoration searchDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(8),
  prefixIcon: searchIcon,
  hintText: "Search contact",
  hintStyle: searchHint,
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
);
const devide = Divider(
  color: deviderColor,
  endIndent: 30,
  indent: 30,
);
