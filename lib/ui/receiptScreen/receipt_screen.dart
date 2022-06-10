import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';
import 'package:krc/ui/receiptScreen/receipt_presenter.dart';
import 'package:krc/ui/receiptScreen/receipt_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key key}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> implements ReceiptView {
  AnimationController menuAnimController;
  ReceiptPresenter _receiptPresenter;
  ReceiptResponse _receiptResponse;
  List<Responselist> _receiptList = [];

  @override
  void initState() {
    super.initState();
    _receiptPresenter = ReceiptPresenter(this);
    _receiptPresenter.getReceiptList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Receipts"),
            verticalSpace(20.0),
            Expanded(
              child: KRCListView(
                children: _receiptList.map<Widget>((e) => cardViewBooking(e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  cardViewBooking(Responselist e) {
    return InkWell(
      onTap: () {
        _modalBottomSheetMenu(e);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("#INVI-${e.invoiceNumber}", style: textStyleWhite14px600w),
          Spacer(),
          Text("RS ${e.amount}", style: textStyleWhite14px600w),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(Responselist e) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("RS ${e.amount}", style: textStyleWhiteHeavy24px),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "No:",
                        style: textStyleSubText12px600w,
                        children: [
                          TextSpan(text: " INVI-${e.invoiceNumber}", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "Slab:",
                        style: textStyleSubText12px600w,
                        children: [
                          TextSpan(text: " On submission of RFR", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(40.0),
                    PmlButton(
                      text: "Download",
                      onTap: () {
                        if (e.receiptPDF == null || e.receiptPDF.isEmpty) {
                          onError("Link not found");
                          return;
                        }
                        launch(e.receiptPDF);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onReceiptListFetched(ReceiptResponse receiptResponse) {
    _receiptResponse = receiptResponse;
    _receiptList.clear();
    _receiptList.addAll(_receiptResponse.responselist);
    setState(() {});
  }
}
