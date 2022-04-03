import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/FAQScreen.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/ui/booking/Demand_screen.dart';
import 'package:krc/ui/booking/booking_screen.dart';
import 'package:krc/ui/booking/receipt_screen.dart';
import 'package:krc/ui/profile/profile_screen.dart';
import 'package:krc/utils/Utility.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThirdLayer extends StatelessWidget {
  String currentSelectedScreen = Screens.kHomeScreen;
  BaseProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<BaseProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 80.0),
              child: Container(
                  // child: Image.asset(Images.kIconKitaboIcon, height: 90),
                  ),
            ),
            verticalSpace(30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()))},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset(Images.kPH3, width: 106.0),
                  ),
                ),
                verticalSpace(20.0),
                /*    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(Images.kPH4, width: 120.0),
                ),*/

                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Home", style: textStyleWhite20px500w),
                      verticalSpace(20.0),
                      InkWell(
                        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()))},
                        child: Text("My Bookings", style: textStyleWhite20px500w),
                      ),
                      verticalSpace(20.0),
                      Text("My Profile", style: textStyleWhite20px500w),
                      verticalSpace(20.0),
                      Text("Contact Us", style: textStyleWhite20px500w),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()))},
                          child: Text("FAQs", style: textStyleWhite20px500w)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => TicketScreen()))},
                          child: Text("My Tickets", style: textStyleWhite20px500w)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => DemandScreen()))},
                          child: Text("My Demands", style: textStyleWhite20px500w)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptScreen()))},
                          child: Text("My Receipts", style: textStyleWhite20px500w)),
                      verticalSpace(50.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerRowBuilder(String iconRes, String screen, {BuildContext context}) {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            Container(
              width: 90,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
              margin: EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: screen == currentSelectedScreen ? AppColors.white : AppColors.screenBackgroundColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(topRight: Radius.circular(55.0), bottomRight: Radius.circular(55.0)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  iconRes,
                  color: screen == currentSelectedScreen ? AppColors.screenBackgroundColor : AppColors.white,
                ),
              ),
            ),
            horizontalSpace(12.0),
            Text(
              screen,
              style: TextStyle(color: screen == currentSelectedScreen ? AppColors.white : AppColors.textColorSubText),
            ),
          ],
        ),
      ),
      onTap: () async {
        /*  if (_provider.isOpen) _provider.close();
        await Future.delayed(Duration(milliseconds: 300));
        if (screen == Screens.kReferScreen || screen == Screens.kOffersScreen) {
          Utility.showToastB(context, 'Not available');
          return;
        }
        if (currentSelectedScreen != screen) Navigator.pushNamed(context, screen);*/
      },
    );
  }
}
