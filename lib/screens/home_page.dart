import 'package:bitcamp_final/components/side_bar.dart';
import 'package:bitcamp_final/controllers/asset_controller.dart';
import 'package:bitcamp_final/controllers/page_controller.dart';
import 'package:bitcamp_final/controllers/payment_controller.dart';
import 'package:bitcamp_final/screens/asset_page.dart';
import 'package:bitcamp_final/screens/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AssetController());
    return Scaffold(
      body: GetBuilder<PageIndexController>(
        init: PageIndexController(),
        builder: (_controller) {
          return Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blueAccent.withOpacity(0.2),
                  Colors.white,
                ],
              ),
            ),
            child: Row(
              children: [
                SideBar(),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    semanticContainer: false,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3,
                    color: Colors.white,
                    child: IndexedStack(
                      index: _controller.index,
                      children: [
                        PaymentPage(),
                        // AssetPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
