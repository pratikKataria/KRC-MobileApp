import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/faq/faq_view.dart';
import 'package:krc/ui/faq/model/question_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';

import 'faq_presenter.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> implements FAQView {
  FAQPresenter faqPresenter;
  List<Rp> questionList = [];

  @override
  void initState() {
    super.initState();
    faqPresenter = FAQPresenter(this);
    faqPresenter.getQuestions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("FAQs"),
            verticalSpace(20.0),
            Expanded(
              child: KRCListView(
                padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                margin: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
                children: questionList.map((e) => createQuestionCardView(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ExpandablePanel createQuestionCardView(Rp e) {
    return ExpandablePanel(
      theme: ExpandableThemeData(iconColor: AppColors.white),
      header: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(Icons.help, color: AppColors.white),
            horizontalSpace(20.0),
            Expanded(
              child: Text(
                '${e?.question?.replaceAll("<p>", "")?.replaceAll("</p>", "")}',
                style: textStyleWhite14px600w,
              ),
            ),
          ],
        ),
      ),
      expanded: Text(
        '${e?.answer?.replaceAll("<p>", "")?.replaceAll("</p>", "")}',
        softWrap: true,
        style: textStyleWhite14px500w,
      ),
      collapsed: null,
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onQuestionFaq(QuestionResponse questionResponse) {
    questionList.addAll(questionResponse.rp);
    setState(() {});
  }
}
