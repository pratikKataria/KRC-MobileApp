
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krc/utils/Dialogs.dart';

class ProgressDialogInterceptor extends Interceptor {


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Show the progress dialog
    BuildContext context =  options.extra["context"];
    String description = "";
    Dialogs.showLoader(context, description);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Hide the progress dialog
    Dialogs.hideLoader();

    super.onResponse(response, handler);
  }
}
