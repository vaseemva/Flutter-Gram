import 'package:flutter/material.dart';

const kHeight10 = SizedBox(
  height: 10,
);
const kHeight20 = SizedBox(
  height: 20,
);
const kHeight100 = SizedBox(
  height: 100,
);
const kwidth5 = SizedBox(
  width: 5,
);
const kwidth15 = SizedBox(
  width: 15,
);
final customBoxDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ],
);
