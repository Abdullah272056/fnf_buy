import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_service/api_service.dart';
import '../../../controller/order_page_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../data_base/note.dart';
import '../../../static/Colors.dart';

import '../../common_page/product_details.dart';
import '../cart_view_page.dart';




class OrderPage extends StatelessWidget {

  final cartPageController = Get.put(OrderPageController());
  final Uri _url = Uri.parse('https://fnfbuy.bizoytech.com/payment-api?surname=ripon&email=ripon@gmail.com&mobile=01732628761&amount=20');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
                // height: 50,
              ),
              Flex(direction: Axis.horizontal,
                children: [
                  SizedBox(width: 10,),
                  IconButton(
                    iconSize: 20,
                    icon:Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 5,),
                  Expanded(child: Text(
                    "SHOPPING CART",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),
              SizedBox(width: 15,),
              Expanded(child: Container(
                color: Colors.white,

                child: Column(
                  children: [

                    Expanded(
                        child: Container(
                          color: Colors.white,

                          child:  ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:1,
                              shrinkWrap: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Obx(() =>   ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: cartPageController.cartList.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return cartItem(cartPageController.cartList[index]);
                                        }),)
                                  ]

                                  ,
                                );
                              }),


                        )


                    ),

                  ],
                ),

              ))
            ],
          )

      )
    );



  }

  Widget cartItem(CartNote response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){
          _showToast("click");
          _launchUrl();
          //
          // Get.to(() => ProductDetailsePageScreen(), arguments: [
          //   {"productId": response.productId.toString()},
          //   {"second": 'Second data'}
          // ])?.then((value) => Get.delete<ProductDetailsController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [

                SizedBox(width: 15,),

                Expanded(child:Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Date: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "Order: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "#63b64d151cb7d",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "Total: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "\$138.1 for 2 item",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),),

                Container(
                  child: Text(
                    "Processing",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:fnf_color,
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Container(
                  height: .5,
                  color:hint_color,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  //join now url page redirect
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

