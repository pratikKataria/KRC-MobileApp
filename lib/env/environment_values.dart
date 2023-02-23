
import 'package:krc/env/environment_control.dart';

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
        "client_id": "3MVG9p1Q1BCe9GmDCSVmMOMYXkDKUIdFCcaTk9yiSnUCEJ1QzkTIYESXTk0zQnfvATZWK3.ZMBKY90bsEu.kg",
        "grant_type": "password",
        "client_secret": "F62C28F719FFA31F93EDD5BBEF654F172DD5E1B5D5A0E8D78A1E37A363853842",
        "username": "swapnil.gavande@stetig.in.krc",
        "password": "Stetig@1232YEj598olJiHZkyY1TFMIbnm",
      };
    }
  }

  static get getBaseURL => EnvironmentControl.currentEnv == PROD
      ? "https://krahejacorp.my.salesforce.com/services/apexrest/Customer_Mobile_App"
      : "https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/services/apexrest/Customer_Mobile_App";

  static get getAccessTokenURL => EnvironmentControl.currentEnv == PROD
      ? "https://login.salesforce.com/services/oauth2/token"
      : "https://test.salesforce.com/services/oauth2/token";
}
