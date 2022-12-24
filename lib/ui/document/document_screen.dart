import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/document/model/document_response.dart' as DR;
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/krc_list_v2.dart';

import 'document_presenter.dart';
import 'document_view.dart';
import 'model/booking_response.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> implements DocumentView {
  AnimationController? menuAnimController;

  late DocumentPresenter bookingPresenter;
  List<Responselist> bookingList = [];
  DR.DocumentResponse? bookingResponse;
  List<DR.DocResponselist> documentList = [];

  @override
  void initState() {
    super.initState();
    bookingPresenter = DocumentPresenter(this);
    bookingPresenter.getBookingList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Document"),
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
        bookingPresenter.getDocumentsList(context, responselist.bookingID);
        // _modalBottomSheetMenu(responselist);
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

  void _modalBottomSheetMenu(DR.DocumentResponse documentResponse) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${documentResponse.tower}", style: textStyleWhite20px600w),
                    Text("${documentResponse.unitNO} Units", style: textStyleWhite16px600w),
                    verticalSpace(20.0),
                    Container(
                      height: 150.0,
                      child: KRCListViewV2(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(8.0),
                        children: [
                          ...documentResponse.responselist!.map<Widget>(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${e.fileName}", style: textStyleWhite14px500w),
                                InkWell(
                                    onTap: () {
                                      Utility.funcLunchUrl(this, e?.downloadlink);
                                    },
                                    child: Icon(Icons.arrow_circle_down_outlined, color: AppColors.white, size: 18.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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
  void onDocumentsFileFetched(DR.DocumentResponse bookingResponse) {
    bookingResponse = bookingResponse;
    documentList.addAll(bookingResponse.responselist!);
    _modalBottomSheetMenu(bookingResponse);
    setState(() {});
  }
}
