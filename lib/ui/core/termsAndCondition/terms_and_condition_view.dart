import 'package:krc/ui/core/core_view.dart';
import 'package:krc/ui/core/termsAndCondition/model/terms_and_condition_response.dart';
import 'package:krc/user/token_response.dart';

abstract class TermsAndConditionView extends CoreView {
  void onTermsAndConditionFetched(TermsAndConditionResponse termsAndConditionResponse);
}
