import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/loyaltyReference/loyalty_reference_detail_screen.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/name_icon.dart';
import 'package:krc/user/login_response.dart' as login;
import 'loyal_reference_presenter.dart';
import 'loyalty_reference_view.dart';
import 'model/all_lead_response.dart';
import 'model/loyalty_reference_response.dart';
import 'model/picklist_value_Response.dart';

class LoyaltyReferenceScreen extends StatefulWidget {
  const LoyaltyReferenceScreen({Key? key}) : super(key: key);

  @override
  State<LoyaltyReferenceScreen> createState() => _LoyaltyReferenceScreenState();
}

class _LoyaltyReferenceScreenState extends State<LoyaltyReferenceScreen> with TickerProviderStateMixin implements LoyaltyReferenceView {
  List<ReferenceLeadList> listOfAllLeads = [];
  String link = "";

  late TabController _tabController = TabController(length: 0, vsync: this);

  List<login.AccountList> listOfAccounts = [];
  Map<String, List<ReferenceLeadList>> mapOfOpportunityIdAndReceipts = {};
  late LoyalReferencePresenter presenter;
  String _accountId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      presenter = LoyalReferencePresenter(this);
      listOfAccounts.addAll((currentUser?.userCredentials?.accountList ?? []));
      _tabController = TabController(length: listOfAccounts.length, vsync: this);
      if (listOfAccounts.isNotEmpty) _accountId = listOfAccounts.first.accountID ?? '';
      if (listOfAccounts.isNotEmpty) mapOfOpportunityIdAndReceipts[listOfAccounts.first.accountID ?? ''] = listOfAllLeads;
      if (listOfAccounts.isNotEmpty) _accountId = listOfAccounts.first.accountID ?? '';
      if (listOfAccounts.isNotEmpty) presenter.getListOfReferrals(context, listOfAccounts.first.accountID ?? '');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(10.0),
            buildTabs(),
            verticalSpace(10.0),

            Expanded(
              child: ListView(
                children: [
                  if (listOfAllLeads.isEmpty) Container(margin: EdgeInsets.only(top: 250.0), child: Center(child: Text("No referrals yet.", style: textStyle14px500w))),
                  ...listOfAllLeads.map<Widget>((e) => cardViewLeads(e)).toList(),
                ],
              ),
            ),

            //Refer now button
            InkWell(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => LoyaltyReferenceDetailScreen(_accountId)));
                presenter.getListOfReferralsWithoutLoader(context, _accountId);
                headerTextController.value = Screens.kLoyaltyReferenceScreen; // close pop up
              },
              child: Container(
                height: 35.0,
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                color: AppColors.colorPrimary,
                child: Center(child: Text("Refer Now", style: textStyleWhite14px600w)),
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
        _accountId = listOfAccounts[index].accountID ?? "";
        print("account id of selected tab is ${_accountId}");
        presenter.getListOfReferrals(context, _accountId);
        mapOfOpportunityIdAndReceipts[_accountId] = listOfAllLeads;
        setState(() {});
        listOfAllLeads.clear();
      },
      tabs: [...listOfAccounts.map((e) => Tab(text: "${e.name}\n${e.mobile}"))],
    );
  }

  statusWidget(String? s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0))),
      child: Text("$s".notNull, style: textStyleWhite12px500w),
    );
  }

  Container indeterminantProgressWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      margin: EdgeInsets.only(top: 20.0),
      child: LinearProgressIndicator(
        backgroundColor: AppColors.colorPrimary,
        valueColor: AlwaysStoppedAnimation(AppColors.colorPrimaryLight),
        minHeight: 4.0,
      ),
    );
  }

  Container referenceRibbonWidget(BuildContext context) {
    return Container(
      height: 25.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: AppColors.colorPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("For more details, visit our app: Loyally App here", style: textStyleWhite12px600w), Icon(Icons.mobile_screen_share, color: Colors.white, size: 16.0)],
      ).onClick(() => Utility.launchUrlX(context, "$link")),
    );
  }

  cardViewLeads(ReferenceLeadList e) {
    return Container(
      color: Color(0xFFFBFAF9),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: NameIcon(firstName: "${e.name}".notNull),
          ),
          horizontalSpace(8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10.0),
                Text("${e.name}".notNull, style: textStyleSubText14px500w),
                verticalSpace(4.0),
                Text("${e.mobileNumber}".notNull, style: textStyleSubText14px500w),
                verticalSpace(4.0),
                Text("${e.email}".notNull, style: textStyleSubText14px500w),
                verticalSpace(4.0),
                Text("${e.projectInterested}  |  ${e.typology}", style: textStyle14px500w),
                verticalSpace(10.0),
              ],
            ),
          ),
          statusWidget(e.status),
        ],
      ),
    );
  }

  @override
  void onAllLeadFetched(AllLeadResponse response) {
    listOfAllLeads.clear();
    listOfAllLeads.addAll(response.referenceLeadList ?? []);
    setState(() {});
  }

  @override
  void onClientRefered(LoyaltyReferenceResponse loyaltyReferenceResponse) {}

  @override
  void onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onPickListValueFetched(List<PicklistValueResponse> list) {}
}
