import 'package:flutter/material.dart';

class ScaffoldKeyManager {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}