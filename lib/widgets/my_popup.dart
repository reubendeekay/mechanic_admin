import 'package:flutter/cupertino.dart';

import 'package:flutter_beautiful_popup/main.dart';

void showMyPopup(BuildContext context) {
  final popup = BeautifulPopup(
    context: context,
    template: TemplateGeolocation,
  );
  popup.show(
    title: 'New Driver Request',
    content: 'You have received a new driver request',
    actions: [
      popup.button(
        label: 'Accept',
        onPressed: Navigator.of(context).pop,
      ),
    ],
    // bool barrierDismissible = false,
    // Widget close,
  );
}
