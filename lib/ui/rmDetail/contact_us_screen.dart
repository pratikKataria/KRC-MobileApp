import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/home/model/rm_detail_response.dart';
import 'package:krc/ui/rmDetail/contact_us_presenter.dart';
import 'package:krc/ui/rmDetail/contact_us_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
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
                  Text("${rmResponse?.rmName}", style: textStyleWhite14px500w),
                  Text("${rmResponse?.rmEmailID}", style: textStyleWhite14px500w),
                  Text("${rmResponse?.rmPhone}", style: textStyleWhite14px500w),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      String url = "tel:+91${rmResponse?.rmPhone}";
                      await launch(url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(Images.kIconCall),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent, onTap: () async {
                      String uri = 'mailto:${rmResponse?.rmEmailID}?subject=%20&body=%20';
                      await launch(uri);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.kIconGmail),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent, onTap: () {
                      openWhatsapp(rmResponse.rmPhone);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.kIconWhats),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        Utility.showErrorToastB(context, "Failed to open Whatsapp");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
