/// returnCode : true
/// ReferenceLeadList : [{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Arvind Test","MobileNumber":"01234569870","Email":"mauryaarvind255@yahoo.com"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Testeewe RefrrLead4","MobileNumber":"07777775559","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Testeewe RefrrLead5","MobileNumber":"08888885544","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Testeewe RefrrLead5","MobileNumber":"08888885566","Email":"testapi1@stetig.in"},{"Typology":"Online 2 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond TenX Habitat","Name":"3 dec test","MobileNumber":"09988888899","Email":"yrtuu@gmail.com"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead","MobileNumber":"07777777788","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777777789","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777777784","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777744784","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777777781","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777775589","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead3","MobileNumber":"07777775566","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead4","MobileNumber":"07777775555","Email":"testapi1@stetig.in"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"Test Ref Lead2","MobileNumber":"07777771289","Email":"testapi1@stetig.in"},{"Typology":"Online 1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"firsttest lasttes","MobileNumber":"01234567898","Email":"tesqq1t@gmail.com"},{"Typology":"1 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"firsttest lasttes","MobileNumber":"08787877878","Email":"testapi1@stetig.in"},{"Typology":"Online 2 BHK","Status":"Call back","ReferredByAccount":"001N0000027FiB2IAK","ProjectInterested":"Raymond","Name":"test lead 30 aug","MobileNumber":"09999888899","Email":"testzxc@gmail.com"}]
/// message : "Success"

class AllLeadResponse {
  AllLeadResponse({
      bool? returnCode, 
      List<ReferenceLeadList>? referenceLeadList, 
      String? message,}){
    _returnCode = returnCode;
    _referenceLeadList = referenceLeadList;
    _message = message;
}

  AllLeadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['ReferenceLeadList'] != null) {
      _referenceLeadList = [];
      json['ReferenceLeadList'].forEach((v) {
        _referenceLeadList?.add(ReferenceLeadList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _returnCode;
  List<ReferenceLeadList>? _referenceLeadList;
  String? _message;
AllLeadResponse copyWith({  bool? returnCode,
  List<ReferenceLeadList>? referenceLeadList,
  String? message,
}) => AllLeadResponse(  returnCode: returnCode ?? _returnCode,
  referenceLeadList: referenceLeadList ?? _referenceLeadList,
  message: message ?? _message,
);
  bool? get returnCode => _returnCode;
  List<ReferenceLeadList>? get referenceLeadList => _referenceLeadList;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_referenceLeadList != null) {
      map['ReferenceLeadList'] = _referenceLeadList?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// Typology : "1 BHK"
/// Status : "Call back"
/// ReferredByAccount : "001N0000027FiB2IAK"
/// ProjectInterested : "Raymond"
/// Name : "Arvind Test"
/// MobileNumber : "01234569870"
/// Email : "mauryaarvind255@yahoo.com"

class ReferenceLeadList {
  ReferenceLeadList({
      String? typology, 
      String? status, 
      String? referredByAccount, 
      String? projectInterested, 
      String? name, 
      String? mobileNumber, 
      String? email,}){
    _typology = typology;
    _status = status;
    _referredByAccount = referredByAccount;
    _projectInterested = projectInterested;
    _name = name;
    _mobileNumber = mobileNumber;
    _email = email;
}

  ReferenceLeadList.fromJson(dynamic json) {
    _typology = json['Typology'];
    _status = json['Status'];
    _referredByAccount = json['ReferredByAccount'];
    _projectInterested = json['ProjectInterested'];
    _name = json['Name'];
    _mobileNumber = json['MobileNumber'];
    _email = json['Email'];
  }
  String? _typology;
  String? _status;
  String? _referredByAccount;
  String? _projectInterested;
  String? _name;
  String? _mobileNumber;
  String? _email;
ReferenceLeadList copyWith({  String? typology,
  String? status,
  String? referredByAccount,
  String? projectInterested,
  String? name,
  String? mobileNumber,
  String? email,
}) => ReferenceLeadList(  typology: typology ?? _typology,
  status: status ?? _status,
  referredByAccount: referredByAccount ?? _referredByAccount,
  projectInterested: projectInterested ?? _projectInterested,
  name: name ?? _name,
  mobileNumber: mobileNumber ?? _mobileNumber,
  email: email ?? _email,
);
  String? get typology => _typology;
  String? get status => _status;
  String? get referredByAccount => _referredByAccount;
  String? get projectInterested => _projectInterested;
  String? get name => _name;
  String? get mobileNumber => _mobileNumber;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Typology'] = _typology;
    map['Status'] = _status;
    map['ReferredByAccount'] = _referredByAccount;
    map['ProjectInterested'] = _projectInterested;
    map['Name'] = _name;
    map['MobileNumber'] = _mobileNumber;
    map['Email'] = _email;
    return map;
  }

}