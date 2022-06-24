import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class BookingDetailScreen extends StatelessWidget {
  final Responselist responselist;

  const BookingDetailScreen(this.responselist, {Key key}) : super(key: key);

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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    Text("${responselist?.tower}", style: textStyleWhite20px600w),
                    verticalSpace(10.0),
                    ...textBuilder(responselist.toJsonX()),
                  ],
                ),
              ),
            ),
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
