
import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/static/Colors.dart';
import 'package:fnf_buy/view/dash_board/wish_list_page.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';

import '../../api_service/api_service.dart';
import '../../controller/product_details_controller.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import '../common_page/product_details.dart';
import '../common_page/custom_drawer.dart';
import '../common_page/product_list.dart';
import 'cart_page.dart';

class HomePageScreen extends StatelessWidget {
  // HomePageScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();

  //   @override
  //   State<HomePageScreen> createState() =>
  //       _HomePageScreenState();
  // }
  //
  // class _HomePageScreenState
  //     extends State<HomePageScreen> {
  //
  //   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();
  //   @override
  //   @mustCallSuper
  //   void initState() {
  //     super.initState();
  //
  //
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color:fnf_title_bar_bg_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
              // height: 50,
            ),

            ///title bar
            Obx(() => homeController.searchBoxVisible==0?
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {

                      if (_drawerKey.currentState!.isDrawerOpen) {
                        homeController.isDrawerOpen(false);
                        _drawerKey.currentState!.openEndDrawer();
                        return;
                      } else
                        _drawerKey.currentState!.openDrawer();
                      homeController.isDrawerOpen(true);
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: InkWell(

                    onTap: () {
                      homeController. searchBoxVisible(1);
                    },
                    child:  Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: InkWell(

                            onTap: () {
                            },
                            child: Image.asset(
                              "assets/images/fnf_logo.png",
                              // width: 25,
                              fit: BoxFit.fill,
                              height: 35,
                            ),
                          ),
                        ),
                      ),
                    )),



                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(

                    onTap: () {
                      if(homeController.userToken.isNotEmpty &&
                          homeController.userToken.value!=null){
                       // _showToast(homeController.userToken.toString());
                      //  _showToast("add favourite");
                        Get.to(WishListPage());
                      }else{
                        showLoginWarning();
                      }

                    },
                    child:  Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: InkWell(

                    onTap: () {

                      Get.to(CartPage());
                    },
                    child: Badge(
                      badgeContent:Obx(()=> Text(
                        homeController.cartCount.value.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500
                        ),
                      )),
                      badgeColor:fnf_color,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),



                  ),
                ),
              ],
            ):

            DelayedWidget(
              delayDuration: const Duration(milliseconds: 10),// Not required
              animationDuration: const Duration(milliseconds: 500),// Not required
              animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
              child: userInputSearchField(homeController.searchController!, 'Search product', TextInputType.text),
            ),

            ),


            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
              // height: 30,
            ),


            Expanded(
              child:  Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildBottomSectionDesign(),
                    ],
                  ),
                ),
              )


            ),


          ],
        ),

        /* add child content here */
      ),
    );
  }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          color:Colors.white,

          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextFormField(
          controller: userInput,
          textInputAction: TextInputAction.search,
          autofocus: true,
          cursorColor:fnf_color,
          style: TextStyle(color:text_color,),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color:hint_color,

                  //color: Colors.intello_hint_color,
                  size: 25,
                ),
                onPressed: () {
                  homeController. searchBoxVisible(0);

                }),
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Icon(
                  Icons.search,
                  color:hint_color,

                  //color: Colors.intello_hint_color,
                  size: 25,
                ),
                onPressed: () {
                 // homeController. searchBoxVisible(0);

                }),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 16,
                color:hint_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          onChanged: (value){
            if(value.isEmpty){
            //  _getMyCourseCourseDataList();
            }

          },
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
             // _search_courseList(value);
              // _showToast(value);
              /// Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchResultFileScreen(inputValue: value,)));
            }
          },

          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget _buildTabButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 10),
      height: 40,
      child: Row(
        children: [
          Expanded(child:Obx(()=> ListView.builder(
              itemCount:homeController.categoriesDataList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if(index==0){
                  return  _buildCategoriesTabItem(homeController.categoriesDataList[index],index,15,0);
                }
                else if(index==homeController.categoriesDataList.length-1){
                  return  _buildCategoriesTabItem(homeController.categoriesDataList[index],index,5,15);
                }

                else{
                  return  _buildCategoriesTabItem(homeController.categoriesDataList[index],index,5,0);
                }

              })),)
        ],
      ),
    );
  }

  Widget _buildCategoriesTabItem(var response,int index,double marginLeft,double marginRight) {
    return  InkWell(
      onTap: (){

        homeController.subCategoriesButtonColorStatus (index) ;
        Get.to(() => ProductListPage(), arguments: [
          {"categoriesId": response["id"].toString()},
          {"subCategoriesId": ""}
        ])?.then((value) => Get.delete<ProductDetailsController>());


      },
      child: Container(
        padding: const EdgeInsets.only(
            left:10.0, right: 10.0, bottom: 0, top: 0),
        margin:  EdgeInsets.only(left: marginLeft, right: marginRight),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Column(
            children: [

              Obx(() => Text(
                response["category_name"].toString().toUpperCase(),
              //  response.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 14,
                    fontWeight:homeController.subCategoriesButtonColorStatus== index? FontWeight.w700:FontWeight.w500),
              ),),

              Container(height: 7,),
              Obx(() => Container(
                  height: 3.5,
                  width: 50,
                  color: homeController.subCategoriesButtonColorStatus== index?Colors.blue:Colors.transparent,
                  // color: Colors.blue,
                  ))

            ],
          )
        ),
      ),
    );
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: fnf_color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildBottomSectionDesign() {
    double sizeHeight = Get.height;
    double sizeWidth = Get.width;
    // Size size = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
    return Container(
        width: sizeWidth,
        decoration:  BoxDecoration(
          color:Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
            child: Column(
              children: [

                ///categories tab section
                _buildTabButton(),

                ///slider section
                SizedBox(
                  height: sizeHeight * 0.23,
                  child: Swiper(
                    itemCount: 7,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: (){
                          _showToast(index.toString());
                        },
                        child: _sliderCardDesign(),
                      ) ;
                    },
                    autoplay: true,
                    pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.green)),
                    // control: const SwiperControl(),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
                  margin  : const EdgeInsets.only(left: 00, top: 10, right: 00, bottom: 10),
                  height: 190,
                  // color: Colors.lime,
                  child: Center(
                    child: Obx(() => GridView.builder(
                        itemCount:homeController.categoriesDataList.length,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 60

                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  categoriesListItemDesign(response: homeController.categoriesDataList[index]);
                          // return _buildRecentlyCourseItemForGrid(_recentlyAddedCourse[index]);
                        }),)
                  ),
                ),

                ////////////////////////////////////

                Obx(() =>   ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: homeController.homeDataList.isEmpty?0:homeController.homeDataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: homeController.homeDataList[index]["sub_categories"].isNotEmpty||
                              homeController.homeDataList[index]["sub_categories"].length>0?
                          homeController.homeDataList[index]["sub_categories"].length:0,

                          // cartViewPageController.cartList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index1) {
                            double regularPrice=0.0;



                            return homeController.homeDataList[index]["sub_categories"].length>0? Column(
                              children: [
                                if(homeController.homeDataList[index]["sub_categories"][index1]["products"].length>0)...{
                                  Container(
                                    margin:const EdgeInsets.only(right: 20.0,top: 00,left: 20),
                                    child:  Flex(direction: Axis.horizontal,
                                      children: [

                                        Expanded(child: Align(
                                          alignment: Alignment.topLeft,
                                          child:  Obx(()=>Text(
                                            homeController.homeDataList[index]["sub_categories"][index1]["subcategory_name"].toString(),
                                            // homeController.homeDataList[index],
                                            // "Mens Fashion",
                                            style: TextStyle(
                                                color:text_color,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            // textAlign: TextAlign.left,

                                          )),
                                        ),),


                                        Container(
                                          margin:  const EdgeInsets.only(left: 10.0, right: 0.0,top: 10),
                                          child: InkResponse(
                                            onTap: (){
                                              Get.to(() => ProductListPage(), arguments: [
                                                {"categoriesId": homeController.homeDataList[index]["category_id"].toString()},
                                                {"subCategoriesId": homeController.homeDataList[index]["sub_categories"][index1]["id"].toString()}
                                              ]);
                                          //     _showToast(homeController.homeDataList[index]["category_id"].toString());
                                          // _showToast(homeController.homeDataList[index]["sub_categories"][index1]["id"].toString());
                                              //   Navigator.push(context,MaterialPageRoute(builder: (context)=>const RecentlyAddedSeeMoreScreen()));

                                            },
                                            child: Image.asset(
                                              "assets/images/arrow_right.png",
                                              color: fnf_small_color,
                                              width: 27,
                                              height: 27,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                        )

                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height:270.0,

                                      // child: _buildRecentlyAddedCourseItem(),
                                      child:Obx(()=>
                                          ListView.builder(
                                            //  shrinkWrap: true,
                                            // physics: const NeverScrollableScrollPhysics(),
                                            itemCount:homeController.homeDataList[index]["sub_categories"][index1]["products"].isNotEmpty||
                                                homeController.homeDataList[index]["sub_categories"][index1]["products"].length>0?
                                            homeController.homeDataList[index]["sub_categories"][index1]["products"].length:0,
                                            // itemCount:9,
                                            itemBuilder: (context, index2) {
                                              if(MediaQuery.of(context).size.width<450){

                                                return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                                                    imageLink: "https://m.media-amazon.com/images/I/61TrmpaafpL._AC_UL320_.jpg",
                                                  response: homeController.homeDataList[index]["sub_categories"][index1]["products"][index2],


                                                );
                                              }

                                              else{
                                                return productCardDesign(height: 00, width: 420,
                                                    imageLink: "https://m.media-amazon.com/images/I/61TrmpaafpL._AC_UL320_.jpg",
                                                    response: homeController.homeDataList[index]["sub_categories"][index1]["products"][index2]
                                                );

                                              }

                                            },
                                            scrollDirection: Axis.horizontal,
                                          )
                                      )


                                  ),

                                }

                              ],
                            ):Container();

                          }));
                    }),),


              ],
            )));
  }

  Widget productCardDesign({
    required double height,
    required double width,
    required String imageLink,
    required var response,
  }) {
    return InkWell(
      onTap: (){

        // _showToast(message)

        Get.to(() => ProductDetailsePageScreen(), arguments: [
          {"productId": response["id"].toString()},
          {"second": 'Second data'}
        ])?.then((value) => Get.delete<ProductDetailsController>());

        // Get.to(() => ProductDetailsePageScreen(), arguments: [
        //   {"productId": response["id"].toString()},
        //   {"second": 'Second data'}
        // ]);
      },
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width:width/2 ,
            // height:width/1.3
            padding: EdgeInsets.only(left: 10,right: 10),
          //  margin: EdgeInsets.only(left: 10,right: 10),
            // color: Colors.white,
            child:  Column(
              // alignment: Alignment.bottomCenter,
              children: [
                Container(

                  decoration: BoxDecoration(
                    // color:Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Stack(
                    children: [
                      AspectRatio(
                          aspectRatio: 1,
                          child:Padding(
                              padding: EdgeInsets.only(left: 0,right: 0,top: 0),
                              // padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                              // padding: EdgeInsets.all(16),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/loading.png',
                                image:BASE_URL_API_IMAGE_PRODUCT+response["cover_image"].toString(),
                                imageErrorBuilder: (context, url, error) =>
                                    Image.asset(
                                      'assets/images/loading.png',
                                      fit: BoxFit.fill,
                                    ),
                              )
                            // Image.asset(
                            //     imageLink
                            // ),
                          )
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          onTap: (){

                            if(homeController.userToken.isNotEmpty &&
                                homeController.userToken.value!=null){
                             // _showToast("add favourite");
                              // _showToast(response["id"].toString());

                              homeController.addWishList(
                                  token: homeController.userToken.toString(),
                                  productId: response["id"].toString());

                            }else{
                              showLoginWarning();
                            }

                          },
                          child: Icon(Icons.favorite_outline,
                            color: hint_color,
                          ),

                        ),
                      )
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:  Text(
                            response["product_name"].toString(),

                           // "Men Grey Classic Regular Fit Formal Shirt",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            softWrap: false,
                            maxLines: 1,

                          ),
                        ),
                        // 12.widthBox,
                        // RatingWidget(rating: widget.product.rating),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              RatingBarIndicator(
                                // rating:response["avg_rating"],
                                rating:double.parse("4.5"),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color:Colors.orange,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                " 8 Review",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color:hint_color,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$ "+response["price"].toString(),
                          //  overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: hint_color,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w700),
                          // softWrap: false,
                          maxLines: 1,


                        ),
                        SizedBox(width: 10,),
                        Text("\$ "+response["price"].toString(),
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          softWrap: false,
                          maxLines: 1,

                        )


                      ],
                    ),



                  ],
                ),

              ],
            ),
          )
        ],
      )
    )

     ;
  }

  Widget _sliderCardDesign() {
    // Size size = MediaQuery.of(context).size;
    double sizeHeight = Get.height;
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      height: sizeHeight * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
            colors: [

              Color(0xFF7A60A5),
              //Color(0xFF82C3DF),
              fnf_color,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF9689CE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Get the special discount",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "40 %\nOFF",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // fontSize: 300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.network(
                width: double.infinity,
                // height: double.infinity,
                "https://i.ibb.co/vwB46Yq/shoes.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){
        Get.to(() => ProductListPage(), arguments: [
          {"categoriesId": response["id"].toString()},
          {"subCategoriesId": ""}
        ])?.then((value) => Get.delete<ProductDetailsController>());
      },
      child:  Container(
        margin: const EdgeInsets.only(right:00,top: 0,left: 0,bottom: 00),
        // height: 68,
        child: Padding(padding: const EdgeInsets.only(right:00,top: 0,left: 00,bottom: 0),
          child:  Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.5),
                child: Container(
                    height:50,
                    width: 50,
                    color:hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/loading.png',
                      image:BASE_URL_API_IMAGE_CATEGORIES+response["category_image"].toString(),

                         // "https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg",
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/loading.png',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),

              Container(
                  margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 00,top: 5),
                  child:  Text(
                    response["category_name"].toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:  TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoginWarning( ) {
    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,

      //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [

                          Container(

                            margin:EdgeInsets.only(right:00.0,top: 0,left: 00,
                              bottom: 0,
                            ),
                            child:Image.asset(
                              "assets/images/fnf_logo.png",
                              // color: sohojatri_color,
                              // width: 81,
                              height: 40,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "This section is Locked",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Go to login or Sign Up screen \nand try again ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(SignUpScreen());

                              //  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));

                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Ink(

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [sohojatri_color, sohojatri_color],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                child: Container(

                                  height: 40,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    "SIGN UP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PT-Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0),
                            child: InkWell(
                              onTap: (){
                                Get.back();
                                Get.to(LogInScreen());
                             //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                height: 40,
                                alignment: Alignment.center,
                                child:  Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sohojatri_color,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }


}
