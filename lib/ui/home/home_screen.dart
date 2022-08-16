import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krc/keys/drawer_key.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/document/document_screen.dart';
import 'package:krc/ui/home/home_presenter.dart';
import 'package:krc/ui/home/home_view.dart';
import 'package:krc/ui/home/model/project_detail_response.dart';
import 'package:krc/ui/home/model/rm_detail_response.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin implements HomeView {
  AnimationController menuAnimController;
  HomePresenter _homePresenter;
  ProjectDetailResponse projectDetailResponse;
  RmDetailResponse _rmDetailResponse;

  @override
  void initState() {
    super.initState();
    menuAnimController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _homePresenter = HomePresenter(this);
    _homePresenter.getProjectDetail(context);
    _homePresenter.getProfileDetailsNoLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                verticalSpace(20.0),
                Row(
                  children: [
                    // Image.asset(Images.kCircleRight, width: 50.0, height: 30.0),
                    Spacer(),
                    Text("${projectDetailResponse?.projectName ?? "Project Name"}", style: textStyleWhite16px600w),
                    Spacer(),
                    // Image.asset(Images.kCircleLeft, width: 50.0, height: 30.0),
                  ],
                ),
                verticalSpace(20.0),
                Image.memory(Utility.convertMemoryImage(projectDetailResponse?.projectImage), fit: BoxFit.fill),
                verticalSpace(20.0),
                Text("${projectDetailResponse?.projectName ?? "Project Name: "}", style: textStyleWhite16px600w),
                verticalSpace(10.0),
                Text("${projectDetailResponse?.projectDescription ?? ""}", style: textStyleWhite14px500w),
                verticalSpace(20.0),
                PmlButton(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: Color(0xFF439F48),
                  radius: 4.0,
                  borderColor: AppColors.white,
                  child: Center(child: Text("Pay Now : Rs. 200000", style: textStyleWhite14px600w)),
                ),
                verticalSpace(10.0),
                Wrap(
                  runSpacing: 40.0,
                  spacing: 40.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    cardViewItems(Images.kIconPhone, "Call", onCallButtonTapAction),
                    cardViewItems(Images.kIconChat, "Gmail", onEmailButtonTapAction),
                    cardViewItems(Images.kIconChat, "SMS", onSmsButtonTapAction),
                    cardViewItems(Images.kIconChat, "WHATS APP", onWhatsAppButtonTapAction),
                    cardViewItems(Images.kIconChat, "Document\nCenter", onDocumentButtonTapAction),
                    cardViewItems(Images.kIconChat, "Account\nSummary", onAccountButtonTapAction),
                    cardViewItems(Images.kIconChat, "Images", onImageButtonTapAction),
                    cardViewItems(Images.kIconChat, "RERA", onReraButtonTapAction),
                  ],
                ),
                // widgetCallGmail(),
                // widgetSmsWhatsApp(),
                // widgetDocumentAccountSum(),
                // widgetImages(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PmlButton cardViewItems(String icon, String text, Function() onTap) {
    return PmlButton(
      height: 110,
      width: 110,
      color: AppColors.lightGrey,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon , width: 44.0),
          Text(text.toUpperCase(), style: textStyle12px600w, textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  Container header() {
    var baseProvider = Provider.of<BaseProvider>(context);
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      height: 50,
      child: Row(
        children: [
          horizontalSpace(20.0),
          // Consumer<BaseProvider>(
          //   builder: (context, provider, _) {
          //     // if (provider.isOpen) {
          //     //   menuAnimController.forward();
          //     // } else {
          //     //   menuAnimController.reverse();
          //     // }
          //
          //     return ;
          //   },
          // ),
          PmlButton(
              height: 34.0,
              width: 34.0,
              color: AppColors.transparent,
              padding: EdgeInsets.only(top: 5.0),
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                color: AppColors.white,
                progress: menuAnimController,
              ) /* Image.asset(Images.kMenu, width: 24.0, height: 24.0)*/,
              onTap: () {
                drawerGlobalKey.currentState.openDrawer();
                // print('is opened ${provider.isOpen}');
                // if (!provider.isOpen) {
                //   provider.open();
                //   menuAnimController.forward();
                // } else {
                //   provider.close();
                //   menuAnimController.reverse();
                // }
              }),
          horizontalSpace(10.0),
          // PmlButton(
          //   color: AppColors.transparent,
          //   child: Image.asset(
          //     Images.kIconNotification,
          //     width: 20.0,
          //     height: 24.0,
          //     color: AppColors.white,
          //   ),
          // ),
          Spacer(),
          Image.asset(Images.kAppIcon, width: 50.0, height: 45.0),
          horizontalSpace(20.0),
          // KitButton(
          //     child: Image.asset(Images.kSearch, width: 24.0, height: 24.0),
          //     onTap: () => Navigator.pushNamed(context, Screens.kSearchScreen)),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(Images.kIconAccountSummary, width: 46, height: 46),
                        horizontalSpace(20.0),
                        Text("Account\nSummary", style: textStyleWhiteRegular18pxW700),
                      ],
                    ),
                    verticalSpace(20.0),
                    Text("Download Account summary of year 2021-22", style: textStyleWhite14px500w),
                    verticalSpace(20.0),
                    PmlButton(text: "Download"),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _modalBottomSheetRera() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(Images.kIconPlanRera, width: 46, height: 46),
                        horizontalSpace(20.0),
                        Text("Rera ID: ${projectDetailResponse?.reraId ?? "Not Found"}", style: textStyleWhiteRegular18pxW700),
                      ],
                    ),
                    verticalSpace(20.0),
                    PmlButton(
                      text: "VISIT",
                      onTap: () {
                        Utility.funcLunchUrl(this, projectDetailResponse?.reraWebsite);
                      },
                    ),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void onCallButtonTapAction() async {
    String url = "tel:+91${_rmDetailResponse?.rmPhone}";
    await launch(url);
  }

  void onEmailButtonTapAction() async {
    String uri = 'mailto:${_rmDetailResponse?.rmEmailID}?subject=%20&body=%20';
    await launch(uri);
  }

  void onSmsButtonTapAction() async {
    String url = "sms:+91${_rmDetailResponse?.rmPhone}";
    await launch(url);
  }

  void onWhatsAppButtonTapAction() async {
    openWhatsapp(_rmDetailResponse?.rmPhone);
  }

  void onDocumentButtonTapAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentScreen()));
  }

  void onAccountButtonTapAction() {
    _modalBottomSheetMenu();
  }

  void onImageButtonTapAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConstructionImagesScreen()));
  }

  void onReraButtonTapAction() {}

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectDetailFetched(ProjectDetailResponse projectDetailResponse) {
    this.projectDetailResponse = projectDetailResponse;
    _homePresenter.getRMDetails(context);
    setState(() {});
  }

  @override
  void onTokenRegenerated(TokenResponse tokenResponse) async {
    //Save token
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.tokenResponse = tokenResponse;
    AuthUser.getInstance().updateUser(currentUser);

    //sent request again
    _homePresenter.getProjectDetailS(context);
  }

  @override
  void onRmDetailFetched(RmDetailResponse rmDetailResponse) {
    _rmDetailResponse = rmDetailResponse;
    setState(() {});
  }

  openWhatsapp(String mobileNumber) async {
    var whatsapp = "+91${mobileNumber ?? ""}";
    var whatsappURl_android = "https://wa.me/$whatsapp/?text=hi";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if (mobileNumber == null) {
      Utility.showErrorToastB(context, "Mobile number not found");
      return;
    }

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Utility.showErrorToastB(context, "Whatsapp not installed");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        Utility.showErrorToastB(context, "Failed to open Whatsapp");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
    baseProvider.profileDetailResponse = profileDetailResponse;
  }
}
