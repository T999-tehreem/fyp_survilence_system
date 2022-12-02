import 'package:flutter/material.dart';

const primary_Color = Color(0xFF2697FF);
const secondary_Color = Color(0xff040426);
const bgColor = Color(0xFF202A44);

const defaultPadding = 16.0;

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

void navigate(context, String to, {arguments}) {
  Navigator.of(context).pushNamed(to, arguments: arguments);
}

void nav(context, to, {arguments, function}) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => to))
      .then((value) => {function()});
}

void navigateAndRemove(BuildContext context, String to) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    to,
        (route) => false,
  );
}

void pop(context) {
  Navigator.of(context).pop('');
}
