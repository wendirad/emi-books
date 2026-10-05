import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.heightOf(context) * 0.2,
      width: MediaQuery.widthOf(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Illustrations.splashScreenMain),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
