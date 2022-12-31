import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/quickPayScreen/model/quick_pay_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class QuickPayScreen extends StatefulWidget {
  const QuickPayScreen({Key? key}) : super(key: key);

  @override
  State<QuickPayScreen> createState() => _QuickPayScreenState();
}

class _QuickPayScreenState extends State<QuickPayScreen> {
  List<BankDataList> listOfBanks = [];

  @override
  void initState() {
    super.initState();
    getBankDetail();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      headerTextController.value = Screens.kCPEventScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              verticalSpace(20.0),
              ...listOfBanks
                  .map((e) =>
                      cardViewBankDetail(e.bankName ?? "", e.accountType ?? "", e.accountNumber ?? "", e.accountHolderName ?? ""))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Column cardViewBankDetail(String accType, String accName, String accNumber, String ifsc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(Assets.imagesIcSbi, width: 40.0),
            horizontalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("State Bank of India", style: textStyleRegular16px500w),
                Text(accName, style: textStylePrimary16px500w),
              ],
            ),
          ],
        ),
        verticalSpace(4.0),
        Text("Name: Account information", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("Account Name: Krc Homes Officials ", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("Account Number: 2455 8899 1002 1121", style: textStyle14px500w),
        verticalSpace(2.0),
        Text("IFSC Code: SBIN2341", style: textStyle14px500w),
        verticalSpace(25.0),
        line(),
        verticalSpace(25.0),
      ],
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  void getBankDetail() async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"ProjectId": "a0B3C000005S7KnUAK"};

    Dialogs.showLoader(context, "Getting Bank detail ...");
    apiController.post(EndPoints.POST_BANK_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        QuickPayResponse quickPayResponse = QuickPayResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          setState(() {
            listOfBanks.addAll(quickPayResponse.bankDataList ?? []);
          });
        } else {
          onError(quickPayResponse.message ?? "Failed");
        }
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        onError("$e");
        // ApiErrorParser.getResult(e, _v);
      });
  }
}
