/// returnCode : true
/// message : "success"

class CreateTicketResponse {
  CreateTicketResponse({
      bool? returnCode, 
      String? message,}){
    _returnCode = returnCode;
    _message = message;
}

  CreateTicketResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  bool? _returnCode;
  String? _message;

  bool? get returnCode => _returnCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}