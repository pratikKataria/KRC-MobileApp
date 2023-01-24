/// returnCode : true
/// message : "SUCCESS"
/// bankDataList : [{"Project_Name":"KRC","IFSC_Code":"SBIN1234E","Bank_Name":"SBI","Bank_Address":"PUNE","Account_Type":"Current Account","Account_Number":"Test Customer1","Account_Holder_Name":"SBI"}]

class QuickPayResponse {
  QuickPayResponse({
      bool? returnCode, 
      String? message, 
      List<BankDataList>? bankDataList,}){
    _returnCode = returnCode;
    _message = message;
    _bankDataList = bankDataList;
}

  QuickPayResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['bankDataList'] != null) {
      _bankDataList = [];
      json['bankDataList'].forEach((v) {
        _bankDataList?.add(BankDataList.fromJson(v));
      });
    }
  }
  bool? _returnCode;
  String? _message;
  List<BankDataList>? _bankDataList;
QuickPayResponse copyWith({  bool? returnCode,
  String? message,
  List<BankDataList>? bankDataList,
}) => QuickPayResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  bankDataList: bankDataList ?? _bankDataList,
);
  bool? get returnCode => _returnCode;
  String? get message => _message;
  List<BankDataList>? get bankDataList => _bankDataList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_bankDataList != null) {
      map['bankDataList'] = _bankDataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Project_Name : "KRC"
/// IFSC_Code : "SBIN1234E"
/// Bank_Name : "SBI"
/// Bank_Address : "PUNE"
/// Account_Type : "Current Account"
/// Account_Number : "Test Customer1"
/// Account_Holder_Name : "SBI"

class BankDataList {
  BankDataList({
      String? projectName, 
      String? iFSCCode, 
      String? bankName, 
      String? bankAddress, 
      String? accountType, 
      String? accountNumber, 
      String? accountHolderName,}){
    _projectName = projectName;
    _iFSCCode = iFSCCode;
    _bankName = bankName;
    _bankAddress = bankAddress;
    _accountType = accountType;
    _accountNumber = accountNumber;
    _accountHolderName = accountHolderName;
}

  BankDataList.fromJson(dynamic json) {
    _projectName = json['Project_Name'];
    _iFSCCode = json['IFSC_Code'];
    _bankName = json['Bank_Name'];
    _bankAddress = json['Bank_Address'];
    _accountType = json['Account_Type'];
    _accountNumber = json['Account_Number'];
    _accountHolderName = json['Account_Holder_Name'];
  }
  String? _projectName;
  String? _iFSCCode;
  String? _bankName;
  String? _bankAddress;
  String? _accountType;
  String? _accountNumber;
  String? _accountHolderName;
BankDataList copyWith({  String? projectName,
  String? iFSCCode,
  String? bankName,
  String? bankAddress,
  String? accountType,
  String? accountNumber,
  String? accountHolderName,
}) => BankDataList(  projectName: projectName ?? _projectName,
  iFSCCode: iFSCCode ?? _iFSCCode,
  bankName: bankName ?? _bankName,
  bankAddress: bankAddress ?? _bankAddress,
  accountType: accountType ?? _accountType,
  accountNumber: accountNumber ?? _accountNumber,
  accountHolderName: accountHolderName ?? _accountHolderName,
);
  String? get projectName => _projectName;
  String? get iFSCCode => _iFSCCode;
  String? get bankName => _bankName;
  String? get bankAddress => _bankAddress;
  String? get accountType => _accountType;
  String? get accountNumber => _accountNumber;
  String? get accountHolderName => _accountHolderName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Project_Name'] = _projectName;
    map['IFSC_Code'] = _iFSCCode;
    map['Bank_Name'] = _bankName;
    map['Bank_Address'] = _bankAddress;
    map['Account_Type'] = _accountType;
    map['Account_Number'] = _accountNumber;
    map['Account_Holder_Name'] = _accountHolderName;
    return map;
  }

}