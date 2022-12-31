import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/home/model/rm_detail_response.dart';
import 'package:krc/ui/rmDetail/contact_us_presenter.dart';
import 'package:krc/ui/rmDetail/contact_us_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> implements ContactUsView {
  RmDetailResponse? rmResponse;
  late ContactUsPresenter _contactUsPresenter;

  @override
  void initState() {
    super.initState();
    _contactUsPresenter = ContactUsPresenter(this);
    _contactUsPresenter.getRMDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.imagesIcHeadquaterImage), fit: BoxFit.fill),
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
      ),
    );
  }

  Container cardViewBankDetail() {
    return Container(
      height: 290,
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

  Column unitColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Raheja Sterling", style: textStyle14px600w),
        Row(
          children: [
            Text("Unit Number: IB903", style: textStyle14px500w),
            horizontalSpace(20.0),
            Container(height: 6.0, width: 6.0, color: AppColors.colorPrimary),
            horizontalSpace(20.0),
            Text("Tower: IB", style: textStyle14px500w),
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
            Container(height: 34.0, width: 34.0, child: Placeholder()),
            horizontalSpace(20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${rmResponse?.rmName}", style: textStyle14px500w),
                Text("${rmResponse?.rmEmailID}", style: textStyle14px500w),
              ],
            ),
          ],
        ),
        verticalSpace(8.0),
        Row(
          children: [
            horizontalSpace(54.0),
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
      } catch(xe) {
        onError(xe.toString());
      }
    }
  }
}
