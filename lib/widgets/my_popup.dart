import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_beautiful_popup/main.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic_admin/home/trail_map.dart';
import 'package:mechanic_admin/models/request_model.dart';
import 'package:mechanic_admin/providers/auth_provider.dart';

void showMyPopup(BuildContext context, RequestModel request) {
  final popup = BeautifulPopup(
    context: context,
    template: TemplateGeolocation,
  );
  popup.show(
    title: 'New Driver Request',
    content:
        'You have received a new driver request from ${request.user!.fullName}',

    actions: [
      popup.button(
        label: 'Accept',
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('/requests/mechanics/$uid')
              .doc(request.id)
              .update({
            'status': 'ongoing',
          });

          Get.offAll(() => TrailMapScreen(request));
        },
      ),
      popup.button(
        label: 'Deny',
        outline: true,
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('/requests/mechanics/$uid')
              .doc(request.id)
              .update({
            'status': 'denied',
          });
          Navigator.of(context).pop();
        },
      ),
    ],
    // bool barrierDismissible = false,
    // Widget close,
  );
}

class MyPopDialog extends StatefulWidget {
  const MyPopDialog({Key? key, required this.request}) : super(key: key);
  final RequestModel request;
  @override
  State<MyPopDialog> createState() => _MyPopDialogState();
}

class _MyPopDialogState extends State<MyPopDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () => showMyPopup(context, widget.request));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
    );
  }
}
