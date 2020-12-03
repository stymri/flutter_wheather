import 'package:flutter/material.dart';
import 'package:flutter_wheather/Location.dart';
import 'package:flutter_wheather/wheatherDetails.dart';

Widget buildMenu(BuildContext context) {
  return PopupMenuButton<Location>(
    itemBuilder: (context) => <PopupMenuEntry<Location>>[
      PopupMenuItem(
        value: Location.Delhi,
        child: Text(Location.Delhi.toString()),
      ),
      PopupMenuItem(
        value: Location.Mumbai,
        child: Text(Location.Mumbai.toString()),
      ),
      PopupMenuItem(
        value: Location.London,
        child: Text(Location.London.toString()),
      ),
      PopupMenuItem(
        value: Location.Patna,
        child: Text(Location.Patna.toString()),
      ),
    ],
  );
}