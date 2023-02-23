import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/booking_presenter.dart';
import 'package:krc/ui/booking/model/booking_detail_response.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';
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
    var body = {"RestBookingDetails": currentBookingDetailController.value?.bookingId};

    Dialogs.showLoader(context, "Getting booking details ...");
    apiController.post(EndPoints.POST_BOOKING_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
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
        Dialogs.hideLoader();
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }

  @override
  void onBookingListFetched(BookingResponse profileDetailResponse) {}
}
