/// RmPhone : "9405911857"
/// RmName : "testRm"
/// RmEmailID : "test@123.com"
/// returnCode : true
/// message : "SUCCESS"

class RmDetailResponse {
  RmDetailResponse({
      String rmPhone, 
      String rmName, 
      String rmEmailID, 
      bool returnCode, 
      String message,}){
    _rmPhone = rmPhone;
    _rmName = rmName;
    _rmEmailID = rmEmailID;
    _returnCode = returnCode;
    _message = message;
}

  RmDetailResponse.fromJson(dynamic json) {
    _rmPhone = json['RmPhone'];
    _rmName = json['RmName'];
    _rmEmailID = json['RmEmailID'];
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  String _rmPhone;
  String _rmName;
  String _rmEmailID;
  bool _returnCode;
  String _message;

  String get rmPhone => _rmPhone;
  String get rmName => _rmName;
  String get rmEmailID => _rmEmailID;
  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RmPhone'] = _rmPhone;
    map['RmName'] = _rmName;
    map['RmEmailID'] = _rmEmailID;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}