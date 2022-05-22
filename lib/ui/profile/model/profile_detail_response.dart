/// returnCode : true
/// ProfilePic : "asdf"
/// Phone : "8999928361"
/// message : "SUCCESS"
/// EmailID : "adityasingh.bisen@stetig.in"
/// Address : "plot no 1,opposite Nath Towers,mumbai highway,Panvel,Thane,Maharashtra,India-436005."
/// AccountName : "AdityaSAPtestlogin"

class ProfileDetailResponse {
  ProfileDetailResponse({
      bool returnCode, 
      String profilePic, 
      String phone, 
      String message, 
      String emailID, 
      String address, 
      String accountName,}){
    _returnCode = returnCode;
    _profilePic = profilePic;
    _phone = phone;
    _message = message;
    _emailID = emailID;
    _address = address;
    _accountName = accountName;
}

  ProfileDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _profilePic = json['ProfilePic'];
    _phone = json['Phone'];
    _message = json['message'];
    _emailID = json['EmailID'];
    _address = json['Address'];
    _accountName = json['AccountName'];
  }
  bool _returnCode;
  String _profilePic;
  String _phone;
  String _message;
  String _emailID;
  String _address;
  String _accountName;

  bool get returnCode => _returnCode;
  String get profilePic => _profilePic;
  String get phone => _phone;
  String get message => _message;
  String get emailID => _emailID;
  String get address => _address;
  String get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['ProfilePic'] = _profilePic;
    map['Phone'] = _phone;
    map['message'] = _message;
    map['EmailID'] = _emailID;
    map['Address'] = _address;
    map['AccountName'] = _accountName;
    return map;
  }

}