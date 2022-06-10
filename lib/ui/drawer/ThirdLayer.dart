import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/booking/booking_screen.dart';
import 'package:krc/ui/core/login/login_screen.dart';
import 'package:krc/ui/faq/FAQScreen.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/ui/profile/profile_presenter.dart';
import 'package:krc/ui/profile/profile_screen.dart';
import 'package:krc/ui/profile/profile_view.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
import 'package:krc/ui/rmDetail/contact_us_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThirdLayer extends StatelessWidget implements ProfileView {
  String currentSelectedScreen = Screens.kHomeScreen;
  BaseProvider _provider;
  ProfilePresenter _profilePresenter;
  ProfileDetailResponse _profileDetailResponse;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      _profilePresenter = ProfilePresenter(this);
      if (!kDebugMode) _profilePresenter.getProfileDetailsNoLoader(context);
    }
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
            verticalSpace(20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          child: Image.memory(Utility.convertMemoryImage(_profileDetailResponse?.profilePic), fit: BoxFit.fill),
                        ),
                      ),
                      Text('${_profileDetailResponse?.accountName ?? ""}', style: textStyleWhite16px700w),
                      Text('${_profileDetailResponse?.emailID ?? ""}', style: textStyleWhite12px400w),
                      Text('${_profileDetailResponse?.phone ?? ""}', style: textStyleWhite12px400w),
                    ],
                  ),
                ),
                verticalSpace(40.0),
                /*    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(Images.kPH4, width: 120.0),
                ),*/

                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (_provider.isOpen) _provider.close();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                        },
                        child: Text("My Bookings", style: textStyleWhiteRegular18pxW700),
                      ),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                          },
                          child: Text("My Profile", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
                          },
                          child: Text("Contact Us", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                          },
                          child: Text("FAQs", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketScreen()));
                          },
                          child: Text("My Tickets", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DemandScreen()));
                          },
                          child: Text("My Demands", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () {
                            if (_provider.isOpen) _provider.close();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptScreen()));
                          },
                          child: Text("My Receipts", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(20.0),
                      InkWell(
                          onTap: () async {
                            if (_provider.isOpen) _provider.close();
                            await AuthUser.getInstance().logout();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Text("Logout", style: textStyleWhiteRegular18pxW700)),
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

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    _profileDetailResponse = profileDetailResponse;
  }

  @override
  void onProfileUploaded() {}
}
