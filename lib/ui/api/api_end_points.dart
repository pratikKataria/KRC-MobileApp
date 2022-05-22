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
  static final String GET_PROFILE_DETAIL = BASE_URL + "/RestCustomerDetails";
  static final String GET_PROJECT_DETAIL = BASE_URL + "/ProjectDetails";
  static final String POST_UPLOAD_PROFILE_PIC = BASE_URL + "/ProfilePic";
  static final String VERIFY_EMAIL_OTP = BASE_URL + "/EmailLogin";
  static final String GET_CONSTRUCTION_IMAGES = BASE_URL + "/constructionImages";
}
