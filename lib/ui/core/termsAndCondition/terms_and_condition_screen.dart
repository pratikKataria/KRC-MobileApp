import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/core/core_presenter.dart';
import 'package:krc/ui/core/termsAndCondition/model/terms_and_condition_response.dart';
import 'package:krc/ui/core/termsAndCondition/terms_and_condition_view.dart';
import 'package:krc/utils/Utility.dart';

class TermsAndConditionScreen extends StatefulWidget {
  TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  _TermsAndConditionScreenState createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> implements TermsAndConditionView {
  String? termsAndConditionText = "";

  @override
  void initState() {
    super.initState();
    CorePresenter corePresenter = CorePresenter(this);
    corePresenter.getTermsAndConditions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              verticalSpace(8.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Text(
                      "${termsAndConditionText?.replaceAll("<p>", "")?.replaceAll("</p>", "")}",
                      style: textStyle14px500w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onTermsAndConditionFetched(TermsAndConditionResponse response) {
    termsAndConditionText = response.termsAndCondition;
    setState(() {});
  }
}
