import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/faq/model/question_response.dart';

abstract class FAQView extends BaseView {
  void onQuestionFaq(QuestionResponse questionResponse);
}
