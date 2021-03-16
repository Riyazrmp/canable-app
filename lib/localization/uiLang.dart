import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

getalignment(languageCode) {
  switch (languageCode) {
    case 'en':
      return Alignment.centerLeft;

      break;
    case 'hi':
      return Alignment.centerLeft;

      break;
    case 'ur':
      return Alignment.centerRight;

      break;
  }
}

getalignmentStackButtons(languageCode) {
  switch (languageCode) {
    case 'en':
      return Alignment.bottomRight;

      break;
    case 'hi':
      return Alignment.bottomRight;

      break;
    case 'ur':
      return Alignment.bottomLeft;

      break;
  }
}

getTextFieldArrow(languageCode) {
  switch (languageCode) {
    case 'en':
      return CupertinoIcons.arrow_right_circle_fill;
    case 'hi':
      return CupertinoIcons.arrow_right_circle_fill;
    case 'ur':
      return CupertinoIcons.arrow_left_circle_fill;
      break;
    default:
  }
}

getarrow(languageCode) {
  switch (languageCode) {
    case 'en':
      return CupertinoIcons.chevron_forward;
    case 'hi':
      return CupertinoIcons.chevron_forward;
    case 'ur':
      return CupertinoIcons.chevron_back;
      break;
    default:
  }
}
