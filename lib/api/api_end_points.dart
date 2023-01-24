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
  static final String GET_BOOKING_LIST = BASE_URL + "/HomeScreen";

  static final String POST_UPLOAD_PROFILE_PIC = BASE_URL + "/ProfilePic";
  static final String VERIFY_EMAIL_OTP = BASE_URL + "/EmailLogin";
  static final String VERIFY_MOBILE = BASE_URL + "/MobileLogin";
  static final String POST_CREATE_TICKET = BASE_URL + "/myTicket";
  static final String POST_TDS_DOC = BASE_URL + "/TdsUpload";
  static final String POST_DOCUMENT_CENTER = BASE_URL + "/myDocumentCenter";
  static final String POST_READ_NOTIFICATION = BASE_URL + "/NotificationMarkRead";
  static final String POST_CATEGORY = BASE_URL + "/MyticketAllCategory";
  static final String POST_SUB_CATEGORY = BASE_URL + "/myTicketSubCategory";
  static final String POST_BANK_DETAILS = BASE_URL + "/BankDetails";
  static final String POST_ONGOING_PROJECT = BASE_URL + "/UpcomingProjects";
  static final String POST_BOOKING_DETAIL = BASE_URL + "/RestBookingDetails";
  static final String POST_REOPEN_TICKET = BASE_URL + "/ReopenTicket";
  static final String POST_GENERATE_BOOKING_DETAIL = BASE_URL + "/GenerateBookingDetails";
  static final String POST_DOWNLOAD_BOOKING_DETAIL = BASE_URL + "/Download";
  static final String LEAD_MOBILE_APP = BASE_URL + "/createReferralLead";
  static final String PICKLIST_VALUE = BASE_URL + "/pickListValues";
  static final String ALL_REFERRALS = BASE_URL + "/list_of_Referral_Leads";
  static final String IMAGE_AND_LOGO = BASE_URL + "/ImageAndLogo";
  static final String POST_DEVICE_TOKEN = BASE_URL + "/DeviceToken";

}
