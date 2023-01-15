import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/demandScreen/demand_presenter.dart';
import 'package:krc/ui/demandScreen/demand_view.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key? key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> implements DemandView {
  AnimationController? menuAnimController;
  late DemandPresenter _presenter;
  DemandResponse? response;
  List<Responselist> demandList = [];

  @override
  void initState() {
    super.initState();
    _presenter = DemandPresenter(this);
    _presenter.getDemandList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(20.0),
            ...demandList.map((e) => cardViewBankDetail("${e.total??"N/A"}", e.invoiceNumber, e.invoiceName)).toList(),
          ],
        ),
      ),
    );
  }

  Column cardViewBankDetail(String amount, invoiceNumber, payNowData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Amount", style: textStyle14px500w),
        Text(amount??"Not Available", style: textStyleRegular18pxW600),
        Row(
          children: [
            Text("Your invoice number is", style: textStyleSubText14px500w),
            Text(" $invoiceNumber", style: textStylePrimary14px500w),
          ],
        ),
        Text(payNowData??"N/A", style: textStyleSubText14px500w),
        verticalSpace(4.0),
        PmlButton(width: 97.0, height: 32.0, text: "Pay Now", textStyle: textStyleWhite12px500w).onClick(() {
          Navigator.pop(context);
          headerTextController.value = Screens.kQuickPayScreen;
        }),
        verticalSpace(25.0),
        line(),
        verticalSpace(25.0),
      ],
    );
  }


  cardViewBooking(Responselist e) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _modalBottomSheetMenu(e);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("#INVI-${e.invoiceNumber}", style: textStyleWhite14px600w),
              Text("RS ${e.total}", style: textStyleWhite14px600w),
            ],
          ),
        /*  Spacer(),
          PmlButton(
            height: 30.0,
            text: "PAY NOW",
            textStyle: textStyleWhite12px600w,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
          ),*/
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
                    Text("RS. ${e.total}", style: textStyleWhiteHeavy24px),
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
                    ...paymentAgainstBuilder(e),
                    verticalSpace(40.0),
                    // PmlButton(
                    //   text: "Download",
                    //   onTap: () {
                    //     if (e.invoicePDf == null || e.invoicePDf!.isEmpty) {
                    //       onError("Link not found");
                    //       return;
                    //     }
                    //     launch(e.invoicePDf!);
                    //     Navigator.pop(context);
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<RichText> paymentAgainstBuilder(Responselist responselist) {
    List<RichText> text = [];

    Map responseListMap = responselist.toJson();
    for (String keys in responseListMap.keys as Iterable<String>) {
      if (responseListMap[keys] != null) {
        if (keys.toLowerCase().startsWith("payment")) {
          text.add(RichText(
            text: TextSpan(
              text: "$keys: ",
              style: textStyleSubText12px600w,
              children: [
                TextSpan(text: "${responseListMap[keys]}", style: textStyleWhite12px700w),
                WidgetSpan(child: verticalSpace(20.0)),
              ],
            ),
          ));
        }
      }
    }
    return text;
  }

  @override
  void onDemandListFetched(DemandResponse receiptResponse) {
    response = receiptResponse;
    demandList.clear();
    demandList.addAll(receiptResponse.responselist!);
    setState(() {});
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }
}

/*


 Header("Demand  "),
            verticalSpace(20.0),
            KRCListView(
              children: demandList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )

*/
