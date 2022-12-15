

import 'package:flutter/material.dart';
import 'package:fnf_buy/view/account_page.dart';
import 'package:fnf_buy/view/cart_page.dart';
import 'package:fnf_buy/view/home_page.dart';
import 'package:fnf_buy/view/More_page.dart';
import 'package:fnf_buy/view/category_page.dart';

import 'package:get/get.dart';
import '../controller/dash_board_page_controller.dart';
import '../static/Colors.dart';

class DashBoardPageScreen extends StatelessWidget {

  // int selectedTabIndex;
  //  Widget selectedPage;
  //
  //
  // DashBoardPageScreen(this.selectedTabIndex, this.selectedPage);

  final dashBoardPageController = Get.put(DashBoardPageController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(

          child:Container(
           child: Obx(() =>dashBoardPageController.selectedPage[0]),

          )

        //
        //   child:  Obx(() =>
        //     IndexedStack(
        //       index:dashBoardPageController.selectedTabIndex.value,
        //       children: [
        //         HomePage(),
        //         ShopPage(),
        //         AccountPage(),
        //         CartPage(),
        //         SearchPage(),
        //       ],
        // )
        // ),



      ),

      bottomNavigationBar: Obx(() =>  BottomNavigationBar(
          selectedItemColor: bottom_nav_item_selected_color,
          unselectedItemColor: bottom_nav_item_unselected_color,
          currentIndex: dashBoardPageController.selectedTabIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index){
            dashBoardPageController.selectedTabIndex(index);
            if(index==0){
              dashBoardPageController.updateSelectedPage([HomePage()]);
              // selectedPage(HomePage( ));
              return;
            }

            if(index==1){
              dashBoardPageController.updateSelectedPage([CategoryPage()]);
              //  selectedPage(HomePage( ));
              // selectedPage= ShopPage( );
              return;
            }

            if(index==2){
              dashBoardPageController.updateSelectedPage([AccountPage()]);
              // selectedPage= AccountPage( );
              return;
            }

            if(index==3){
              dashBoardPageController.updateSelectedPage([CartPage()]);
              // selectedPage= CartPage( );
              return;
            }

            if(index==4){
              dashBoardPageController.updateSelectedPage([MorePage()]);
              // selectedPage= SearchPage( );
              return;
            }


          },
          items: [
            _bottomNavigationBarItem(iconData: Icons.home, levelText: 'Home'),
            _bottomNavigationBarItem(iconData: Icons.grid_view, levelText: 'Category'),
            _bottomNavigationBarItem(iconData: Icons.person, levelText: 'Account'),
            _bottomNavigationBarItem(iconData: Icons.add_shopping_cart, levelText: 'Cart'),
            _bottomNavigationBarItem(iconData: Icons.read_more, levelText: 'More'),


          ],
        ),),

    );
  }



_bottomNavigationBarItem({required IconData iconData,required String levelText}){

    return BottomNavigationBarItem(

        icon: Icon(iconData),
        // icon: Icon(Icons.icon),
        label: levelText

        // items:
    );
}

}
