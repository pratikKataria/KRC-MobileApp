
import 'login_response.dart';
import 'token_response.dart';
class CurrentUser {
  LoginResponse? _userCredentials;
  TokenResponse? _tokenResponse;
  bool? _isLoggedIn;

  CurrentUser({
    LoginResponse? userCredentials,
    TokenResponse? tokenResponse,
    bool? isLoggedIn,
  })  : _userCredentials = userCredentials,
        _tokenResponse = tokenResponse,
        _isLoggedIn = isLoggedIn;

  bool get isLoggedIn => _isLoggedIn ?? false;

  LoginResponse? get userCredentials => _userCredentials;

  TokenResponse? get tokenResponse => _tokenResponse;

  factory CurrentUser.fromJson(Map<String, dynamic>? json) {
    return CurrentUser(
        userCredentials: json?['_userCredentials'] == null ?null:LoginResponse.fromJson(json?['_userCredentials'])  ,
        tokenResponse: json?["_tokenResponse"]== null ?null:TokenResponse.fromJson(json?["_tokenResponse"]),
        isLoggedIn: json?['isLogin']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_userCredentials': this.userCredentials?.toJson(),
      '_tokenResponse': this.tokenResponse?.toJson(),
      'isLogin': this.isLoggedIn,
    };
  }

  set userCredentials(LoginResponse? value) {
    _userCredentials = value;
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  set tokenResponse(TokenResponse? value) {
    _tokenResponse = value;
  }
}
