import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/document/model/document_response.dart' as DR;
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/krc_list_v2.dart';
import 'package:krc/user/login_response.dart' as login;

import 'document_presenter.dart';
import 'document_view.dart';
import 'model/booking_response.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> with TickerProviderStateMixin implements DocumentView {
  late TabController _tabController = TabController(length: 0, vsync: this);

  AnimationController? menuAnimController;

  late DocumentPresenter bookingPresenter;
  List<Responselist> bookingList = [];
  DR.DocumentResponse? bookingResponse;
  List<DR.DocResponselist> documentList = [];
  List<login.BookingList> listOfBooking = [];
  Map<String, List<DR.DocResponselist>> mapOfOpportunityIdAndReceipts = {};
  String bookingId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      bookingPresenter = DocumentPresenter(this);
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      if (listOfBooking.isNotEmpty) bookingPresenter.getDocumentsList(context, listOfBooking.first.bookingId ?? '');
      mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = documentList;
      bookingId = listOfBooking.first.bookingId ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(40.0),
            if (documentList.isEmpty) Container(margin: EdgeInsets.only(top: Utility.screenHeight(context) / 2.5), child: Center(child: Text("No Record Found", style: textStyle14px500w))),
            if (documentList.isNotEmpty)
              ...documentList.map(
                (e) => Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Assets.imagesIcPdf, height: 38),
                        horizontalSpace(20.0),
                        Expanded(child: Text("${e.fileName}", style: textStyle14px500w)),
                        horizontalSpace(20.0),
                        Image.asset(Assets.imagesIcDownload, height: 34).onClick(() {
                          Utility.launchUrlX(context, e.downloadlink);
                        }),
                      ],
                    ),
                    verticalSpace(25.0),
                    line(),
                    verticalSpace(25.0),
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
        bookingId = listOfBooking[index].bookingId ?? "";
        print("booking id of selected tab is ${bookingId}");
        bookingPresenter.getDocumentsList(context, bookingId);
        mapOfOpportunityIdAndReceipts[bookingId] = documentList;
        setState(() {});
        documentList.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}-${e.tower}\n${e.project}"))],
    );
  }

  cardViewBooking(Responselist responselist) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        bookingPresenter.getDocumentsList(context, bookingId);
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
                    Text("${documentResponse.tower}", style: textStylePrimary14px500w),
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
    // _modalBottomSheetMenu(bookingResponse);
    setState(() {});
  }
}

/*
         Header("Document"),
            verticalSpace(20.0),
            KRCListView(
              children: bookingList.map<Widget>((e) => cardViewBooking(e)).toList(),



*/
