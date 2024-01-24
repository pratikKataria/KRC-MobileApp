import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';

import 'loyal_reference_presenter.dart';
import 'loyalty_reference_view.dart';
import 'model/all_lead_response.dart';
import 'model/loyal_reference_request.dart';
import 'model/loyalty_reference_response.dart';
import 'model/picklist_value_Response.dart';

class LoyaltyReferenceDetailScreen extends StatefulWidget {
  String accountId;

  LoyaltyReferenceDetailScreen(this.accountId, {Key? key}) : super(key: key);

  @override
  State<LoyaltyReferenceDetailScreen> createState() => _LoyaltyReferenceDetailScreenState();
}

class _LoyaltyReferenceDetailScreenState extends State<LoyaltyReferenceDetailScreen> implements LoyaltyReferenceView {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();

  List<String> projectList = [];
  List<String> typologyList = [];
  List<String> salutationList = ["Mr", "Mrs", "Ms"];

  LoyaltyReferenceRequest loyaltyReferenceRequest = LoyaltyReferenceRequest();

  late LoyalReferencePresenter presenter;

  @override
  void initState() {
    super.initState();
    loyaltyReferenceRequest.salutation = salutationList.first;
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration(milliseconds: 200));
    presenter = LoyalReferencePresenter(this);
    presenter.getPickList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    Text("Salutation", style: textStyle14px600w),
                    verticalSpace(5.0),
                    Wrap(
                      runSpacing: 10.0,
                      spacing: 10.0,
                      children: [
                        ...salutationList
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.all(8.0),
                                color: selectedColor(e == loyaltyReferenceRequest.salutation),
                                child: Text(e, style: selectedTextStyle(e == loyaltyReferenceRequest.salutation)),
                              ).onClick(() => setState(() => loyaltyReferenceRequest.salutation = e)),
                            )
                            .toList()
                      ],
                    ),

                    verticalSpace(20.0),

                    //name layout
                    inputTextField("First Name", firstNameTextController),
                    inputTextField("Last Name", lastNameTextController),
                    inputTextField("Mobile", mobileTextController, inputTypeNumber: true),
                    inputTextField("Email", emailTextController),

                    Text("Project", style: textStyle14px600w),
                    verticalSpace(5.0),
                    Wrap(
                      runSpacing: 10.0,
                      spacing: 10.0,
                      children: [
                        ...projectList
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(bottom: 8.0),
                                color: selectedColor(e == loyaltyReferenceRequest.project),
                                child: Text(e, style: selectedTextStyle(e == loyaltyReferenceRequest.project)),
                              ).onClick(() => setState(() => loyaltyReferenceRequest.project = e)),
                            )
                            .toList()
                      ],
                    ),

                    verticalSpace(20.0),

                    Text("Typology", style: textStyle14px600w),
                    verticalSpace(5.0),
                    Wrap(
                      runSpacing: 10.0,
                      spacing: 10.0,
                      children: [
                        ...typologyList
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.all(8.0),
                                color: selectedColor(e == loyaltyReferenceRequest.typology),
                                child: Text(e, style: selectedTextStyle(e == loyaltyReferenceRequest.typology)),
                              ).onClick(() => setState(() => loyaltyReferenceRequest.typology = e)),
                            )
                            .toList()
                      ],
                    ),

                    //Login button
                    Container(
                      height: 35.0,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      color: AppColors.colorPrimary,
                      child: Center(child: Text("Submit", style: textStyleWhite14px600w)),
                    ).onClick(() {
                      FocusScope.of(context).unfocus();

                      loyaltyReferenceRequest.firstName = firstNameTextController.text.toString();
                      loyaltyReferenceRequest.lastName = lastNameTextController.text.toString();
                      loyaltyReferenceRequest.mobile = mobileTextController.text.toString();
                      loyaltyReferenceRequest.email = emailTextController.text.toString();

                      presenter.createLead(context, loyaltyReferenceRequest, widget.accountId);
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

  Container inputTextField(String title, TextEditingController controller, {bool inputTypeNumber = false}) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 20.0),
      color: AppColors.inputFieldBackgroundColor2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$title ", style: textStyle14px600w),
          horizontalSpace(10.0),
          Expanded(
            child: inputTextFormField(
              controller: controller,
              inputTypeNumber: inputTypeNumber,
              placeHolderText: "",
            ),
          ),
        ],
      ),
    );
  }

  TextFormField inputTextFormField({TextEditingController? controller, String? placeHolderText, bool inputTypeNumber = false}) {
    return TextFormField(
      // obscureText: true,
      textAlign: TextAlign.left,
      controller: controller,
      maxLines: 1,
      inputFormatters: [inputTypeNumber ? LengthLimitingTextInputFormatter(10) : LengthLimitingTextInputFormatter(256)],
      textCapitalization: TextCapitalization.none,
      keyboardType: inputTypeNumber ? TextInputType.number : TextInputType.emailAddress,
      style: textStyleSubText14px500w,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: placeHolderText,
        hintStyle: textStyleSubText14px500w,
        isDense: true,
        suffixStyle: TextStyle(color: AppColors.textColor),
      ),
    );
  }

  @override
  void onClientRefered(LoyaltyReferenceResponse loyaltyReferenceResponse) {
    Utility.showToastB(context, "Lead created successfully");
    Navigator.pop(context);
    headerTextController.value = Screens.kLoyaltyReferenceScreen; // close pop up
  }

  @override
  void onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onPickListValueFetched(List<PicklistValueResponse> list) {
    projectList.clear();
    typologyList.clear();
    if (list.isNotEmpty) {
      List<String> projectValues = list.first.values?.split(",") ?? [];
      if (projectValues.isNotEmpty) projectValues.removeLast();
      projectList.addAll(projectValues);

      List<String> typologyValues = list[1].values?.split(",") ?? [];
      if (typologyValues.isNotEmpty) typologyValues.removeLast();
      typologyList.addAll(typologyValues);
    }

    setState(() {});
  }

  selectedTextStyle(bool value) => value ? textStyleWhite14px600w : textStyle14px500w;

  selectedColor(bool value) => value ? AppColors.colorPrimary : AppColors.applicantsCardBackground;

  @override
  void onAllLeadFetched(AllLeadResponse response) {}
}
