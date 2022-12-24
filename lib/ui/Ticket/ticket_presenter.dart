import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/ticket_category_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'ticket_view.dart';

class TicketPresenter extends BasePresenter {
  TicketView _v;

  TicketPresenter(this._v) : super(_v);

  void getTickets(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"accountID": accountId};

    Dialogs.showLoader(context, "Getting your tickets ...");
    apiController.post(EndPoints.GET_TICKETS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        TicketResponse rmDetailResponse = TicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onTicketFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketsWithoutLoader(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"accountID": accountId};

    apiController.post(EndPoints.GET_TICKETS, body: body, headers: await Utility.header())
      ..then((response) {
        TicketResponse rmDetailResponse = TicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onTicketFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void createTickets(BuildContext context, String desc, String? category, String? subCategory) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {
      "accountID": accountId,
      "description": desc,
      "category": category,
      "subcategory": subCategory,
    };

    Dialogs.showLoader(context, "Creating your ticket ...");
    apiController.post(EndPoints.POST_CREATE_TICKET, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        CreateTicketResponse rmDetailResponse = CreateTicketResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onTicketCreated(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketCategory(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    // Dialogs.showLoader(context, "Getting your tickets ...");
    apiController.post(EndPoints.POST_CATEGORY, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onTicketCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketSubCategory(BuildContext context, String category) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Map body = {"category": category};

    // Dialogs.showLoader(context, "Getting your tickets ...");
    apiController.post(EndPoints.POST_SUB_CATEGORY, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onSubCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTicketSubCategoryWithLoader(BuildContext context, String? category) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Map body = {"category": category};

    Dialogs.showLoader(context, "Getting sub category ...");
    apiController.post(EndPoints.POST_SUB_CATEGORY, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        TicketCategoryResponse rmDetailResponse = TicketCategoryResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onSubCategoryFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
