import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/controller/navigator_controller.dart';
import 'package:krc/controller/profile_detail_controller.dart';
import 'package:krc/controller/side_navigation_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';

// ignore: must_be_immutable
class PersistenceSideNavigation extends StatelessWidget {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utility.screenWidth(context) * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: Colors.white,
      child: Drawer(
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpace(30.0),
              ValueListenableBuilder<ProfileDetailResponse?>(
                valueListenable: profileDetailController,
                builder: (context, value, _) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          child: Image.memory(Utility.convertMemoryImage(value?.profilePic), fit: BoxFit.fill),
                        ),
                      ),
                      horizontalSpace(20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(4.0),
                            Text('${value?.accountName ?? "Not Available"}',
                                style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                            verticalSpace(4.0),
                            Text('${value?.emailID ?? "Not Available"}',
                                style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                            verticalSpace(4.0),
                            Text('${value?.phone ?? "Not Available"}',
                                style: textStyle14px500w, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              verticalSpace(30.0),
              line(),
              verticalSpace(20.0),

              //options
              Text("My Unit", style: textStyle14px500w),
              rowBuilder(Assets.imagesIcMyBooking, "My Bookings").onClick(() => navigateTo(Screens.kBookingDetailScreen)),
              rowBuilder(Assets.imagesIcPerson, "My Profile").onClick(() => navigateTo(Screens.kProfileScreen)),
              rowBuilder(Assets.imagesIcTicket2, "My Tickets").onClick(() => navigateToHome(Screens.kTicketsScreen)),
              rowBuilder(Assets.imagesIcFile, "My Demand").onClick(() => navigateTo(Screens.kDemandScreen)),
              rowBuilder(Assets.imagesIcFile, "My Receipts").onClick(() => navigateTo(Screens.kReceiptScreen)),
              verticalSpace(20.0),
              line(),
              verticalSpace(20.0),
              Text("Complex", style: textStyle14px500w),
              rowBuilder(Assets.imagesIcContactUs2, "Contact Us").onClick(() => navigateToHome(Screens.kContactUsScreen)),
              rowBuilder(Assets.imagesIcFaqs, "FAQs").onClick(() => navigateTo(Screens.kFaqScreen)),
              rowBuilder(Assets.imagesIcNotification, "Notifications").onClick(() => navigateToHome(Screens.kNotificationScreen)),
              rowBuilder(Assets.imagesIcOngoingProject, "Ongoing Projects").onClick(() => navigateTo(Screens.kOngoingScreen)),
              rowBuilder(Assets.imagesIcOngoingProject, "Loyalty Reference").onClick(() => navigateTo(Screens.kLoyaltyReferenceScreen)),
            ],
          ),
        ),
      ),
    );
  }

  navigateTo(String screenName) {
    sideNavigationController.currentState?.closeDrawer();
    navigatorController.currentState?.pushNamed(screenName);
  }

  navigateToHome(String screenName) {
    sideNavigationController.currentState?.closeDrawer();
    headerTextController.value = screenName;
  }

  Container rowBuilder(String ic, name) {
    return Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Image.asset(ic, height: 22.0, color: AppColors.colorPrimary),
          horizontalSpace(20.0),
          Text(name, style: textStyle14px500w),
        ],
      ),
    );
  }
}

/*
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
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                        },
                        child: Text("My Bookings", style: textStyleWhiteRegular18pxW700),
                      ),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                        },
                        child: Text("Notifications", style: textStyleWhiteRegular18pxW700),
                      ),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                          },
                          child: Text("My Profile", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
                          },
                          child: Text("Contact Us", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                          },
                          child: Text("FAQs", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketScreen()));
                          },
                          child: Text("My Tickets", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DemandScreen()));
                          },
                          child: Text("My Demands", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptScreen()));
                          },
                          child: Text("My Receipts", style: textStyleWhiteRegular18pxW700)),
                      verticalSpace(10.0),
                      line(width: 150.0),
                      verticalSpace(10.0),
                      InkWell(
                          onTap: () async {
                            Navigator.pop(context);
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


              .onClick(() => navigatorController.currentState?.pop()),


*/
