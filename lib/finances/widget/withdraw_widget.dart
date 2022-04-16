import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:mechanic_admin/helpers/constants.dart';
import 'package:mechanic_admin/helpers/my_loader.dart';
import 'package:mechanic_admin/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class WithdrawWidget extends StatefulWidget {
  const WithdrawWidget({
    Key? key,
    this.balance,
  }) : super(key: key);

  final double? balance;

  @override
  State<WithdrawWidget> createState() => _WithdrawWidgetState();
}

class _WithdrawWidgetState extends State<WithdrawWidget> {
  String? amount;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.55,
          maxChildSize: 0.8,
          minChildSize: 0.3,
          builder: (ctx, controller) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: ListView(
                controller: controller,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 70,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'Withdraw Funds',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.pinkAccent),
                          ),
                          const Divider()
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                        amount = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter amount',
                          border: InputBorder.none,
                          fillColor: Colors.white.withOpacity(0.1),
                          filled: true),
                    ),
                  ),
                  Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: RaisedButton(
                        onPressed: isLoading ? null : () async {},
                        color: kPrimaryColor,
                        child: isLoading
                            ? const MyLoader()
                            : const Text(
                                'Withdraw',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      'The amount withdrawn will be credited to the phone number registered with the host provider account. Contact admin for any queries',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
