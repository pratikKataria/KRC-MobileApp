import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/reopen_response.dart';
import 'package:krc/ui/Ticket/model/ticket_category_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart';
import 'package:krc/ui/Ticket/ticket_presenter.dart';
import 'package:krc/ui/Ticket/ticket_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/hrm_input_fields_dummy.dart';
import 'package:krc/widgets/pml_button.dart';

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({Key? key}) : super(key: key);

  @override
  State<CreateNewTicket> createState() => _CreateNewTicketState();
}

class _CreateNewTicketState extends State<CreateNewTicket> implements TicketView {
  List<String> listOfSubCategory = [];
  List<String> listOfCategory = [];

  String? categoryString, subCategoryString, descriptionString;
  late TicketPresenter presenter;
  String? fileBlob;
  String? name;

  @override
  void initState() {
    super.initState();
    presenter = TicketPresenter(this);
    presenter.getTicketCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(20.0),
            Text("Related to", style: textStyle14px500w),
            verticalSpace(10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: listOfCategory
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          color: e == categoryString ? AppColors.colorPrimary : AppColors.chipBg,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text(e, style: e == categoryString ? textStyleWhite12px500w : textStyle12px500w),
                    ).onClick(() {
                      categoryString = e;
                      presenter.getTicketSubCategory(context, categoryString ?? "");
                      setState(() {});
                    }),
                  )
                  .toList(),
            ),
            verticalSpace(30.0),
            Text("Category", style: textStyle14px500w),
            verticalSpace(10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: listOfSubCategory
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          color: e == subCategoryString ? AppColors.colorPrimary : AppColors.chipBg,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text(e, style: e == subCategoryString ? textStyleWhite12px500w : textStyle12px500w),
                    ).onClick(() {
                      subCategoryString = e;
                      setState(() {});
                    }),
                  )
                  .toList(),
            ),
            verticalSpace(30.0),
            Row(
              children: [
                Text("Description", style: textStyle14px500w),
                Text(" *", style: textStyleRed14px700w),
              ],
            ),
            Container(
              height: 45,
              color: AppColors.attachmentBg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  horizontalSpace(10.0),
                  Expanded(
                    child: TextFormField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      // controller: emailPhoneTextController,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.none,
                      style: textStyle14px500w,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type description here ...",
                        hintStyle: textStyle14px500w,
                        suffixStyle: textStyle14px500w,
                        isDense: true,
                      ),
                      onChanged: (String val) {
                        // otp = null;
                        descriptionString = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(30.0),
            Text("Attachment", style: textStyle14px500w),
            HrmInputFieldDummy(
                    // textController: dobTextController,
                    headingText: "",
                    text: name ?? "Add img, pdf or xls",
                    mandate: true)
                .onClick(() async {
              try {
                List<String?> fileAndName = await Utility.pickFile(context);
                fileBlob = fileAndName[0]?.isEmpty??false ? null : fileAndName[0];
                name = fileAndName[1]?.isEmpty??false ? null : fileAndName[1];
              } catch (e) {
                fileBlob = null;
                name = null;
              }
              setState(() {});
            }),
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
        descriptionString?.trim();
        if (descriptionString == null || descriptionString!.isEmpty) {
          onError("Please enter description");
          return;
        }

        // presenter.createTickets(context, descriptionString ?? "", categoryString ?? "", subCategoryString ?? "", fileBlob);
      },
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    listOfSubCategory.clear();
    if (rmDetailResponse.values?.isNotEmpty ?? false)
      listOfSubCategory.addAll(rmDetailResponse?.values?.split(",")?.toList() ?? [""]);
    if (listOfSubCategory.isNotEmpty) {
      listOfSubCategory.removeLast();
      subCategoryString = listOfSubCategory.first;
    }
    setState(() {});
  }

  @override
  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse) {
    listOfCategory.clear();
    if (rmDetailResponse.values?.isNotEmpty ?? false) listOfCategory.addAll(rmDetailResponse?.values?.split(",") ?? [""]);
    if (listOfCategory.isNotEmpty) {
      listOfCategory.removeLast();

      String cat = listOfCategory.first;
      categoryString = cat;
      presenter.getTicketSubCategoryWithLoader(context, cat);
    }
    setState(() {});
  }

  @override
  void onTicketCreated(CreateTicketResponse rmDetailResponse) {
    Navigator.pop(context);
    headerTextController.value = Screens.kTicketsScreen;// close pop up
    Utility.showSuccessToastB(context, "Ticket Created");
    // _presenter.getTicketsWithoutLoader(context);
    // clearTicketDesc();
    setState(() {});
  }

  @override
  void onTicketFetched(TicketResponse rmDetailResponse) {}

  @override
  void onTicketReopened(ReopenResponse rmDetailResponse) {

  }
}
