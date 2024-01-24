import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/bottomNavigation/home/model/booking_list_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';
import 'package:krc/ui/rmDetail/contact_us_presenter.dart';
import 'package:krc/ui/rmDetail/contact_us_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:krc/user/login_response.dart' as login;

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with TickerProviderStateMixin implements ContactUsView {
  late TabController _tabController = TabController(length: 0, vsync: this);

  RmDetailResponse? rmResponse;
  late ContactUsPresenter _contactUsPresenter;
  String bookingId = '';
  String? currentproject, currentunit, currenttower;
  List<login.BookingList> listOfBooking = [];
  Map<String, List<RmDetailResponse>> mapOfOpportunityIdAndReceipts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      _contactUsPresenter = ContactUsPresenter(this);
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      // mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = _receiptList;
      headerTextController.addListener(() {
        if (headerTextController.value == Screens.kContactUsScreen) {
          if (listOfBooking.isNotEmpty) _contactUsPresenter.getRMDetails(context, listOfBooking.first.bookingId ?? '');
          currentproject = listOfBooking.first.project;
          currentunit = listOfBooking.first.unit;
          currenttower = listOfBooking.first.tower;
        }
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.imagesIcHeadquaterImage), fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    cardViewBankDetail(),
                    verticalSpace(40.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      dividerHeight: 0,
      indicatorColor: AppColors.colorPrimary,
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      isScrollable: _tabController.length > 2,
      onTap: (int index) async {
        bookingId = listOfBooking[index].bookingId ?? "";
        print("booking id of selected tab is ${bookingId}");
        currentproject = listOfBooking[index].project;
        currentunit = listOfBooking[index].unit;
        currenttower = listOfBooking[index].tower;
        _contactUsPresenter.getRMDetails(context, bookingId);
        // mapOfOpportunityIdAndReceipts[bookingId] = _receiptList;
        setState(() {});
        // _receiptList.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}"))],
    );
  }

  Container cardViewBankDetail() {
    return Container(
      height: 320,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 14.0, blurRadius: 10.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          unitColumn(),
          nameColumn(),
          Text(
            "We are available from Monday to Friday between 10:30AM to 6:30PM",
            style: textStyleSubText14px500w,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget unitColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${currentproject ?? ""}", style: textStyle14px600w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Unit Number: ${currentunit ?? ""}", style: textStyle14px500w),
            horizontalSpace(20.0),
            Text(
              "Tower: ${currenttower ?? ""}",
              style: textStyle14px500w,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  Column nameColumn() {
    return Column(
      children: [
        line(),
        verticalSpace(12.0),
        Row(
          children: [
            /* ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                child: Image.memory(Utility.convertMemoryImage(null), fit: BoxFit.fill),
              ),
            ),*/
            horizontalSpace(16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (rmResponse?.rmName != null) Text("${rmResponse?.rmName}", style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (rmResponse?.rmEmailID != null) Text("${rmResponse?.rmEmailID}", style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (rmResponse?.rmPhone != null) Text("${rmResponse?.rmPhone}", style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(8.0),
        Row(
          children: [
            horizontalSpace(16.0),
            Image.asset(Assets.imagesIcCall, height: 40.0).onClick(onCallButtonTapAction),
            // horizontalSpace(12.0),
            // Image.asset(Assets.imagesIcMessage, height: 40.0).onClick(on),
            horizontalSpace(12.0),
            Image.asset(Assets.imagesIcWhatsApp, height: 40.0).onClick(onWhatsAppButtonTapAction),
            horizontalSpace(12.0),
            Image.asset(Assets.imagesIcMail, height: 40.0).onClick(onEmailButtonTapAction),
          ],
        ),
        verticalSpace(12.0),
        line(),
      ],
    );
  }

  void onCallButtonTapAction() async {
    String url = "tel:+91${rmResponse?.rmPhone}";
    await launch(url);
  }

  void onEmailButtonTapAction() async {
    String uri = 'mailto:${rmResponse?.rmEmailID}?subject=%20&body=%20';
    await launch(uri);
  }

  void onWhatsAppButtonTapAction() async {
    openWhatsapp(rmResponse?.rmPhone);
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onRmDetailFetched(RmDetailResponse rmDetailResponse) {
    rmResponse = rmDetailResponse;
    setState(() {});
  }

  openWhatsapp(String? mobileNumber) async {
    print("mobile number $mobileNumber");
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
}
