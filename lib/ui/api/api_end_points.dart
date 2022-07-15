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
  static final String GET_CONSTRUCTION_IMAGES = BASE_URL + "/constructionImages";
  static final String GET_QUESTIONS = BASE_URL + "/FAQ";
  static final String GET_RM_DETAILS = BASE_URL + "/RMDetails";
  static final String GET_TICKETS = BASE_URL + "/DisplayMytickets";
  static final String GET_BOOKING = BASE_URL + "/RestBookingDetails";
  static final String GET_RECEIPTS = BASE_URL + "/MyReceipts";
  static final String GET_DEMANDS = BASE_URL + "/myDemands";
  static final String GET_NOTIFICATIONS = BASE_URL + "/NotificationList";
  static final String GET_BOOKING_DETAILS = BASE_URL + "/moreButtonMyBooking";

  static final String POST_UPLOAD_PROFILE_PIC = BASE_URL + "/ProfilePic";
  static final String VERIFY_EMAIL_OTP = BASE_URL + "/EmailLogin";
  static final String VERIFY_MOBILE = BASE_URL + "/MobileLogin";
  static final String POST_CREATE_TICKET = BASE_URL + "/myTicket";
  static final String POST_TDS_DOC = BASE_URL + "/TdsUpload";
  static final String POST_DOCUMENT_CENTER = BASE_URL + "/myDocumentCenter";
  static final String POST_READ_NOTIFICATION = BASE_URL + "/NotificationMarkRead";

}
