import 'package:flutter/material.dart';

import 'package:pingna/resources/assets.dart';

class PreloaderWidget extends StatelessWidget {
  const PreloaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Image.asset(appLogoPath, width: 150),
      ),
    );
  }
}
