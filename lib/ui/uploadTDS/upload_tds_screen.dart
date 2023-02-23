import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/booking/booking_presenter.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/ui/uploadTDS/model/upload_tds_request.dart';
import 'package:krc/ui/uploadTDS/upload_ds_view.dart';
import 'package:krc/ui/uploadTDS/upload_tds_presenter.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/hrm_input_fields_dummy.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:flutter/services.dart';

class TDSScreen extends StatefulWidget {
  const TDSScreen({Key? key}) : super(key: key);

  @override
  _TDSScreenState createState() => _TDSScreenState();
}

class _TDSScreenState extends State<TDSScreen> implements UploadTDSView {
  AnimationController? menuAnimController;
  BookingPresenter? bookingPresenter;
  List<Responselist> bookingList = [];
  List<String> years = [];
  UploadTdsRequest uploadTdsRequest = UploadTdsRequest();
  late UploadTdsPresenter presenter;
  String fileName = "";

  @override
  void initState() {
    super.initState();

    presenter = UploadTdsPresenter(this);

    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int minYear = year - 10;
    uploadTdsRequest.fYYear = "${year - 1}";
    for (int i = 1; i < 11; i++) years.add("${minYear + i}");
    uploadTdsRequest.transactionDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
           children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20.0),
                  //Add Ack number
                  Text("Acknowledgement Number", style: textStyle14px500w),
                  verticalSpace(4.0),
                  Container(
                    color: AppColors.inputFieldBackgroundColor2,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      // controller: emailTextController,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.none,
                      style: textStyle14px500w,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Acknowledgment number",
                        hintStyle: textStyle14px500w,
                        suffixStyle: TextStyle(color: AppColors.textColor),
                      ),
                      onChanged: (String val) {
                        uploadTdsRequest.acknowledgementNumber = val;
                      },
                    ),
                  ),

                  //Add Comment
                  verticalSpace(20.0),
                  Text("Comment", style: textStyle14px500w),
                  verticalSpace(4.0),
                  Container(
                    color: AppColors.inputFieldBackgroundColor2,
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      obscureText: false,
                      textAlign: TextAlign.left,
                      // controller: emailTextController,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.none,
                      style: textStyle14px500w,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your comment",
                        hintStyle: textStyle14px500w,
                        suffixStyle: TextStyle(color: AppColors.textColor),
                      ),
                      onChanged: (String val) {
                        uploadTdsRequest.comments = val;
                      },
                    ),
                  ),

                  //TDS amount and Total Transaction
                  verticalSpace(20.0),
                  Row(
                    children: [
                      // TDS Amount
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tds Amount", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Container(
                              color: AppColors.inputFieldBackgroundColor2,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                obscureText: false,
                                textAlign: TextAlign.left,
                                // controller: emailTextController,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                textCapitalization: TextCapitalization.none,
                                style: textStyle14px500w,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]+')),],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter amount",
                                  hintStyle: textStyle14px500w,
                                  suffixStyle: TextStyle(color: AppColors.textColor),
                                ),
                                onChanged: (String val) {
                                  uploadTdsRequest.comments = val;
                                  uploadTdsRequest.tdsAmount = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      horizontalSpace(10.0),

                      //Total Transaction
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Transaction", style: textStyle14px500w),
                            verticalSpace(4.0),
                            Container(
                              color: AppColors.inputFieldBackgroundColor2,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                obscureText: false,
                                textAlign: TextAlign.left,
                                // controller: emailTextController,
                                maxLines: 1,
                                textCapitalization: TextCapitalization.none,
                                style: textStyle14px500w,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]+')),],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Trans. amount",
                                  hintStyle: textStyle14px500w,
                                  suffixStyle: TextStyle(color: AppColors.textColor),
                                ),
                                onChanged: (String val) {
                                  uploadTdsRequest.comments = val;
                                  uploadTdsRequest.totalTransaction = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      //FYYear
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(20.0),
                          Text("FYYear", style: textStyle14px500w),
                          Container(
                            color: AppColors.inputFieldBackgroundColor2,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropdownButton<String>(
                              value: uploadTdsRequest.fYYear,
                              style: textStyleDark16px600w,
                              dropdownColor: AppColors.inputFieldBackgroundColor2,
                              items: years.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {
                                // val = _;
                                uploadTdsRequest.fYYear = _;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      horizontalSpace(20.0),

                      //FYYear
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(20.0),
                          Text("TransactionDate", style: textStyle14px500w),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              color: AppColors.inputFieldBackgroundColor2,
                              height: 47.0,
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(child: Text("${uploadTdsRequest.transactionDate}", style: textStyleDark16px600w)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //PDF file button
                  verticalSpace(20.0),
                  HrmInputFieldDummy(headingText: "File: $fileName", text: "Select TDS File").onClick(() async {
                    List<String?> file = await Utility.pickFile(context);
                    String? fileBytes = file[0];
                    String? name = file[1];

                    if (name != null) fileName = "$name";
                    if (fileBytes != null) uploadTdsRequest.tdspdf = fileBytes;
                    setState(() {});

                    print(name);
                    // widget.request.lISTofDirectors = fileBytes;
                    // directorsFileName = name;
                    // setState(() {});
                  }),
                ],
              ),
            ),

            Spacer(),

            //PDF file button
            verticalSpace(20.0),
            PmlButton(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              text: "Upload",
              onTap: () async {
                FocusScope.of(context).unfocus();
                 presenter.uploadTdsDocument(context, uploadTdsRequest);
              },
            )
          ],
        ),
      ),
    );
  }

  cardViewBooking(Responselist responselist) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _modalBottomSheetMenu(responselist);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("${responselist?.tower}", style: textStyleWhite14px600w),
          // Text("Unit No - ${responselist?.unitNo}", style: textStyleWhite14px600w),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime time = DateTime(2010);
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: time,
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      uploadTdsRequest.transactionDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      setState(() {});
      // _selectTime(context, picked);
    }
  }

  void _modalBottomSheetMenu(Responselist responselist) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: AppColors.cardColorDark2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("${responselist?.tower}", style: textStyle14px500w),
                      verticalSpace(10.0),
                      // Text(
                      // "${responselist?.projectDescription}",
                      // style: textStyleSubText14px500w,
                      // ),
                      verticalSpace(10.0),
                      Container(
                        height: 300.0,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          radius: Radius.circular(10.0),
                          interactive: true,
                          hoverThickness: 20.0,
                          child: ListView(
                            children: [
                              ...textBuilder(responselist.toJson()),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(10.0),
                      PmlButton(
                        text: "UPLOAD TDS",
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<RichText> textBuilder(Map<String, dynamic> response) {
    List<RichText> richTextList = [];
    for (String key in response.keys) {
      if (key != "ProjectDescription" && response[key] != null) {
        richTextList.add(RichText(
          text: TextSpan(
            text: "$key : ",
            style: textStyleSubText12px600w,
            children: [
              TextSpan(text: "${response[key]}", style: textStyleWhite12px700w),
              WidgetSpan(child: verticalSpace(20.0)),
            ],
          ),
        ));
      }
    }
    return richTextList;
  }

  @override
  void onBookingListFetched(BookingResponse profileDetailResponse) {
    bookingList.clear();
    bookingList.addAll(profileDetailResponse.responselist!);
    setState(() {});
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onTdsUploaded() {
    Navigator.pop(context);
    Utility.showSuccessToastB(context, "Tds Uploaded");
  }
}
