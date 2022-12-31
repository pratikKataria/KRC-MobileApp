/// returnCode : true
/// ProfilePic : " sdf"
/// Phone : "8999928361"
/// Permanent_Address : "Pune, Pune, Maharashtra - 444441, India"
/// message : "SUCCESS"
/// Mailing_Address : "Pune, Pune, Maharashtra - 444441, India"
/// EmailID : "adityasingh.bisen@stetig.in"
/// customerCode : 111
/// Co_Applicant_3 : "Test Customer3"
/// Co_Applicant_2 : "Test Customer2"
/// Co_Applicant_1 : "Test Customer1"
/// AccountName : "AdityaSAPtestlogin"

class ProfileDetailResponse {
  ProfileDetailResponse({
      bool? returnCode, 
      String? profilePic, 
      String? phone, 
      String? permanentAddress, 
      String? message, 
      String? mailingAddress, 
      String? emailID, 
      num? customerCode, 
      String? coApplicant3, 
      String? coApplicant2, 
      String? coApplicant1, 
      String? accountName,}){
    _returnCode = returnCode;
    _profilePic = profilePic;
    _phone = phone;
    _permanentAddress = permanentAddress;
    _message = message;
    _mailingAddress = mailingAddress;
    _emailID = emailID;
    _customerCode = customerCode;
    _coApplicant3 = coApplicant3;
    _coApplicant2 = coApplicant2;
    _coApplicant1 = coApplicant1;
    _accountName = accountName;
}

  ProfileDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _profilePic = json['ProfilePic'];
    _phone = json['Phone'];
    _permanentAddress = json['Permanent_Address'];
    _message = json['message'];
    _mailingAddress = json['Mailing_Address'];
    _emailID = json['EmailID'];
    _customerCode = json['customerCode'];
    _coApplicant3 = json['Co_Applicant_3'];
    _coApplicant2 = json['Co_Applicant_2'];
    _coApplicant1 = json['Co_Applicant_1'];
    _accountName = json['AccountName'];
  }
  bool? _returnCode;
  String? _profilePic;
  String? _phone;
  String? _permanentAddress;
  String? _message;
  String? _mailingAddress;
  String? _emailID;
  num? _customerCode;
  String? _coApplicant3;
  String? _coApplicant2;
  String? _coApplicant1;
  String? _accountName;
ProfileDetailResponse copyWith({  bool? returnCode,
  String? profilePic,
  String? phone,
  String? permanentAddress,
  String? message,
  String? mailingAddress,
  String? emailID,
  num? customerCode,
  String? coApplicant3,
  String? coApplicant2,
  String? coApplicant1,
  String? accountName,
}) => ProfileDetailResponse(  returnCode: returnCode ?? _returnCode,
  profilePic: profilePic ?? _profilePic,
  phone: phone ?? _phone,
  permanentAddress: permanentAddress ?? _permanentAddress,
  message: message ?? _message,
  mailingAddress: mailingAddress ?? _mailingAddress,
  emailID: emailID ?? _emailID,
  customerCode: customerCode ?? _customerCode,
  coApplicant3: coApplicant3 ?? _coApplicant3,
  coApplicant2: coApplicant2 ?? _coApplicant2,
  coApplicant1: coApplicant1 ?? _coApplicant1,
  accountName: accountName ?? _accountName,
);
  bool? get returnCode => _returnCode;
  String? get profilePic => _profilePic;
  String? get phone => _phone;
  String? get permanentAddress => _permanentAddress;
  String? get message => _message;
  String? get mailingAddress => _mailingAddress;
  String? get emailID => _emailID;
  num? get customerCode => _customerCode;
  String? get coApplicant3 => _coApplicant3;
  String? get coApplicant2 => _coApplicant2;
  String? get coApplicant1 => _coApplicant1;
  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['ProfilePic'] = _profilePic;
    map['Phone'] = _phone;
    map['Permanent_Address'] = _permanentAddress;
    map['message'] = _message;
    map['Mailing_Address'] = _mailingAddress;
    map['EmailID'] = _emailID;
    map['customerCode'] = _customerCode;
    map['Co_Applicant_3'] = _coApplicant3;
    map['Co_Applicant_2'] = _coApplicant2;
    map['Co_Applicant_1'] = _coApplicant1;
    map['AccountName'] = _accountName;
    return map;
  }

}