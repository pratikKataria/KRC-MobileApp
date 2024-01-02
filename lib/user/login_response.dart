/// Total_Bookings : 4
/// Total_Accounts : 3
/// returnCode : true
/// message : "Login Successful."
/// bookingList : [{"Unit":"1","Tower":"Raheja Assencio","Project":"Raheja Asencio","bookingId":"a013C00000AzY3KQAV","AccountID":"0013C00000rWwiDQAS"},{"Unit":"1","Tower":"Raheja Assencio","Project":"Raheja Asencio","bookingId":"a013C00000B0tYEQAZ","AccountID":"0013C00000rWwiDQAS"},{"Unit":"105","Tower":"Tower 1","Project":"KRC","bookingId":"a013C00000AKnAZQA1","AccountID":"0013C00000edzftQAA"},{"Unit":"A-1101","Tower":"Raheja Assencio","Project":"Raheja Asencio","bookingId":"a013C00000AXsmpQAD","AccountID":"0013C00000hp5RTQAY"}]
/// accountList : [{"Name":"devStetig1235 7Aug","Mobile":"9561269189","Email":"tanmay.wankhede@stetig.in","AccountID":"0013C00000rWwiDQAS"},{"Name":"AdityaSAPtestlogin","Mobile":"9561269189","Email":"tanmay.wankhede@stetig.in","AccountID":"0013C00000edzftQAA"},{"Name":"Ujjwal Mandal","Mobile":"9561269189","Email":"tanmay.wankhede@stetig.in","AccountID":"0013C00000hp5RTQAY"}]

class LoginResponse {
  LoginResponse({
      num? totalBookings, 
      num? totalAccounts, 
      bool? returnCode, 
      String? message, 
      List<BookingList>? bookingList, 
      List<AccountList>? accountList,}){
    _totalBookings = totalBookings;
    _totalAccounts = totalAccounts;
    _returnCode = returnCode;
    _message = message;
    _bookingList = bookingList;
    _accountList = accountList;
}

  LoginResponse.fromJson(dynamic json) {
    _totalBookings = json['Total_Bookings'];
    _totalAccounts = json['Total_Accounts'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['bookingList'] != null) {
      _bookingList = [];
      json['bookingList'].forEach((v) {
        _bookingList?.add(BookingList.fromJson(v));
      });
    }
    if (json['accountList'] != null) {
      _accountList = [];
      json['accountList'].forEach((v) {
        _accountList?.add(AccountList.fromJson(v));
      });
    }
  }
  num? _totalBookings;
  num? _totalAccounts;
  bool? _returnCode;
  String? _message;
  List<BookingList>? _bookingList;
  List<AccountList>? _accountList;
LoginResponse copyWith({  num? totalBookings,
  num? totalAccounts,
  bool? returnCode,
  String? message,
  List<BookingList>? bookingList,
  List<AccountList>? accountList,
}) => LoginResponse(  totalBookings: totalBookings ?? _totalBookings,
  totalAccounts: totalAccounts ?? _totalAccounts,
  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  bookingList: bookingList ?? _bookingList,
  accountList: accountList ?? _accountList,
);
  num? get totalBookings => _totalBookings;
  num? get totalAccounts => _totalAccounts;
  bool? get returnCode => _returnCode;
  String? get message => _message;
  List<BookingList>? get bookingList => _bookingList;
  List<AccountList>? get accountList => _accountList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Total_Bookings'] = _totalBookings;
    map['Total_Accounts'] = _totalAccounts;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_bookingList != null) {
      map['bookingList'] = _bookingList?.map((v) => v.toJson()).toList();
    }
    if (_accountList != null) {
      map['accountList'] = _accountList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Name : "devStetig1235 7Aug"
/// Mobile : "9561269189"
/// Email : "tanmay.wankhede@stetig.in"
/// AccountID : "0013C00000rWwiDQAS"

class AccountList {
  AccountList({
      String? name, 
      String? mobile, 
      String? email, 
      String? accountID,}){
    _name = name;
    _mobile = mobile;
    _email = email;
    _accountID = accountID;
}

  AccountList.fromJson(dynamic json) {
    _name = json['Name'];
    _mobile = json['Mobile'];
    _email = json['Email'];
    _accountID = json['AccountID'];
  }
  String? _name;
  String? _mobile;
  String? _email;
  String? _accountID;
AccountList copyWith({  String? name,
  String? mobile,
  String? email,
  String? accountID,
}) => AccountList(  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  accountID: accountID ?? _accountID,
);
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get accountID => _accountID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Mobile'] = _mobile;
    map['Email'] = _email;
    map['AccountID'] = _accountID;
    return map;
  }

}

/// Unit : "1"
/// Tower : "Raheja Assencio"
/// Project : "Raheja Asencio"
/// bookingId : "a013C00000AzY3KQAV"
/// AccountID : "0013C00000rWwiDQAS"

class BookingList {
  BookingList({
      String? unit, 
      String? tower, 
      String? project, 
      String? bookingId, 
      String? accountID,}){
    _unit = unit;
    _tower = tower;
    _project = project;
    _bookingId = bookingId;
    _accountID = accountID;
}

  BookingList.fromJson(dynamic json) {
    _unit = json['Unit'];
    _tower = json['Tower'];
    _project = json['Project'];
    _bookingId = json['bookingId'];
    _accountID = json['AccountID'];
  }
  String? _unit;
  String? _tower;
  String? _project;
  String? _bookingId;
  String? _accountID;
BookingList copyWith({  String? unit,
  String? tower,
  String? project,
  String? bookingId,
  String? accountID,
}) => BookingList(  unit: unit ?? _unit,
  tower: tower ?? _tower,
  project: project ?? _project,
  bookingId: bookingId ?? _bookingId,
  accountID: accountID ?? _accountID,
);
  String? get unit => _unit;
  String? get tower => _tower;
  String? get project => _project;
  String? get bookingId => _bookingId;
  String? get accountID => _accountID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unit'] = _unit;
    map['Tower'] = _tower;
    map['Project'] = _project;
    map['bookingId'] = _bookingId;
    map['AccountID'] = _accountID;
    return map;
  }

}