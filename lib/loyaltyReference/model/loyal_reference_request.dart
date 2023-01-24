/// CustomerAccountId : "001N0000027FiB2"
/// Salutation : "Mr"
/// FirstName : "Test"
/// LastName : "Ref Lead2"
/// Mobile : "07777777789"
/// Email : "testAPI1@stetig.in"
/// Project : "Raymond"
/// Typology : "1 BHK"

class LoyaltyReferenceRequest {
  LoyaltyReferenceRequest({
      String? customerAccountId,
      String? salutation,
      String? firstName,
      String? lastName,
      String? mobile,
      String? email,
      String? project,
      String? typology,}){
    _customerAccountId = customerAccountId;
    _salutation = salutation;
    _firstName = firstName;
    _lastName = lastName;
    _mobile = mobile;
    _email = email;
    _project = project;
    _typology = typology;
}

  LoyaltyReferenceRequest.fromJson(dynamic json) {
    _customerAccountId = json['accountID'] ?? "";
    _salutation = json['Salutation'] ?? "";
    _firstName = json['FirstName'] ?? "";
    _lastName = json['LastName'] ?? "";
    _mobile = json['Mobile'] ?? "";
    _email = json['Email'] ?? "";
    _project = json['Project'] ?? "";
    _typology = json['Typology'] ?? "";
  }
  String? _customerAccountId;
  String? _salutation;
  String? _firstName;
  String? _lastName;
  String? _mobile;
  String? _email;
  String? _project;
  String? _typology;

  String get customerAccountId => _customerAccountId ??"";
  String  get salutation => _salutation ?? "";
  String  get firstName => _firstName ?? "";
  String  get lastName => _lastName ?? "";
  String  get mobile => _mobile ?? "";
  String  get email => _email ?? "";
  String  get project => _project ?? "";
  String  get typology => _typology ?? "";


  set customerAccountId(String value) {
    _customerAccountId = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountID'] = _customerAccountId;
    map['Salutation'] = _salutation;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    map['Mobile'] = _mobile;
    map['Email'] = _email;
    map['Project'] = _project;
    map['Typology'] = _typology;
    return map;
  }

  set salutation(String? value) {
    _salutation = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set mobile(String? value) {
    _mobile = value;
  }

  set email(String? value) {
    _email = value;
  }

  set project(String? value) {
    _project = value;
  }

  set typology(String? value) {
    _typology = value;
  }
}