import 'package:krc/ui/env/environment_values.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static final String BASE_URL = EnvironmentValues.getBaseURL;
  static final String ACCESS_TOKEN = EnvironmentValues.getAccessTokenURL;

  /*Prod*/
  static final String SEND_EMAIL_OTP = BASE_URL + "/SendEmailOTP";
  static final String GET_TERMS_CONDITIONS = BASE_URL + "/TermsAndConditions";
  static final String VERIFY_EMAIL_OTP = BASE_URL + "/EmailLogin";
}
