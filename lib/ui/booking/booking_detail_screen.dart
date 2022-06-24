import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/model/booking_detail_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class BookingDetailScreen extends StatelessWidget {
  BookingDetailResponse bookingDetailResponse;
  List<BookingDetailResponselist> bookingDetailResponseList = [];

  BookingDetailScreen(BookingDetailResponse response, {Key key}) : super(key: key) {
    this.bookingDetailResponse = response;
    bookingDetailResponseList.clear();
    bookingDetailResponse.responselist.forEach((element) {
      if (element.value != null && !element.value.contains("null")) bookingDetailResponseList.add(element);
    });
  }

  // Project ,unit no, address ,tower booking id
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Booking Detail"),
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
      ),
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
