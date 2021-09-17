import 'package:flutter/material.dart';
import 'package:practical/src/constants/dimens.constants.dart';

class VisualHandle extends StatelessWidget {
  const VisualHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      heightFactor: 4.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 6,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(kCardRadiusBig),
          ),
        ),
      ),
    );
  }
}
