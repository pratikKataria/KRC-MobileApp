/// returnCode : 2
/// message : "Success"

class NotificationReadResponse {
  NotificationReadResponse({
      int? returnCode, 
      String? message,}){
    _returnCode = returnCode;
    _message = message;
}

  NotificationReadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  int? _returnCode;
  String? _message;

  int? get returnCode => _returnCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}