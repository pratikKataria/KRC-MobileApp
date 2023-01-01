import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';
import 'package:krc/ui/receiptScreen/receipt_presenter.dart';
import 'package:krc/ui/receiptScreen/receipt_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> implements ReceiptView {
  AnimationController? menuAnimController;
  late ReceiptPresenter _receiptPresenter;
  late ReceiptResponse _receiptResponse;
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(20.0),
            ..._receiptList.map((e) => cardViewBooking(e)).toList(),
          ],
        ),
      ),
    );
  }

  cardViewBooking(Responselist e) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(Assets.imagesIcPdf, height: 38),
            horizontalSpace(20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Receipt No: IR-${e.receiptNumber}", style: textStyle14px500w),
                  Wrap(
                    children: [
                      Text("For the amount of ", style: textStyleSubText14px500w),
                      Text("${e.amount}", style: textStylePrimary14px500w),
                      Text(" on ", style: textStyleSubText14px500w),
                      Text("${e.receiptDate}", style: textStylePrimary14px500w),
                    ],
                  ),
                  Text("On submission of RFR", style: textStyleSubText14px500w)
                ],
              ),
            ),
            horizontalSpace(20.0),
            Image.asset(Assets.imagesIcDownload, height: 34).onClick(() {
              Utility.launchUrlX(context, e.receiptPDF);
            }),
          ],
        ),
        verticalSpace(20.0),
        line(),
        verticalSpace(20.0),
      ],
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
                          TextSpan(text: " RECPT-${e.receiptNumber}", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "Invoice No:",
                        style: textStyleSubText12px600w,
                        children: [
                          TextSpan(text: " ${e.invoiceNumber}", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(40.0),
                    PmlButton(
                      text: "Download",
                      onTap: () {
                        if (e.receiptPDF == null || e.receiptPDF!.isEmpty) {
                          onError("Link not found");
                          return;
                        }
                        launch(e.receiptPDF!);
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
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onReceiptListFetched(ReceiptResponse receiptResponse) {
    _receiptResponse = receiptResponse;
    _receiptList.clear();
    _receiptList.addAll(_receiptResponse.responselist!);
    setState(() {});
  }
}
/*

   Header("Receipts"),
            verticalSpace(20.0),
            KRCListView(
              children: _receiptList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )



*/