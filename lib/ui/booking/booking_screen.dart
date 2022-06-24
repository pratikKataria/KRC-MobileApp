import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/booking_detail_screen.dart';
import 'package:krc/ui/booking/booking_presenter.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/ui/uploadTDS/upload_tds_screen.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';

import 'booking_view.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> implements BookingView {
  AnimationController menuAnimController;
  BookingPresenter bookingPresenter;
  List<Responselist> bookingList = [];

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
            Header("Booking"),
            verticalSpace(20.0),
            KRCListView(
              children: bookingList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )
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
          Text("${responselist?.tower}", style: textStyleWhite14px600w),
          Text("Unit No - ${responselist?.unitNo}", style: textStyleWhite14px600w),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(Responselist responselist) {
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
                      Text("${responselist?.tower}", style: textStyleWhite20px600w),
                      verticalSpace(10.0),
                      RichText(
                        text: TextSpan(
                          text: "Project : ",
                          style: textStyleSubText12px600w,
                          children: [
                            TextSpan(text: "${responselist.project}", style: textStyleWhite12px700w),
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
                            TextSpan(text: "${responselist.unitNo}", style: textStyleWhite12px700w),
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
                            TextSpan(text: "${responselist.address}", style: textStyleWhite12px700w),
                            WidgetSpan(child: verticalSpace(20.0)),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 300.0,
                      //   child: Scrollbar(
                      //     isAlwaysShown: true,
                      //     radius: Radius.circular(10.0),
                      //     interactive: true,
                      //     hoverThickness: 20.0,
                      //     child: ListView(
                      //       children: [
                      //         ...textBuilder(responselist.toJson()),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailScreen(responselist)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TDSScreen(responselist.bookingID)));
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
    bookingList.addAll(profileDetailResponse.responselist);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
