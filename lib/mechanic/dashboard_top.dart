import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import 'package:mechanic_admin/helpers/constants.dart';
import 'package:mechanic_admin/helpers/invoice/invoice_page.dart';
import 'package:mechanic_admin/mechanic/add_service.dart';
import 'package:mechanic_admin/mechanic/admin_mechanic_profile.dart';
import 'package:mechanic_admin/mechanic/manage_bookings/manage_bookings_screen.dart';
import 'package:mechanic_admin/providers/auth_provider.dart';
import 'package:mechanic_admin/providers/invoice_provider.dart';
import 'package:mechanic_admin/widgets/my_popup.dart';
import 'package:provider/provider.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mechanic = Provider.of<AuthProvider>(context).mechanic;

    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height * 0.29 - MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Your Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(ChatScreen.routeName);
                  //   },
                  //   child: const Icon(
                  //     FontAwesomeIcons.paperPlane,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AdminMechanicProfile());
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: kPrimaryColor,
                      backgroundImage:
                          CachedNetworkImageProvider(mechanic!.profile!),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardTopOption(
                  color: Colors.green,
                  icon: Icons.dashboard_customize,
                  title: 'Add\nService(s)',
                  onTap: () => Get.to(() => const AddServices(
                        isDashboard: true,
                      )),
                ),
                const DashboardTopOption(
                  color: Colors.blue,
                  icon: Icons.event_seat_outlined,
                  title: 'Manage\nBookings',
                  routeName: ManageBookingsScreen.routeName,
                ),
                DashboardTopOption(
                  color: Colors.orange,
                  icon: Icons.bar_chart,
                  title: 'Your\nInvoices',
                  onTap: () async {
                    // final pdfFile = await PdfInvoiceApi.generate(invoice);

                    // PdfApi.openFile(pdfFile);
                    showMyPopup(context);
                  },
                ),
                // DashboardTopOption(
                //   color: Colors.red,
                //   icon: Icons.person_search_rounded,
                //   onTap: () {
                //     Get.to(() => const Adminmechanic_adminProfile());
                //   },
                //   title: 'mechanic_admin\nProfile',
                // ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTopOption extends StatelessWidget {
  final Color? color;
  final String? title;
  final IconData? icon;
  final String? routeName;
  final Function? onTap;

  const DashboardTopOption(
      {Key? key, this.color, this.title, this.icon, this.routeName, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : () => Navigator.pushNamed(context, routeName!),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            if (title != null)
              const SizedBox(
                height: 5,
              ),
            if (title != null)
              FittedBox(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
