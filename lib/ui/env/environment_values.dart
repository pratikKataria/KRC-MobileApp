import 'package:krc/ui/env/environment_control.dart';

abstract class EnvironmentValues {
  static const int DEV = 0;
  static const int PROD = 1;

  static getTokenBody() {
    if (EnvironmentControl.currentEnv == DEV) {
      return {
        'client_id': '3MVG9oZtFCVWuSwM3g1zK6OXevgjdRlck6VAGJdbjI2dGl6XnQPDIC1Je9VsclbdHrYBz4Km5NtXQrF_wcV2R',
        'grant_type': 'password',
        'client_secret': '3E470CEBA73994418CC183A66BB6EA67D0A47FCB92B6A8AE6F602C02BE3B004D',
        'username': 'integrationuser@krc.com.sb',
        'password': 'Salesforce@1239DDuLWhJjgGyQL9YyHu7yoUJG'
      };
    } else {
      return {
        "grant_type": "password",
        "client_id": "3MVG9Y6d_Btp4xp4lVI7hc0WUtDYjwSgLAw.8mGivfrt3frW8NVjEjcjLI2Vfg_FzkEDulWGtkRqeiSxZ6nle",
        "client_secret": "C892D8F3AAAF197C32FB41ECF5BA1C2EB151A1F2B2586AB3BB26C51E5662B92B",
        "username": "swapnil.gavande1010@stetig.in",
        "password": "Salesforce@123IhdyiMlHpHSilZ3EJMSu8jdWx",
      };
    }
  }

  static get getBaseURL => EnvironmentControl.currentEnv == PROD
      ? "https://piramal-realty.my.salesforce.com/services/apexrest"
      : "https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/services/apexrest/Customer_Mobile_App";

  static get getAccessTokenURL => EnvironmentControl.currentEnv == PROD
      ? "https://login.salesforce.com/services/oauth2/token"
      : "https://test.salesforce.com/services/oauth2/token";
}
