import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/resources/assets.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: lightcharcoalColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Theme.of(context).textTheme.bodyText2.color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'home.search'.tr(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
