import 'package:bitcamp_final/constant.dart';
import 'package:bitcamp_final/controllers/asset_controller.dart';
import 'package:bitcamp_final/controllers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
  SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Card(
        elevation: 3,
        semanticContainer: false,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<PageIndexController>(builder: (_controller) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text('Bitcamp B1 Final Project'),
                SizedBox(height: 20),
                AmountAssets(),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    PageIndexController.to.changePage(0);
                  },
                  leading: Icon(Icons.payment),
                  title: Text('결제 하기'),
                  trailing:
                      _controller.index == 0 ? Icon(Icons.chevron_right) : null,
                ),
                // ListTile(
                //   onTap: () {
                //     PageIndexController.to.changePage(1);
                //   },
                //   leading: Icon(Icons.assessment),
                //   title: Text('나의 자산'),
                //   trailing:
                //       _controller.index == 1 ? Icon(Icons.chevron_right) : null,
                // ),
                SizedBox(height: 20),
                Divider(),
                CurrencyPrices(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class CurrencyPrices extends StatelessWidget {
  const CurrencyPrices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<Map>(
          future: AssetController.to.getCurrencyPrices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: ['BTC', 'ETH', 'SOL', 'XRP', 'LTC', 'ADA']
                      .map((e) => ListTile(
                            title: Text(e),
                            trailing: Text(
                                '${f.format(snapshot.data![e]).toString()}원'),
                          ))
                      .toList(),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class AmountAssets extends StatelessWidget {
  AmountAssets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AssetController());
    return Obx(
      () => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: kPrimaryColor,
        child: Container(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${f.format(AssetController.to.getAmount()).toString()}원',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 2),
                Text(
                  '현재 총 자산',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
