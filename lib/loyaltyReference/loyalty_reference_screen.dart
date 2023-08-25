import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/name_icon.dart';

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

class _LoyaltyReferenceScreenState extends State<LoyaltyReferenceScreen> implements LoyaltyReferenceView {
  List<ReferenceLeadList> listOfAllLeads = [];
  String link = "";

  late LoyalReferencePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = LoyalReferencePresenter(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.getListOfReferrals(context);
      // presenter.getReferAppDetail(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(20.0),

            Expanded(
              child: ListView(
                children: [
                  //Display list of all leads
                  ...listOfAllLeads.map((e) => cardViewLeads(e)),

                  //Sample place holder image
                  verticalSpace(40.0),
                  if (listOfAllLeads.isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 250.0),
                      child: Center(child: Text("No referrals yet.", style: textStyle14px500w)),
                    ),
                ],
              ),
            ),

            //Refer now button
            InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, Screens.kReferFriendScreen);
                presenter.getListOfReferralsWithoutLoader(context);
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
        children: [
          Text("For more details, visit our app: Loyally App here", style: textStyleWhite12px600w),
          Icon(Icons.mobile_screen_share, color: Colors.white, size: 16.0)
        ],
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
