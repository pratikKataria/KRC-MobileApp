import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/demandScreen/demand_presenter.dart';
import 'package:krc/ui/demandScreen/demand_view.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> implements DemandView {
  AnimationController menuAnimController;
  DemandPresenter _presenter;
  DemandResponse response;
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
            Header("Demand  "),
            verticalSpace(20.0),
            Expanded(
              child: KRCListView(
                children: demandList.map<Widget>((e) => cardViewBooking(e)).toList(),
              ),
            )
          ],
        ),
      ),
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
          Spacer(),
          PmlButton(
            height: 30.0,
            text: "PAY NOW",
            textStyle: textStyleWhite12px600w,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
          ),
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
                        if (e.invoicePDf == null || e.invoicePDf.isEmpty) {
                          onError("Link not found");
                          return;
                        }
                        launch(e.invoicePDf);
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
  void onDemandListFetched(DemandResponse receiptResponse) {
    response = receiptResponse;
    demandList.clear();
    demandList.addAll(receiptResponse.responselist);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
