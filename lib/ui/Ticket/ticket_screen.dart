import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/Ticket/create_new_ticket.dart';
import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/reopen_response.dart';
import 'package:krc/ui/Ticket/model/ticket_category_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart' as tr;
import 'package:krc/ui/Ticket/ticket_presenter.dart';
import 'package:krc/ui/Ticket/ticket_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/krc_list_v2.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:krc/user/login_response.dart' as login;

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with TickerProviderStateMixin implements TicketView {
  late TabController _tabController = TabController(length: 0, vsync: this);

  AnimationController? menuAnimController;
  late TicketPresenter _presenter;
  TextEditingController _textEditingController = TextEditingController();
  List<tr.ResponseList> allTickets = [];
  List<tr.ResponseList> openTickets = [];
  List<tr.ResponseList> closedTickets = [];

  List<String> category = [""];
  List<String> subCategory = [""];
  ValueNotifier<List<String>> valueNotifier = ValueNotifier([""]);
  String? val2;
  String bookingId = '';
  List<login.BookingList> listOfBooking = [];

  // Map<String, List<tr.ResponseList>> mapOfOpportunityIdAndReceipts = {};
  String selectedValue = 'All'; // Initial selected value
  // List of dropdown options
  List<String> dropdownItems = ['All', 'Open', 'Closed'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      _presenter = TicketPresenter(this);
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      // mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = _receiptList;
      setState(() {});
      headerTextController.addListener(() {
        if (headerTextController.value == Screens.kTicketsScreen) {
          if (listOfBooking.isNotEmpty) {
            bookingId = listOfBooking.first.bookingId ?? '';
            _presenter.getTickets(context, listOfBooking.first.bookingId ?? '');
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewTicket(bookingId)));
          _presenter.getTicketsWithoutLoader(context, bookingId);
        },
        backgroundColor: AppColors.colorPrimary,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(10.0),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.textColorSubText,
                  ),
                  horizontalSpace(10),
                  DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                      print('the value is ${selectedValue.toString().toLowerCase()}');
                      _presenter.getTickets(context, bookingId);
                      setState(() {});
                    },
                    items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            verticalSpace(10.0),
            Column(
              children: [
                if (selectedValue.toString().toLowerCase() == "open") openTicketsBuilder(),
                if (selectedValue.toString().toLowerCase() == "closed") closeTicketsBuilder(),
                if (selectedValue.toString().toLowerCase() == "all") allTicketsBuilder(),
              ],
            ),
            // IndexedStack(
            //   index: _tabController.index,
            //   children: [
            //
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget openTicketsBuilder() {
    return Column(
      children: [
        ...[
          if (openTickets.isEmpty) Container(margin: EdgeInsets.only(top: 250.0), child: Center(child: Text("No Tickets Yet", style: textStyle14px500w))),
          if (openTickets.isNotEmpty)
            ...openTickets.map((e) {
              return cardViewTicket(e) ?? Container();
            }).toList(),
        ],
      ],
    );
  }

  Widget closeTicketsBuilder() {
    return Column(
      children: [
        ...[
          if (closedTickets.isEmpty) Container(margin: EdgeInsets.only(top: 250.0), child: Center(child: Text("No Tickets Yet", style: textStyle14px500w))),
          if (closedTickets.isNotEmpty)
            ...closedTickets.map((e) {
              return cardViewTicketClosed(e) ?? Container();
            }).toList(),
        ],
      ],
    );
  }

  Widget allTicketsBuilder() {
    return Column(
      children: [
        ...[
          if (allTickets.isEmpty) Container(margin: EdgeInsets.only(top: 250.0), child: Center(child: Text("No Tickets Yet", style: textStyle14px500w))),
          if (allTickets.isNotEmpty)
            ...allTickets.map((e) {
              return e.status.toString().toLowerCase() == "open" ? cardViewTicket(e) ?? Container() : cardViewTicketClosed(e) ?? Container();
            }).toList(),
        ],
      ],
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
      dividerHeight: 0,
      indicatorColor: AppColors.colorPrimary,
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      isScrollable: _tabController.length > 2,
      onTap: (int index) async {
        bookingId = listOfBooking[index].bookingId ?? "";
        print("booking id of selected tab is $bookingId");
        openTickets.clear();
        closedTickets.clear();
        allTickets.clear();
        _presenter.getTickets(context, bookingId);
        // mapOfOpportunityIdAndReceipts[bookingId] = _receiptList;
        setState(() {});
        // _receiptList.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}"))],
    );
  }

  cardViewTicket(tr.ResponseList e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIcTicket))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.imagesIcTicket), fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${e.subCategory ?? "Not Present"} (#${e.caseNumber})", style: textStyle12px500w),
                  Text("${e.description}".notNull, style: textStylePrimary12px500w),
                  Container(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0), color: AppColors.textColorSubText, child: Text("${e?.category}".notNull, style: textStyleWhite12px500w)),
                  line(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Created On", style: textStyleBlack10px500w),
                          Text(" ${e.dateData}".notNull, style: textStylePrimary10px500w),
                        ],
                      ),
                      Row(
                        children: [
                          Text(" At", style: textStyleBlack10px500w),
                          Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                        ],
                      ),
                      Text(" | ${e.status}".notNull, style: textStylePrimary10px500w),
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   color: AppColors.white.withOpacity(0.06),
                  //   child: Text(e.status, style: textStyleWhite14px600w),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  cardViewTicketClosed(tr.ResponseList e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.imagesIcTicket), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${e?.subCategory ?? "Not Present"} (#${e?.caseNumber})", style: textStyle12px500w),
            Text("${e?.description}".notNull, style: textStylePrimary12px500w),
            Container(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0), color: AppColors.textColorSubText, child: Text("${e?.category}".notNull, style: textStyleWhite12px500w)),
            // Center(child: Text("Your ticket will be updated soon", style: textStyleSubText10px500w)),

            // Container(
            //   padding: EdgeInsets.all(8),
            //   color: AppColors.white.withOpacity(0.06),
            //   child: Text(e.status, style: textStyleWhite14px600w),
            // ),
            line(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Created On", style: textStyleBlack10px500w),
                        Text(" ${e.dateData}".notNull, style: textStylePrimary10px500w),
                      ],
                    ),
                    Row(
                      children: [
                        Text("At", style: textStyleBlack10px500w),
                        Text(" ${e.timeData}".notNull, style: textStylePrimary10px500w),
                      ],
                    ),
                  ],
                ),
                horizontalSpace(20.0),
                Image.asset(Assets.imagesIcReopen, height: 50).onClick(() {
                  FocusScope.of(context).unfocus();
                  reopenTicketDialog(context, e.recordID ?? "");
                })
              ],
            ),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   color: AppColors.white.withOpacity(0.06),
            //   child: Text(e.status, style: textStyleWhite14px600w),
            // ),
          ],
        ),
      ),
    );
  }

  StateSetter? setter;

  _modalBottomSheetMenu() {
    clearTicketDesc();
    String? val = category.isEmpty ? "" : category.first;
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
                          Text("Create Ticket", style: textStyle14px500w),
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

                          if (subCategory?.isNotEmpty ?? false)
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
                              // _presenter.createTickets(context, _textEditingController.text.toString(), val, val2);
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
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onTicketFetched(tr.TicketResponse rmDetailResponse) {
    openTickets.clear();
    closedTickets.clear();
    allTickets.clear();
    allTickets.addAll(rmDetailResponse.responseList!);
    rmDetailResponse.responseList!.forEach((items) {
      if (items.status.toString().toLowerCase() == "open") {
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
    _presenter.getTicketsWithoutLoader(context, bookingId);
    clearTicketDesc();
    setState(() {});
  }

  void clearTicketDesc() {
    _textEditingController.clear();
  }

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    category.clear();
    if (rmDetailResponse.values?.isNotEmpty ?? false) category.addAll(rmDetailResponse?.values?.split(",") ?? [""]);
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
    if (rmDetailResponse?.values?.isNotEmpty ?? false) subCategory.addAll(rmDetailResponse?.values?.split(",")?.toList() ?? [""]);
    if (subCategory.isNotEmpty) {
      subCategory.removeLast();
      val2 = subCategory.first;
      valueNotifier.value.clear();
      valueNotifier.value.addAll(subCategory);
      valueNotifier.notifyListeners();
    }
    setState(() {});
  }

  Future<bool> reopenTicketDialog(BuildContext context, String id) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            String reason = "";
            return StatefulBuilder(builder: (context, alertDialogState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 260.0,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Reason", style: textStyle14px500w),
                        verticalSpace(10.0),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(color: AppColors.textColorSubText.withOpacity(0.5))),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            style: textStyle14px500w,
                            decoration: new InputDecoration.collapsed(hintText: "Add reason here ..."),
                            onChanged: (v) {
                              reason = v;
                            },
                          ),
                        ),
                        verticalSpace(10.0),
                        Spacer(),
                        PmlButton(
                          text: "Reopen",
                          onTap: () {
                            if (reason.isNotEmpty) {
                              _presenter.reopenTicket(context, id, reason);
                            } else {
                              onError("Please enter reason");
                            }
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndC`onditionScreen()));
                            // Navigator.pushNamed(context, Screens.kHomeBase);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
          },
        ).then((value) => value as bool) ??
        false as Future<bool>;
  }

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {
    _presenter.getTicketsWithoutLoader(context, bookingId);
    Navigator.pop(context);
  }
}
