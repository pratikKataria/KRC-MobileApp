import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/model/billing_detail_response.dart';
import 'package:krc/ui/booking/model/booking_detail_response.dart' as bookingDetail;
import 'package:krc/ui/booking/model/download_billing_detail_response.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:krc/user/login_response.dart' as login;
import '../../user/AuthUser.dart';
import 'model/booking_response.dart';

class BookingDetailScreen extends StatefulWidget {
  BookingDetailScreen({Key? key}) : super(key: key) {
    // this.bookingDetailResponse = response;
    // bookingDetailResponseList.clear();
    // bookingDetailResponse.responselist!.forEach((element) {
    //   if (element.value != null && !element.value!.contains("null")) bookingDetailResponseList.add(element);
    // });
  }

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen>  with TickerProviderStateMixin{
  late TabController _tabController = TabController(length: 0, vsync: this);
  List<Responselist>bookingDetailResponse = [];
  List<login.BookingList> listOfBooking = [];
  Map<String, List<Responselist>> mapOfOpportunityIdAndReceipts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      if (listOfBooking.isNotEmpty) getBookingDetails(listOfBooking.first.bookingId ?? '');
      mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = bookingDetailResponse;
      setState(() {});
    });
  }

  // Project ,unit no, address ,tower booking id
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( bottom: false,
        child: Column(
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(20.0),
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
                    return  Column(
                      children: [
                        Center(
                          child: Container(
                            color: AppColors.bookingDetailCardBg,
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(Assets.imagesIcInfo, height: 24.0),
                                Text("Apartment Information", style: textStyle14px500w),
                                Text("The following are the property information", style: textStyleSubText12px500w),
                                verticalSpace(20.0),
                                Wrap(
                                  runAlignment: WrapAlignment.spaceBetween,
                                  runSpacing: 20.0,
                                  spacing: 20.0,
                                  children: [
                                    bookingDetailItem(Assets.imagesIcBuildingNo, "Building No.", "${bookingDetailResponse[0].buildingNo}".notNull),
                                    bookingDetailItem(Assets.imagesIcFloorNo, "Floor No", "${bookingDetailResponse[0].floorNo}".notNull),
                                    bookingDetailItem(Assets.imagesIcBuildingNo, "Apartment No", "${bookingDetailResponse[0].apartmentNo}".notNull),
                                    bookingDetailItem(Assets.imagesIcApartmentType, "Apartment Type", "${bookingDetailResponse[0].apartmentType}".notNull),
                                    bookingDetailItem(Assets.imagesIcParking, "Type of Parking", "${bookingDetailResponse[0].typeOfParking}".notNull),
                                    bookingDetailItem(Assets.imagesIcCarpet, "RERA Carpet Area", "${bookingDetailResponse[0].rERACarpetArea}".notNull),
                                    bookingDetailItem(Assets.imagesIcArea, "Number of Parking Spaces", "${bookingDetailResponse[0].numberOfParkingSpaces}".notNull),
                                    bookingDetailItem(Assets.imagesIcSecurityAmount, "Agreement Value", "${bookingDetailResponse[0].agreementValue}".notNull),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(20.0),
                        Container(
                          color: AppColors.bookingDetailCardBg,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Get Billing Details View", style: textStyle14px500w),
                                    Text("Know about all the billing related to your properties", style: textStyleSubText12px500w),
                                    verticalSpace(8.0),
                                    PmlButton(width: 97.0, height: 32.0, text: "View Detail", textStyle: textStyleWhite12px500w)
                                        .onClick(() => getBillingDetailView(e.bookingId ?? ''))
                                  ],
                                ),
                              ),
                              Image.asset(Assets.imagesIcInvoiceDetail, height: 84.0)
                            ],
                          ),
                        ),
                      ],
                    );
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
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      onTap: (int index) async {
        String bookingId = listOfBooking[index].bookingId ?? "";
        getBookingDetails(bookingId);
        mapOfOpportunityIdAndReceipts[bookingId] = bookingDetailResponse;
        setState(() {});
        bookingDetailResponse.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}-${e.tower}\n${e.project}"))],
    );
  }
  Row bookingDetailItem(String image, title, value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(image, height: 32.0),
        horizontalSpace(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: textStyleSubText14px500w),
            Text(value, style: textStyle14px500w),
          ],
        ),
      ],
    );
  }

  List<RichText> textBuilder(Map<String, dynamic> response) {
    List<RichText> richTextList = [];
    for (String key in response.keys) {
      if (response[key] == null) continue;

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
    return richTextList;
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  void getBookingDetails(String bookingId) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"bookingId": bookingId};

    Dialogs.showLoader(context, "Getting booking details ...");
    apiController.post(EndPoints.POST_BOOKING_DETAIL, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        BookingResponse quickPayResponse = BookingResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          setState(() {
            // listOfBanks.addAll(quickPayResponse.upcomingProjecList ?? []);
            List<Responselist> list = quickPayResponse.responselist ?? [];
            if (list.isNotEmpty) {
              bookingDetailResponse = list;
            }
          });
        } else {
          onError(quickPayResponse.message ?? "Failed");
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void getBillingDetailView(String bookingId) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"bookingId": bookingId, "generateBookingDetails": true};

    Dialogs.showLoader(context, "Getting billing details ...");
    apiController.post(EndPoints.POST_GENERATE_BOOKING_DETAIL, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        BillingDetailResponse quickPayResponse = BillingDetailResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          downloadBillingDetails(bookingId);
        } else {
          onError(quickPayResponse.message ?? "Failed");
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }

  void downloadBillingDetails(String bookingId) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"LinkedEntityId": bookingId, "FileName": "ViewBookingDetails"};

    apiController.post(EndPoints.POST_DOWNLOAD_BOOKING_DETAIL, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        DownloadBillingDetailResponse quickPayResponse = DownloadBillingDetailResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          Utility.launchUrlX(context, quickPayResponse.downloadlink);
        } else {
          onError(quickPayResponse.message ?? "Failed");
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }
}

/*


 Column(
          children: [
            Header("Booking detail"),
            verticalSpace(20.0),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.white),
                      children: [
                        TableRow(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black,
                              child: Text("Items", style: textStyleWhite12px700w),
                            ),
                            Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Values", style: textStyleWhite12px700w),
                            ),
                          ],
                        ),
                        ...bookingDetailResponseList
                            .map((e) => TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e.fieldname}", style: textStyleWhite12px700w),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e.value}", style: textStyleWhite12px700w),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20.0),
            //     child: ListView(
            //       children: [
            //         Text("${bookingDetailResponse?.tower}", style: textStyleWhite20px600w),
            //         verticalSpace(10.0),
            //         ...textBuilder(bookingDetailResponse.toJsonX()),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),


*/
