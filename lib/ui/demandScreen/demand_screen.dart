import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/demandScreen/demand_presenter.dart';
import 'package:krc/ui/demandScreen/demand_view.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';

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
        child: Column(
          children: [
            Container(
              height: 35.0,
              decoration: BoxDecoration(color: AppColors.colorPrimary),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submit TDS Certificate',
                    style: textStyleWhite14px500w,
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.arrow_right_alt, color: AppColors.white)
                ],
              ),
            ).onClick(() {
              Navigator.pushNamed(context, Screens.kUploadTDSScreen);
            }),
            verticalSpace(20.0),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  ...demandList.map((e) => cardViewBankDetail(e)).toList(),
                ],
              ),
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  Row cardViewBankDetail(Responselist e) {
    NumberFormat currencyFormatter = NumberFormat.currency(locale: 'HI', symbol: "\u20b9");

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Amount", style: textStyle14px500w),
              Text("${currencyFormatter.format(e.total??0)}" ?? "Not Available", style: textStyleRegular18pxW600),
              Row(
                children: [
                  Text("Invoice Number - ", style: textStyleSubText14px500w),
                  Text("${e.invoiceNumber}", style: textStylePrimary14px500w),
                ],
              ),
              Text(e.invoiceName ?? "N/A", style: textStyleSubText14px500w),
              verticalSpace(4.0),
              PmlButton(width: 97.0, height: 32.0, text: "Pay Now", textStyle: textStyleWhite12px500w).onClick(() {
                Navigator.pop(context);
                headerTextController.value = Screens.kQuickPayScreen;
              }),
              verticalSpace(25.0),
              line(),
              verticalSpace(25.0),
            ],
          ),
        ),
        Column(
          children: [
            Icon(Icons.remove_red_eye_rounded, size: 24.0, color: Colors.grey.shade400).onClick(() => Utility.launchUrlX(context, e.viewInvoicePDf)),
            verticalSpace(10.0),
            Icon(Icons.downloading_sharp, size: 24.0, color: Colors.grey.shade400).onClick(() => Utility.launchUrlX(context, e.downloadInvoicePDf)),
          ],
        ),
      ],
    );
  }

  cardViewBooking(Responselist e) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
