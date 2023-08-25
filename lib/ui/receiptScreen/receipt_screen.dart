import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';
import 'package:krc/ui/receiptScreen/receipt_presenter.dart';
import 'package:krc/ui/receiptScreen/receipt_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';

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
    NumberFormat currencyFormatter = NumberFormat.currency(locale: 'HI', symbol: "\u20b9");
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesIcPdf, height: 38),
            horizontalSpace(20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Receipt No: ${e.receiptNumber}", style: textStyle14px500w),
                  Wrap(
                    children: [
                      Text("For the amount of ", style: textStyleSubText14px500w),
                      Text("${currencyFormatter.format(e.amount)}", style: textStylePrimary14px500w),
                      Text(" on ", style: textStyleSubText14px500w),
                      Text("${e.receiptDate}", style: textStylePrimary14px500w),
                    ],
                  ),
                  // Text(e.receiptName??"", style: textStyleSubText14px500w)
                ],
              ),
            ),
            horizontalSpace(20.0),
            Icon(Icons.remove_red_eye_rounded, size: 24.0, color: Colors.grey.shade400).onClick(() => Utility.launchUrlX(context, e.viewReceiptPDF)),
            // Column(
            //   children: [
                // Icon(Icons.downloading_sharp, size: 24.0, color: Colors.grey.shade400)
                //     .onClick(() => Utility.launchUrlX(context, e.downloadReceiptPDF)),
              // ],
            // ),
          ],
        ),
        verticalSpace(20.0),
        line(),
        verticalSpace(20.0),
      ],
    );
  }

  void actionBottomSheet(String viewLink, downloadLink) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Actions", style: textStyle14px500w),
                    verticalSpace(10.0),
                    line(),
                    verticalSpace(20.0),
                    Row(
                      children: [
                        Icon(Icons.link, size: 24.0, color: Colors.grey.shade400),
                        horizontalSpace(10.0),
                        Text("View", style: textStyle14px500w),
                      ],
                    ).onClick(() => Utility.launchUrlX(context, viewLink)),

                    verticalSpace(20.0),
                    Row(
                      children: [
                        Icon(Icons.downloading_sharp, size: 24.0, color: Colors.grey.shade400),
                        horizontalSpace(10.0),
                        Text("Download", style: textStyle14px500w),
                      ],
                    ).onClick(() => Utility.launchUrlX(context, downloadLink)),

                    //bottom height
                    verticalSpace(20.0),
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
