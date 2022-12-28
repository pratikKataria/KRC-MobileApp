import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/model/booking_detail_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';

class BookingDetailScreen extends StatelessWidget {
  late BookingDetailResponse bookingDetailResponse;
  List<BookingDetailResponselist> bookingDetailResponseList = [];

  BookingDetailScreen(BookingDetailResponse response, {Key? key}) : super(key: key) {
    // this.bookingDetailResponse = response;
    // bookingDetailResponseList.clear();
    // bookingDetailResponse.responselist!.forEach((element) {
    //   if (element.value != null && !element.value!.contains("null")) bookingDetailResponseList.add(element);
    // });
  }

  // Project ,unit no, address ,tower booking id
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
      if (response[key] == null) continue;

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
    return richTextList;
  }
}

/*


 Column(
          children: [
            Header("Booking detail"),
            verticalSpace(20.0),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.white),
                      children: [
                        TableRow(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black,
                              child: Text("Items", style: textStyleWhite12px700w),
                            ),
                            Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Values", style: textStyleWhite12px700w),
                            ),
                          ],
                        ),
                        ...bookingDetailResponseList
                            .map((e) => TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e.fieldname}", style: textStyleWhite12px700w),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e.value}", style: textStyleWhite12px700w),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20.0),
            //     child: ListView(
            //       children: [
            //         Text("${bookingDetailResponse?.tower}", style: textStyleWhite20px600w),
            //         verticalSpace(10.0),
            //         ...textBuilder(bookingDetailResponse.toJsonX()),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),


*/
