import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/controller/profile_detail_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/keys/drawer_key.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/ui/bottomNavigation/home/home_presenter.dart';
import 'package:krc/ui/bottomNavigation/home/home_view.dart';
import 'package:krc/ui/bottomNavigation/home/model/booking_list_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/project_detail_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/document/document_screen.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin implements HomeView {
  final SwiperController swipeController = new SwiperController();
  late AnimationController menuAnimController;
  late HomePresenter _homePresenter;

  // ProjectDetailResponse? projectDetailResponse;
  RmDetailResponse? _rmDetailResponse;
  List<BookingList> bookingList = [];
  BookingList? currentBooking;
  String? currentBookingId;
  int currentBookingIndexInt = 0;

  @override
  void initState() {
    super.initState();
    menuAnimController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _homePresenter = HomePresenter(this);

    // _homePresenter.getProfileDetailsNoLoader(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homePresenter.getBookingList(context);
      // _homePresenter.getProfileDetailsNoLoader(context);
      _homePresenter.postDeviceToken(context);
      headerTextController.value = Screens.kHomeScreen;
    });
    headerTextController.addListener(() {
      if (headerTextController.value == Screens.kHomeScreen) {
        _homePresenter.getBookingListNoLoader(context);
        // _homePresenter.getProfileDetailsNoLoader(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(10.0),
            carousel(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bookingList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.colorPrimary).withOpacity(currentBookingIndexInt == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),

            /*        Container(
              height: 180.0,
              child: Swiper(
                loop: false,
                controller: swipeController.,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(Utility.convertMemoryImage(bookingList[index].topScreenImage)), fit: BoxFit.fill),
                    ),
                  );
                },
                itemCount: bookingList.length,
                pagination: new SwiperPagination(),
              ),
            ),*/
            verticalSpace(10.0),
            Text(currentBooking?.project ?? "", style: textStyle14px600w),
            Row(
              children: [
                Text("Unit: ${currentBooking?.unit ?? ""}", style: textStyle14px500w),
                horizontalSpace(12.0),
                Container(height: 6.0, width: 6.0, color: AppColors.colorPrimary),
                horizontalSpace(12.0),
                Text("Tower: ${currentBooking?.tower ?? ""}", style: textStyle14px500w),
              ],
            ),
            verticalSpace(20.0),
            Row(
              children: [
                Expanded(
                  child: Image.asset(Assets.imagesIcQuickPay, height: 140).onClick(() => headerTextController.value = Screens.kQuickPayScreen),
                ),
                horizontalSpace(20.0),
                Expanded(
                  child: Image.asset(Assets.imagesIcServiceTicket, height: 140).onClick(() => headerTextController.value = Screens.kTicketsScreen),
                ),
              ],
            ),
            verticalSpace(20.0),
            Row(
              children: [
                Expanded(
                  child: Image.asset(Assets.imagesIcOutstandingPayment, height: 140).onClick(() => navigateTo(Screens.kOutstandingPayment)),
                ),
                horizontalSpace(20.0),
                Expanded(
                  child: Image.asset(Assets.imagesIcDocument, height: 140).onClick(() => navigateTo(Screens.kDocumentScreen)),
                ),
              ],
            ),
            verticalSpace(20.0),
            Row(
              children: [
                Expanded(
                  child: Image.asset(Assets.imagesIcConstructionUpdates, height: 140).onClick(() => navigateTo(Screens.kConstructionUpdateScreen)),
                ),
                horizontalSpace(20.0),
                Expanded(
                  child: Image.asset(Assets.imagesIcContactUs, height: 140).onClick(() => headerTextController.value = Screens.kContactUsScreen),
                ),
              ],
            ),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  void navigateTo(String screen) {
    Navigator.pushNamed(context, screen);
  }

  Expanded cardViewItems(String icon, String text, Function() onTap) {
    return Expanded(
      child: PmlButton(
        height: 110,
        color: AppColors.lightGrey.withOpacity(0.5),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 38.0, color: AppColors.white),
            verticalSpace(16.0),
            Text(text.toUpperCase(), style: textStyleWhite12px500w, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Container header() {
    // var baseProvider = Provider.of<BaseProvider>(context);
    return Container(
      color: AppColors.white,
      height: 50,
      child: Row(
        children: [
          horizontalSpace(20.0),
          PmlButton(
              height: 24.0,
              width: 24.0,
              color: AppColors.white,
              padding: EdgeInsets.only(top: 5.0),
              child: Image.asset(Assets.imagesIcMenu, width: 24.0, height: 24.0),
              onTap: () {
                drawerGlobalKey.currentState!.openDrawer();
                BaseProvider provider = Provider.of(context, listen: false);
                // provider.open();

                // print('is opened ${provider.isOpen}');
                // if (!provider.isOpen) {
                //   provider.open();
                //   menuAnimController.forward();
                // } else {
                //   provider.close();
                //   menuAnimController.reverse();
                // }
              }),
          Spacer(),
          Image.asset(Assets.imagesIcKRahejaCrop, height: 24.0),
          Spacer(),
          Image.asset(Images.kAppIcon, width: 50.0, height: 45.0),
        ],
      ),
    );
  }

  void onCallButtonTapAction() async {
    String url = "tel:+91${_rmDetailResponse?.rmPhone}";
    await launch(url);
  }

  void onEmailButtonTapAction() async {
    String uri = 'mailto:${_rmDetailResponse?.rmEmailID}?subject=%20&body=%20';
    await launch(uri);
  }

  void onSmsButtonTapAction() async {
    String url = "sms:+91${_rmDetailResponse?.rmPhone}";
    await launch(url);
  }

  void onWhatsAppButtonTapAction() async {
    openWhatsapp(_rmDetailResponse?.rmPhone);
  }

  void onDocumentButtonTapAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentScreen()));
  }

  void onAccountButtonTapAction() {
    // _modalBottomSheetMenu();
  }

  void onImageButtonTapAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConstructionImagesScreen()));
  }

  void onReraButtonTapAction() {
    // launch("${projectDetailResponse!.reraWebsite}");
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectDetailFetched(ProjectDetailResponse projectDetailResponse) {
    // this.projectDetailResponse = projectDetailResponse;
    _homePresenter.getRMDetails(context,currentBookingId ?? '');
    setState(() {});
  }

  @override
  void onTokenRegenerated(TokenResponse tokenResponse) async {
    //Save token
    var currentUser = await (AuthUser.getInstance().getCurrentUser() as Future<CurrentUser?>);
    currentUser?.tokenResponse = tokenResponse;
    AuthUser.getInstance().updateUser(currentUser!);

    //sent request again
    _homePresenter.getBookingList(context);
    // _homePresenter.getProfileDetailsNoLoader(context);
    _homePresenter.postDeviceToken(context);
  }

  @override
  void onRmDetailFetched(RmDetailResponse rmDetailResponse) {
    _rmDetailResponse = rmDetailResponse;
    setState(() {});
  }

  openWhatsapp(String? mobileNumber) async {
    var whatsapp = "+91${mobileNumber ?? ""}";
    var whatsappURl_android = "https://wa.me/$whatsapp/?text=hi";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if (mobileNumber == null) {
      Utility.showErrorToastB(context, "Mobile number not found");
      return;
    }

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Utility.showErrorToastB(context, "Whatsapp not installed");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      try {
        await launch(whatsappURl_android);
      } catch (xe) {
        onError(xe.toString());
      }
    }
  }

  final CarouselController _carouselController = CarouselController();

  CarouselSlider carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        aspectRatio: 2.0,
        disableCenter: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          currentBookingIndexInt = index;
          currentBooking = bookingList[index];
          currentBookingId = bookingList[index].bookingId;
          currentBookingDetailController.value = currentBooking;
          setState(() {});
        },
      ),
      carouselController: _carouselController,
      items: bookingList.map((i) {
        return InkWell(
          onTap: () {
            navigateTo(Screens.kBookingDetailScreen);
          },
          child: Container(
            width: Utility.screenWidth(context),
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              image: DecorationImage(image: MemoryImage(Utility.convertMemoryImage(i.topScreenImage)), scale: 1.5, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    profileDetailController.value = profileDetailResponse;
  }

  @override
  void onBookingListFetched(BookingListResponse bookingListResponse) {
    bookingList.clear();
    bookingList.addAll(bookingListResponse.bookingList ?? []);
    currentBookingId = bookingList.first.bookingId;
    currentBooking = bookingList.first;
    currentBookingDetailController.value = currentBooking;
    setState(() {});
  }
}
