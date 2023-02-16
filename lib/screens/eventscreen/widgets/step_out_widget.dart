import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/constants.dart';

class StepOutWidget extends StatelessWidget {
  const StepOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.two_wheeler,
          size: 20,
          color: stepOutColor,
        ),
        kwidth15,
        Text(
          "Step out and enjoy the event",
          style: TextStyle(fontSize: 10, color: stepOutColor),
        )
      ],
    );
  }
}
