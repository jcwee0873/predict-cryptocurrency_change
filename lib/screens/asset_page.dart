import 'package:bitcamp_final/constant.dart';
import 'package:bitcamp_final/controllers/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetPage extends StatelessWidget {
  AssetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(10), child: MyAssetList()),
    );
  }
}

class MyAssetList extends StatelessWidget {
  MyAssetList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: AssetController.to.getMarketData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: code_list
                  .map((e) => Market(code: e, marketData: snapshot.data![e]))
                  .toList(),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Market extends StatelessWidget {
  Market({Key? key, required this.code, required this.marketData})
      : super(key: key);
  String code;
  Map marketData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(20),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        code,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '현재가치 : ${f.format(AssetController.to.assets[code] * AssetController.to.prices[code]).toString()}원',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text('보유수량 : ${AssetController.to.assets[code].toString()}'),
                  Row(
                    children: [
                      Text('익일예측 : '),
                      predsArrow(marketData['Predict']),
                      predsText(marketData['Predict'])
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Upbit : ${marketData['Upbit_dollar'].toStringAsFixed(4)}달러 (${f.format(marketData['Upbit'])}원)'),
                  Text(
                      '국내 거래소2 : ${marketData['Upbit_dum'].toStringAsFixed(4)}달러'),
                  Text(
                      'Bifinex : ${marketData['Investing'].toStringAsFixed(4)}달러'),
                  Text(
                      '해외 거래소2 : ${marketData['Investing_dum1'].toStringAsFixed(4)}달러'),
                  Text(
                      '해외 거래소3 : ${marketData['Investing_dum2'].toStringAsFixed(4)}달러'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget predsArrow(var pred) {
  if (pred == '01') {
    return Icon(
      Icons.arrow_drop_down,
      color: Colors.blue,
      size: 30,
    );
  } else if (pred == '00') {
    return Icon(
      Icons.arrow_downward,
      color: Colors.blue,
      size: 30,
    );
  } else if (pred == '11') {
    return Icon(
      Icons.arrow_drop_up,
      color: Colors.red,
      size: 30,
    );
  } else if (pred == '12') {
    return Icon(
      Icons.arrow_upward,
      color: Colors.red,
      size: 30,
    );
  }
  return Icon(Icons.horizontal_rule);
}

Widget predsText(var pred) {
  if (pred == '01') {
    return Text('5% 미만 하락');
  } else if (pred == '00') {
    return Text('5% 이상 하락');
  } else if (pred == '11') {
    return Text('5% 미만 상승');
  } else if (pred == '12') {
    return Text('5% 이상 상승');
  }
  return Text('변동 없음');
}
