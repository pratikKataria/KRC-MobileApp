import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/booking_detail_screen.dart';
import 'package:krc/ui/booking/booking_presenter.dart';
import 'package:krc/ui/booking/model/booking_detail_response.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/ui/ongoingProject/model/ongoing_project_response.dart';
import 'package:krc/ui/uploadTDS/upload_tds_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';

import 'booking_view.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> implements BookingView {
  AnimationController? menuAnimController;
  late BookingPresenter bookingPresenter;
  List<Responselist> bookingList = [];
  BookingDetailResponse? bookingDetailResponse;

  @override
  void initState() {
    super.initState();
    bookingPresenter = BookingPresenter(this);
    bookingPresenter.getBookingList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20.0),
            Center(
              child: Container(
                color: AppColors.bookingDetailCardBg,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(Assets.imagesIcInfo, height: 24.0),
                    Text("Apartment Information", style: textStyle14px500w),
                    Text("The following are the property information", style: textStyleSubText12px500w),
                    verticalSpace(20.0),
                    Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 20.0,
                      spacing: 20.0,
                      children: [
                        bookingDetailItem(Assets.imagesIcBuildingNo, "Building No.", "1299"),
                        bookingDetailItem(Assets.imagesIcFloorNo, "Floor No", "4"),
                        bookingDetailItem(Assets.imagesIcBuildingNo, "Apartment No", "Not Available"),
                        bookingDetailItem(Assets.imagesIcApartmentType, "Apartment Type", "Not Available"),
                        bookingDetailItem(Assets.imagesIcParking, "Type of Parking", "Not Available"),
                        bookingDetailItem(Assets.imagesIcCarpet, "RERA Carpet Area", "Not Available"),
                        bookingDetailItem(Assets.imagesIcArea, "Number of Parking Spaces", "Not Available"),
                        bookingDetailItem(Assets.imagesIcSecurityAmount, "Agreement Value", "423,324324"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            Container(
              color: AppColors.bookingDetailCardBg,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Get Billing Details View", style: textStyle14px500w),
                        Text("Know about all the billing related to your properties", style: textStyleSubText12px500w),
                        verticalSpace(8.0),
                        PmlButton(width: 97.0, height: 32.0, text: "View Detail", textStyle: textStyleWhite12px500w)
                      ],
                    ),
                  ),
                  Image.asset(Assets.imagesIcInvoiceDetail, height: 84.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewBooking(Responselist responselist) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _modalBottomSheetMenu(responselist);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("${responselist?.tower}", style: textStyleWhite14px600w),
          // Text("Unit No - ${responselist?.unitNo}", style: textStyleWhite14px600w),
        ],
      ),
    );
  }

  Row bookingDetailItem(String image, title, value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(image, height: 32.0),
        horizontalSpace(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: textStyleSubText14px500w),
            Text(value, style: textStyle14px500w),
          ],
        ),
      ],
    );
  }


  void _modalBottomSheetMenu(Responselist response) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                // address, tower, unit, project
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: AppColors.cardColorDark2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("${response?.tower}", style: textStyle14px500w),
                      verticalSpace(10.0),
                      RichText(
                        text: TextSpan(
                          text: "Project : ",
                          style: textStyleSubText12px600w,
                          children: [
                            // TextSpan(text: "${response.project}", style: textStyleWhite12px700w),
                            WidgetSpan(child: verticalSpace(20.0)),
                          ],
                        ),
                      ),
                      verticalSpace(10.0),
                      RichText(
                        text: TextSpan(
                          text: "Unit : ",
                          style: textStyleSubText12px600w,
                          children: [
                            // TextSpan(text: "${response.unitNo}", style: textStyleWhite12px700w),
                            WidgetSpan(child: verticalSpace(20.0)),
                          ],
                        ),
                      ),
                      verticalSpace(10.0),
                      RichText(
                        text: TextSpan(
                          text: "Address : ",
                          style: textStyleSubText12px600w,
                          children: [
                            // TextSpan(text: "${response.address}", style: textStyleWhite12px700w),
                            WidgetSpan(child: verticalSpace(20.0)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              bookingPresenter.getBookingDetails(context, response.bookingID);
                            },
                            child: Text("more ...", style: textStylePrimary14px500w),
                          ),
                        ],
                      ),
                      verticalSpace(10.0),
                      PmlButton(
                        text: "UPLOAD TDS",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TDSScreen(response.bookingID)));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<RichText> textBuilder(Map<String, dynamic> response) {
    List<RichText> richTextList = [];
    for (String key in response.keys) {
      if (key != "ProjectDescription" && response[key] != null) {
        richTextList.add(RichText(
          text: TextSpan(
            text: "$key : ",
            style: textStyleSubText12px600w,
            children: [
              TextSpan(text: "${response[key]}", style: textStyleWhite12px700w),
              WidgetSpan(child: verticalSpace(20.0)),
            ],
          ),
        ));
      }
    }
    return richTextList;
  }

  @override
  void onBookingListFetched(BookingResponse profileDetailResponse) {
    bookingList.clear();
    bookingList.addAll(profileDetailResponse.responselist!);
    setState(() {});
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onBookingDetailFetched(BookingDetailResponse bookingResponse) {
    bookingDetailResponse = bookingResponse;
    // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailScreen(bookingResponse)));
    setState(() {});
  }

  void getBookingDetails() async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"AccountID": "a0B3C000005S7KnUAK"};

    Dialogs.showLoader(context, "Getting booking details ...");
    apiController.post(EndPoints.POST_BOOKING_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        BookingResponse quickPayResponse = BookingResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          setState(() {
            // listOfBanks.addAll(quickPayResponse.upcomingProjecList ?? []);
            bookingDetailResponse = (quickPayResponse.responselist??[]).first as BookingDetailResponse?;
          });
        } else {
          onError(quickPayResponse.message ?? "Failed");
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }

}
