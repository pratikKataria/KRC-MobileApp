import 'package:krc/env/environment_control.dart';

abstract class EnvironmentValues {
  static const int DEV = 0;
  static const int PROD = 1;

  static getTokenBody() {
    if (EnvironmentControl.currentEnv == DEV) {
      return {
        'client_id': '3MVG9oZtFCVWuSwM3g1zK6OXevsi7P2VLIla9dT9aebUiWGpLnowKgBmRzN6mWGj.LpZjp7ueXcc2rE8vAL6E',
        'grant_type': 'password',
        'client_secret': 'E7889C331AF58C78546DF9B7DB8642CB1C1EF46D71C82D1AB29B0FA2E0A5E629',
        'username': 'tanmay.krcapp.sb.@stetig.in',
        'password': 'Salesforce@12345HItQ0FpeitBHlF4truk0nC86'
      };
    } else {
      return {
        "client_id": "3MVG9p1Q1BCe9GmDCSVmMOMYXkDKUIdFCcaTk9yiSnUCEJ1QzkTIYESXTk0zQnfvATZWK3.ZMBKY90bsEu.kg",
        "grant_type": "password",
        "client_secret": "F62C28F719FFA31F93EDD5BBEF654F172DD5E1B5D5A0E8D78A1E37A363853842",
        "username": "integrationuser@krc.in",
        "password": "Stetig@12347yC8HICT9TtjqADKzcJ8uUmta"
      };
    }
  }

  static get getBaseURL => EnvironmentControl.currentEnv == PROD
      ? "https://krahejacorp.my.salesforce.com/services/apexrest/Customer_Mobile_App"
      : "https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/services/apexrest/Customer_Mobile_App";

  static get getAccessTokenURL => EnvironmentControl.currentEnv == PROD ? "https://login.salesforce.com/services/oauth2/token" : "https://test.salesforce.com/services/oauth2/token";
}
