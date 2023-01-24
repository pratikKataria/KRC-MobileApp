/// Typology : "1 BHK"
/// returnCode : true
/// ReferredByAccount : "001N0000027FiB2IAK"
/// ReferenceLeadId : "00QN000000AhMMEMA3"
/// Project : "Raymond"
/// Name : "TestRef Lead2"
/// Mobile : "07777777781"
/// message : "SUCCESS"
/// Email : "testAPI1@stetig.in"

class LoyaltyReferenceResponse {
  LoyaltyReferenceResponse({
      String? typology, 
      bool? returnCode, 
      String? referredByAccount, 
      String? referenceLeadId, 
      String? project, 
      String? name, 
      String? mobile, 
      String? message, 
      String? email,}){
    _typology = typology;
    _returnCode = returnCode;
    _referredByAccount = referredByAccount;
    _referenceLeadId = referenceLeadId;
    _project = project;
    _name = name;
    _mobile = mobile;
    _message = message;
    _email = email;
}

  LoyaltyReferenceResponse.fromJson(dynamic json) {
    _typology = json['Typology'];
    _returnCode = json['returnCode'];
    _referredByAccount = json['ReferredByAccount'];
    _referenceLeadId = json['ReferenceLeadId'];
    _project = json['Project'];
    _name = json['Name'];
    _mobile = json['Mobile'];
    _message = json['message'];
    _email = json['Email'];
  }
  String? _typology;
  bool? _returnCode;
  String? _referredByAccount;
  String? _referenceLeadId;
  String? _project;
  String? _name;
  String? _mobile;
  String? _message;
  String? _email;

  String? get typology => _typology;
  bool? get returnCode => _returnCode;
  String? get referredByAccount => _referredByAccount;
  String? get referenceLeadId => _referenceLeadId;
  String? get project => _project;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get message => _message;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Typology'] = _typology;
    map['returnCode'] = _returnCode;
    map['ReferredByAccount'] = _referredByAccount;
    map['ReferenceLeadId'] = _referenceLeadId;
    map['Project'] = _project;
    map['Name'] = _name;
    map['Mobile'] = _mobile;
    map['message'] = _message;
    map['Email'] = _email;
    return map;
  }

}