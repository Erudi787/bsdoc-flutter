import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isLoggedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
}