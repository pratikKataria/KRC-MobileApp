import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/api/api_error_parser.dart';
import 'package:krc/loyaltyReference/loyalty_reference_view.dart';
import 'package:krc/res/Strings.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/Utility.dart';

import 'model/all_lead_response.dart';
import 'model/loyal_reference_request.dart';
import 'model/loyalty_reference_response.dart';
import 'model/picklist_value_Response.dart';

class LoyalReferencePresenter extends BasePresenter {
  final LoyaltyReferenceView _view;

  LoyalReferencePresenter(this._view) : super(_view);

  void createLead(BuildContext context, LoyaltyReferenceRequest request) async {
    if (request.firstName.isEmpty) {
      _view.onError("Please enter first name");
      return;
    }

    if (request.lastName.isEmpty) {
      _view.onError("Please enter last name");
      return;
    }

    if (request.mobile.isEmpty) {
      _view.onError("Please enter mobile number");
      return;
    }

    if (request.email.isEmpty) {
      _view.onError("Please enter Email Id");
      return;
    }

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    request.customerAccountId = accountId ?? "";

    Dialogs.showLoader(context, "Creating lead ...");
    apiController.post(EndPoints.LEAD_MOBILE_APP, body: request.toJson(), headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        LoyaltyReferenceResponse loyaltyReferenceResponse = LoyaltyReferenceResponse.fromJson(response.data);
        if (loyaltyReferenceResponse.returnCode ?? false) {
          _view.onClientRefered(loyaltyReferenceResponse);
        } else {
          _view.onError(loyaltyReferenceResponse.message ?? Strings.SomethingWentWrong);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _view);
      });
  }

  Future<void> getPickList(BuildContext context) async {
    Dialogs.showLoader(context, "Getting picklist values ...");
    apiController.post(EndPoints.PICKLIST_VALUE, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();

        List<PicklistValueResponse> list = [];
        List listOfDynamic = response.data as List;
        listOfDynamic.forEach((element) => list.add(PicklistValueResponse.fromJson(element)));

        PicklistValueResponse? bookingResponse = list.isNotEmpty ? list.first : null;
        if (bookingResponse == null) {
          _view.onError(Strings.SomethingWentWrong);
          return;
        }

        _view.onPickListValueFetched(list);
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _view);
      });
  }

  void getListOfReferrals(BuildContext context) async {
    // Dialogs.showLoader(context, "Getting all referrals ...");
    // String uid = await AuthUser.getInstance().uid ?? "";
    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    Dialogs.showLoader(context, "Getting all referrals ...");
    Map<String, String> body = {"accountID": accountId ?? ""};
    apiController.post(EndPoints.ALL_REFERRALS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();

        AllLeadResponse allLeadResponse = AllLeadResponse.fromJson(response.data);

        if (allLeadResponse.returnCode ?? false) {
          _view.onAllLeadFetched(allLeadResponse);
        } else {
          _view.onError(allLeadResponse.message ?? "Failed");
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _view);
      });
  }

  void getListOfReferralsWithoutLoader(BuildContext context) async {
    // Dialogs.showLoader(context, "Getting all referrals ...");
    // String uid = await AuthUser.getInstance().uid ?? "";
    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    Map<String, String> body = {"accountID": accountId ?? ""};
    apiController.post(EndPoints.ALL_REFERRALS, body: body, headers: await Utility.header())
      ..then((response) {
        AllLeadResponse allLeadResponse = AllLeadResponse.fromJson(response.data);

        if (allLeadResponse.returnCode ?? false) {
          _view.onAllLeadFetched(allLeadResponse);
        } else {
          _view.onError(allLeadResponse.message ?? "Failed");
        }
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _view);
      });
  }
}
