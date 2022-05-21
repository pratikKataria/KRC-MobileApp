/// returnCode : 2
/// message : "Login Succesfull"
/// Is_Customer : true
/// AccountId : "001N000001S7nkdIAB"

class LoginResponse {
  LoginResponse({
    bool returnCode,
    String message,
    String accountId,
  }) {
    _returnCode = returnCode;
    _message = message;
    _accountId = accountId;
  }

  LoginResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _accountId = json['AccountId'];
  }

  bool _returnCode;
  String _message;
  String _accountId;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get accountId => _accountId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['AccountId'] = _accountId;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'returnCode': this._returnCode,
      'message': this._message,
      'accountId': this._accountId,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      returnCode: map != null ? map['returnCode'] as bool : null,
      message: map != null ? map['message'] as String : null,
      accountId: map != null ? map['accountId'] as String : null,
    );
  }
}
