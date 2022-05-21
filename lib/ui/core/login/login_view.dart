import 'package:krc/ui/core/core_view.dart';
 import 'package:krc/user/login_response.dart';
import 'package:krc/user/token_response.dart';

abstract class LoginView extends CoreView {
  void onTokenGenerated(TokenResponse tokenResponse);
  void onOtpSent(int mobileOtp, int identifier);
  void onEmailVerificationSuccess(LoginResponse emailResponse);
}
