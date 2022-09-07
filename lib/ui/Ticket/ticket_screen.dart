import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/ticket_category_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart';
import 'package:krc/ui/Ticket/ticket_presenter.dart';
import 'package:krc/ui/Ticket/ticket_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list_v2.dart';
import 'package:krc/widgets/pml_button.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with SingleTickerProviderStateMixin implements TicketView {
  AnimationController menuAnimController;
  TabController _tabController;
  TicketPresenter _presenter;
  TextEditingController _textEditingController = TextEditingController();
  List<ResponseList> openTickets = [];
  List<ResponseList> closedTickets = [];

  List<String> category = [""];
  List<String> subCategory = [""];
  ValueNotifier<List<String>> valueNotifier = ValueNotifier([""]);
  String val2;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _presenter = TicketPresenter(this);
    _presenter.getTickets(context);
    _presenter.getTicketCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab(),
      body: SafeArea(
        child: Column(
          children: [
            Header("Ticket"),
            buildTabs(),
            verticalSpace(20.0),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  KRCListViewV2(
                    children: openTickets.map<Widget>((e) => cardViewTicket(e)).toList(),
                  ),
                  KRCListViewV2(
                    children: closedTickets.map<Widget>((e) => cardViewTicket(e)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PmlButton fab() {
    return PmlButton(
      width: 105.0,
      onTap: () {
        _modalBottomSheetMenu();
      },
      child: Row(
        children: [
          horizontalSpace(20.0),
          Image.asset(Images.kIconAdd, width: 15.0),
          horizontalSpace(5.0),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("Ticket", style: textStyleWhite18px600w),
          ),
        ],
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.colorPrimary,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyleDark14px500w,
      unselectedLabelColor: AppColors.white,
      labelColor: AppColors.white,
      onTap: (int index) {
        setState(() {});
      },
      tabs: [
        Tab(
          text: "OPEN",
        ),
        Tab(
          text: "CLOSE",
        ),
      ],
    );
  }

  cardViewTicket(ResponseList e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("#${e?.caseNumber}", style: textStyleWhite16px600w),
        Text("${e?.description}", style: textStyleWhite14px700w),
        Text("Category: ${e?.category ?? "Not Available"}", style: textStyleWhite14px700w),
        Text("Sub Category: ${e?.subCategory ?? "Not Available"}", style: textStyleWhite14px700w),
        verticalSpace(10.0),
        // Container(
        //   padding: EdgeInsets.all(8),
        //   color: AppColors.white.withOpacity(0.06),
        //   child: Text(e.status, style: textStyleWhite14px600w),
        // ),
      ],
    );
  }

  StateSetter setter;

  _modalBottomSheetMenu() {
    clearTicketDesc();
    String val = category.isEmpty ? "" : category.first;
    val2 = subCategory.isEmpty ? "" : subCategory.first;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    setter = setState;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      color: AppColors.cardColorDark2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create Ticket", style: textStyleWhite20px600w),
                          verticalSpace(20.0),
                          emailField(),
                          verticalSpace(20.0),
                          Text("Select Category", style: textStyleWhite14px500w),
                          verticalSpace(6.0),
                          Container(
                            color: AppColors.inputFieldBackgroundColor,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropdownButton<String>(
                              value: val,
                              style: textStyleWhite16px600w,
                              dropdownColor: AppColors.inputFieldBackgroundColor,
                              items: category.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {
                                val = _;
                                _presenter.getTicketSubCategoryWithLoader(context, val);
                                setState(() {});
                              },
                            ),
                          ),

                          //select sub category
                          verticalSpace(20.0),
                          Text("Select Sub Category", style: textStyleWhite14px500w),
                          verticalSpace(6.0),

                          if (subCategory?.isNotEmpty)
                            ValueListenableBuilder<List<String>>(
                                valueListenable: valueNotifier,
                                builder: (context, snapshot, child) {
                                  print(val2);
                                  return Container(
                                    color: AppColors.inputFieldBackgroundColor,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: DropdownButton<String>(
                                      value: val2,
                                      style: textStyleWhite16px600w,
                                      dropdownColor: AppColors.inputFieldBackgroundColor,
                                      items: snapshot.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        val2 = _;
                                        // _presenter.getTicketSubCategoryWithLoader(context, val);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                }),
                          verticalSpace(20.0),
                          PmlButton(
                            onTap: () {
                              _presenter.createTickets(context, _textEditingController.text.toString(), val, val2);
                            },
                            text: "Create Ticket",
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  Container emailField() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        // borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("DESC", style: textStyleSubText14px500w),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: _textEditingController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: textStyleSubText14px500w,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "type description here ...",
                hintStyle: textStyleSubText14px500w,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onTicketFetched(TicketResponse rmDetailResponse) {
    openTickets.clear();
    closedTickets.clear();
    rmDetailResponse.responseList.forEach((items) {
      if (items.status == "open") {
        openTickets.add(items);
      } else {
        closedTickets.add(items);
      }
    });
    setState(() {});
  }

  @override
  void onTicketCreated(CreateTicketResponse rmDetailResponse) {
    Navigator.pop(context); // close pop up
    Utility.showSuccessToastB(context, "Ticket Created");
    _presenter.getTicketsWithoutLoader(context);
    clearTicketDesc();
    setState(() {});
  }

  void clearTicketDesc() {
    _textEditingController.clear();
  }

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    category.clear();
    if (rmDetailResponse?.values?.isNotEmpty ?? false) category.addAll(rmDetailResponse?.values?.split(","));
    if (category.isNotEmpty) {
      category.removeLast();

      String cat = category.first;
      _presenter.getTicketSubCategory(context, cat);
    }
    setState(() {});
  }

  @override
  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    subCategory.clear();
    if (rmDetailResponse?.values?.isNotEmpty ?? false) subCategory.addAll(rmDetailResponse?.values?.split(","));
    if (subCategory.isNotEmpty) {
      subCategory.removeLast();
      val2 = subCategory.first;
      valueNotifier.value.clear();
      valueNotifier.value.addAll(subCategory);
      valueNotifier.notifyListeners();
    }
    setState(() {});
  }
}
