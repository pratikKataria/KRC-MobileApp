import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/quickPayScreen/model/quick_pay_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/user/login_response.dart' as login;

class QuickPayScreen extends StatefulWidget {
  const QuickPayScreen({Key? key}) : super(key: key);

  @override
  State<QuickPayScreen> createState() => _QuickPayScreenState();

  static of(BuildContext context, {bool root = false}) => root ? context.findRootAncestorStateOfType<_QuickPayScreenState>() : context.findAncestorStateOfType<_QuickPayScreenState>();
}

class _QuickPayScreenState extends State<QuickPayScreen> with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 0, vsync: this);
  List<BankDataList> listOfBanks = [];
  List<login.BookingList> listOfBooking = [];
  Map<String, List<BankDataList>> mapOfOpportunityIdAndReceipts = {};
  String bookingId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = listOfBanks;
      currentBookingDetailController.addListener(() {
        if (listOfBooking.isNotEmpty) getBankDetail(listOfBooking.first.bookingId ?? '');
      });
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
            verticalSpace(40.0),
            Expanded(
              child: Container(
                child: IndexedStack(
                  index: _tabController.index,
                  children: [
                    ...listOfBooking.map((e) {
                      bool mapContainsList = mapOfOpportunityIdAndReceipts.containsKey(e.bookingId);
                      List<BankDataList> tempListOfOpportunity = mapContainsList ? mapOfOpportunityIdAndReceipts[e.bookingId] ?? [] : [];
                      print("map contains list ");
                      print(tempListOfOpportunity.length);
                      print(mapContainsList);
                      if (mapContainsList) {
                        return listOfBanks.isEmpty
                            ? Center(child: Text("No Records Found", style: textStyle14px500w))
                            : ListView.builder(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                itemCount: tempListOfOpportunity.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String bookingId = e.bookingId ?? "";
                                  BankDataList data = mapOfOpportunityIdAndReceipts[bookingId]![index];
                                  return cardViewBankDetail(data);
                                },
                              );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
                  ],
                ),
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
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      isScrollable: _tabController.length > 2,
      onTap: (int index) async {
        bookingId = listOfBooking[index].bookingId ?? "";
        print("booking id of selected tab is ${bookingId}");
        getBankDetail(bookingId);
        mapOfOpportunityIdAndReceipts[bookingId] = listOfBanks;
        setState(() {});
        listOfBanks.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}"))],
    );
  }

  Column cardViewBankDetail(BankDataList e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${e.accountType}", style: textStylePrimary18px600w),
        verticalSpace(4.0),
        Text("Account Information", style: textStyle14px600w),
        verticalSpace(2.0),
        Text("\u2022 Bank Name: ${e.bankName}", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("\u2022 Account Name: ${e.accountHolderName}", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("\u2022 Account Number: ${e.accountNumber}", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("\u2022 IFSC Code: ${e.iFSCCode}", style: textStyle14px500w),
        verticalSpace(25.0),
        line(),
        verticalSpace(25.0),
      ],
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  void getBankDetail(String bookingId) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }
    //check network
    if (!await NetworkCheck.check()) return;
    var body = {"bookingId": bookingId};
    // Dialogs.showLoader(context, "Fetching Bank detail ...");
    apiController.post(EndPoints.POST_BANK_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader();
        listOfBanks.clear();

        QuickPayResponse quickPayResponse = QuickPayResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          listOfBanks.addAll(quickPayResponse.bankDataList ?? []);
        } else {
          if (headerTextController.value == Screens.kQuickPayScreen) {
            if (quickPayResponse.message != 'No Bank records found') onError(quickPayResponse.message ?? "Failed");
          }
        }
        setState(() {});
      })
      ..catchError((e) {
        // Dialogs.hideLoader();
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void update() {
    getBankDetail(bookingId);
  }
}

/*
{
    "returnCode": true,
    "message": "Success",
    "bookingList": [
        {
            "Unit": "105",
            "Tower": "Tower 1",
            "TopScreenImage": "",
            "Project": "KRC"
        }
    ]
}


 */
