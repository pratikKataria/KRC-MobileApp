import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/faq/faq_view.dart';
import 'package:krc/ui/faq/model/question_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class FAQPresenter extends BasePresenter {
  FAQView _v;

  FAQPresenter(this._v) : super(_v);

  void getQuestions(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    Dialogs.showLoader(context, "Getting Your Queries ...");
    apiController.post(EndPoints.GET_QUESTIONS, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        QuestionResponse questionResponse = QuestionResponse.fromJson(response.data);
        // if (constructionImageResponse.returnCode) {
        _v.onQuestionFaq(questionResponse);
        // } else {
        //   _v.onError(constructionImageResponse.message);
        // }
        return;
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }
}
