import 'package:bitcamp_final/constant.dart';
import 'package:bitcamp_final/controllers/payment_controller.dart';
import 'package:bitcamp_final/screens/pay_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<Merchandise> merchandiseList = [
    Merchandise(name: '생수', price: 600),
    Merchandise(name: '콜라', price: 1000),
    Merchandise(name: '삼각김밥', price: 1400),
    Merchandise(name: '샌드위치', price: 1700),
    Merchandise(name: '사이다', price: 1000),
    Merchandise(name: '스마트폰', price: 1200000),
    Merchandise(name: '노트북', price: 2400000),
    Merchandise(name: '자동차', price: 45000000),
    Merchandise(name: '스포츠카', price: 120000000),
    Merchandise(name: '아파트', price: 400000000),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController());
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (PaymentController.to.paymentAmount.value == 0) {
              Get.snackbar(
                '결제금액이 0원입니다.',
                '결제하실 상품을 선택해주세요.',
                icon: Icon(Icons.warning),
              );
            } else {
              Get.to(PayDetailPage(), transition: Transition.downToUp);
            }
          },
          backgroundColor: kPrimaryColor,
          icon: Icon(Icons.payment),
          label:
              Text('${f.format(PaymentController.to.paymentAmount.value)}원 결제'),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 16 / 9,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            children: merchandiseList
                .map((e) => Card(
                      elevation: e.selected ? 3 : 0,
                      color: e.selected ? kPrimaryColor : Colors.grey.shade300,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (e.selected) {
                              e.selected = false;
                              PaymentController.to.paymentAmount -= e.price;
                              PaymentController.to.merchandiseList.remove(e);
                            } else {
                              e.selected = true;
                              PaymentController.to.paymentAmount += e.price;
                              PaymentController.to.merchandiseList.add(e);
                            }
                          });
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: e.selected
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                '${f.format(e.price).toString()}원',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: e.selected
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
