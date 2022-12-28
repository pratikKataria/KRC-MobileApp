import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/hrm_input_fields_dummy.dart';
import 'package:krc/widgets/pml_button.dart';

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({Key? key}) : super(key: key);

  @override
  State<CreateNewTicket> createState() => _CreateNewTicketState();
}

class _CreateNewTicketState extends State<CreateNewTicket> {
  List<String> listOfRelatedTo = ["Onboarding", "Allotment"];
  List<String> listOfCategory = ["Allotment Information", "System Issue"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Related to", style: textStyle14px500w),
            verticalSpace(10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: listOfRelatedTo
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(color: AppColors.chipBg, borderRadius: BorderRadius.circular(30.0)),
                      child: Text(e, style: textStyle12px500w),
                    ),
                  )
                  .toList(),
            ),
            verticalSpace(30.0),
            Text("Category", style: textStyle14px500w),
            verticalSpace(10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: listOfCategory
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(color: AppColors.chipBg, borderRadius: BorderRadius.circular(30.0)),
                      child: Text(e, style: textStyle12px500w),
                    ),
                  )
                  .toList(),
            ),
            verticalSpace(30.0),
            Row(
              children: [Text("Description", style: textStyle14px500w), Text(" *", style: textStyleRed14px700w),],
            ),
            verticalSpace(30.0),
            Text("Attachment", style: textStyle14px500w),
            HrmInputFieldDummy(
                // textController: dobTextController,
                headingText: "",
                text: "Add img, pdf or xls",
                mandate: true),

            verticalSpace(30.0),
            loginButton("Create Ticket"),
          ],
        ),
      ),
    );
  }

  PmlButton loginButton(String text) {
    return PmlButton(
      text: "$text",
      onTap: () {
        // if (mobileOtp == null) {
        //   _corePresenter.sendEmailMobileOTP(context, phoneTextController.text.toString());
        //   return;
        // }
        //
        // String inputText = otpTextController.text.toString();
        // if (inputText.isEmpty) {
        //   onError("Please enter Otp");
        //   return;
        // }
        //
        // if (int.parse(inputText) != mobileOtp) {
        //   onError("Please enter correct otp");
        //   return;
        // }
        //
        // if (checkBox == false) {
        //   onError("Please accept terms and conditions");
        //   return;
        // }
        //
        // _corePresenter.mobileLogin(context, phoneTextController.text.toString());

        // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }

}
