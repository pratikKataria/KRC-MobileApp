import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with SingleTickerProviderStateMixin {
  AnimationController menuAnimController;
  List list = ["", "", ""];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  KRCListView(
                    children: list.map<Widget>((e) => cardViewTicket()).toList(),
                  ),
                  KRCListView(
                    children: list.map<Widget>((e) => cardViewTicket()).toList(),
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

  cardViewTicket() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("#T1201", style: textStyleWhite16px600w),
        Text("Property details not updated ", style: textStyleWhite16px600w),
        verticalSpace(10.0),
        Container(
          padding: EdgeInsets.all(8),
          color: AppColors.white.withOpacity(0.06),
          child: Text("In-progress", style: textStyleWhite16px600w),
        ),
      ],
    );
  }

  _modalBottomSheetMenu() {
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
                    Text("Create Ticket", style: textStyleWhiteHeavy24px),
                    verticalSpace(30.0),
                    emailField(),
                    verticalSpace(20.0),
                    Text("Select Category", style: textStyleWhite14px500w),
                    verticalSpace(6.0),
                    Container(
                      color: AppColors.inputFieldBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DropdownButton<String>(
                        value: 'A',
                        style: textStyleWhite16px600w,
                        dropdownColor: AppColors.inputFieldBackgroundColor,
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                    verticalSpace(20.0),
                    PmlButton(
                      onTap: () {},
                      text: "Create Ticket",
                    )
                  ],
                ),
              ),
            ],
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
              // controller: emailTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: textStyleSubText14px500w,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "type description here ...",
                hintStyle: textStyleSubText14px500w,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }
}
