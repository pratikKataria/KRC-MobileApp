import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/home/model/rm_detail_response.dart';
import 'package:krc/ui/rmDetail/contact_us_presenter.dart';
import 'package:krc/ui/rmDetail/contact_us_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> implements ContactUsView {
  RmDetailResponse rmResponse;
  ContactUsPresenter _contactUsPresenter;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header("Contact"),
            verticalSpace(20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Relation Manager", style: textStyleWhite20px600w),
                  verticalSpace(16.0),
                  Text("${rmResponse?.rmName??""}", style: textStyleWhite14px500w),
                  Text("${rmResponse?.rmEmailID??""}", style: textStyleWhite14px500w),
                  Text("${rmResponse?.rmPhone??""}", style: textStyleWhite14px500w),
                ],
              ),
            ),
            verticalSpace(20.0),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    horizontalSpace(20.0),
                    cardViewItems(Images.kIconPhone, "Call", onCallButtonTapAction),
                    horizontalSpace(20.0),
                    cardViewItems(Images.kIconGmail, "Gmail", onEmailButtonTapAction),
                    horizontalSpace(20.0),
                  ],
                ),

                verticalSpace(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    horizontalSpace(20.0),
                    cardViewItems(Images.kIconWhats, "WHATS APP", onWhatsAppButtonTapAction),
                    horizontalSpace(20.0),
                    Expanded(child: Container()),
                    horizontalSpace(20.0),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
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
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onRmDetailFetched(RmDetailResponse rmDetailResponse) {
    rmResponse = rmDetailResponse;
    setState(() {});
  }

  openWhatsapp(String mobileNumber) async {
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
        onError(xe);
      }
    }
  }
}
