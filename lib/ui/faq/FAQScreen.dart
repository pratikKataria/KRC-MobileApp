import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/faq/faq_view.dart';
import 'package:krc/ui/faq/model/question_response.dart';
import 'package:krc/utils/Utility.dart';

import 'faq_presenter.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> implements FAQView {
  late FAQPresenter faqPresenter;
  List<Rp> questionList = [];

  @override
  void initState() {
    super.initState();
    faqPresenter = FAQPresenter(this);
    // faqPresenter.getQuestions(context);

    questionList.add(Rp.fromJson({
      "returnCode": true,
      "question": "<p>What is Tds on Property?</p>",
      "message": "success",
      "answer": "<p>TDS has to be paid on the property by the owner, equivalent to 1 percent of the total unit cost. </p>"
    }));

    questionList.add(Rp.fromJson({
      "returnCode": true,
      "question": "<p>What is Tds on Property?</p>",
      "message": "success",
      "answer": "<p>TDS has to be paid on the property by the owner, equivalent to 1 percent of the total unit cost. </p>"
    }));

    questionList.add(Rp.fromJson({
      "returnCode": true,
      "question": "<p>What is Tds on Property?</p>",
      "message": "success",
      "answer": "<p>TDS has to be paid on the property by the owner, equivalent to 1 percent of the total unit cost. </p>"
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                children: questionList.map((e) => createQuestionCardView(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column createQuestionCardView(Rp e) {
    return Column(
      children: [
        ExpandablePanel(
          theme: ExpandableThemeData(iconColor: AppColors.black, headerAlignment: ExpandablePanelHeaderAlignment.top),
          header: Row(
            children: [
              Text("Q1.", style: textStylePrimary14px500w),
              horizontalSpace(10.0),
              Expanded(child: Text('${e?.question?.replaceAll("<p>", "")?.replaceAll("</p>", "")}', style: textStyle14px500w)),
            ],
          ),
          expanded: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ans.", style: textStylePrimary14px500w),
              horizontalSpace(10.0),
              Expanded(
                child: Text(
                  '${e.answer?.replaceAll("<p>", "")?.replaceAll("</p>", "")}',
                  softWrap: true,
                  style: textStyleSubText14px500w,
                ),
              ),
            ],
          ),
          collapsed: Container(),
        ),
        verticalSpace(10.0),
        line(),
        verticalSpace(20.0),
      ],
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onQuestionFaq(QuestionResponse questionResponse) {
    questionList.addAll(questionResponse.rp!);
    setState(() {});
  }
}
