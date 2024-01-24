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
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/login_response.dart' as login;
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';

import '../../user/CurrentUser.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key? key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> with TickerProviderStateMixin implements DemandView {
  late TabController _tabController = TabController(length: 0, vsync: this);

  AnimationController? menuAnimController;
  late DemandPresenter _presenter;
  DemandResponse? response;
  List<Responselist> demandList = [];
  List<login.BookingList> listOfBooking = [];
  Map<String, List<Responselist>> mapOfOpportunityIdAndReceipts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      _presenter = DemandPresenter(this);
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      if (listOfBooking.isNotEmpty) _presenter.getDemandList(context, listOfBooking.first.bookingId ?? '');
      mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = demandList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(10.0),
            Expanded(
              child: IndexedStack(
                index: _tabController.index,
                children: [
                  ...listOfBooking.map((e) {
                    bool mapContainsList = mapOfOpportunityIdAndReceipts.containsKey(e.bookingId);
                    List<Responselist> tempListOfOpportunity = mapContainsList ? mapOfOpportunityIdAndReceipts[e.bookingId] ?? [] : [];
                    print("map contains list ");
                    print(tempListOfOpportunity.length);
                    print(mapContainsList);
                    if (mapContainsList) {
                      return demandList.isEmpty
                          ? Center(child: Text("No Invoice Found", style: textStyle14px500w))
                          : ListView.builder(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              itemCount: tempListOfOpportunity.length,
                              itemBuilder: (BuildContext context, int index) {
                                String bookingId = e.bookingId ?? "";
                                Responselist data = mapOfOpportunityIdAndReceipts[bookingId]![index];
                                return cardViewBankDetail(data);
                              },
                            );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      dividerHeight: 0,
      indicatorColor: AppColors.colorPrimary,
      unselectedLabelStyle: textStyle12px400w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle12px600w,
      labelColor: AppColors.textColor,
      isScrollable: _tabController.length > 2,
      onTap: (int index) async {
        String bookingId = listOfBooking[index].bookingId ?? "";
        _presenter.getDemandList(context, bookingId);
        mapOfOpportunityIdAndReceipts[bookingId] = demandList;
        setState(() {});
        demandList.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}"))],
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
              Text("${currencyFormatter.format(e.total ?? 0)}" ?? "Not Available", style: textStyleRegular18pxW600),
              Row(
                children: [
                  Text("Invoice Number - ", style: textStyleSubText14px500w),
                  Text("${e.invoiceNumber}", style: textStylePrimary14px500w),
                ],
              ),
              Text(e.invoiceName ?? "N/A", style: textStyleSubText14px500w),
              verticalSpace(4.0),
              // PmlButton(width: 97.0, height: 32.0, text: "Pay Now", textStyle: textStyleWhite12px500w).onClick(() {
              //   Navigator.pop(context);
              //   headerTextController.value = Screens.kQuickPayScreen;
              // }),
              verticalSpace(25.0),
              line(),
              verticalSpace(25.0),
            ],
          ),
        ),
        Icon(Icons.remove_red_eye_rounded, size: 24.0, color: Colors.grey.shade400).onClick(() => Utility.launchUrlX(context, e.viewInvoicePDf)),
        // Column(
        //   children: [
        // Icon(Icons.downloading_sharp, size: 24.0, color: Colors.grey.shade400)
        //     .onClick(() => Utility.launchUrlX(context, e.downloadReceiptPDF)),
        // ],
        // ),
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
