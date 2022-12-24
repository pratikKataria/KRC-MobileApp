import 'dart:async';
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
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin implements HomeView {
  late AnimationController menuAnimController;
  late HomePresenter _homePresenter;
  ProjectDetailResponse? projectDetailResponse;
  RmDetailResponse? _rmDetailResponse;

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
                // PmlButton(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   color: Color(0xFF439F48),
                //   radius: 4.0,
                //   borderColor: AppColors.white,
                //   child: Center(child: Text("Pay Now : Rs. 200000", style: textStyleWhite14px600w)),
                // ),
                verticalSpace(20.0),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardViewItems(Images.kIconPhone, "Call", onCallButtonTapAction),
                        horizontalSpace(20.0),
                        cardViewItems(Images.kIconGmail, "Gmail", onEmailButtonTapAction),
                      ],
                    ),
                    verticalSpace(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardViewItems(Images.kIconChat, "SMS", onSmsButtonTapAction),
                        horizontalSpace(20.0),
                        cardViewItems(Images.kIconWhats, "WHATS APP", onWhatsAppButtonTapAction),
                      ],
                    ),
                    verticalSpace(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardViewItems(Images.kIconDocument, "Document\nCenter", onDocumentButtonTapAction),
                        horizontalSpace(20.0),
                        cardViewItems(Images.kIconAccount, "Account\nSummary", onAccountButtonTapAction),
                      ],
                    ),
                    verticalSpace(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardViewItems(Images.kIconImages, "Images", onImageButtonTapAction),
                        horizontalSpace(20.0),
                        cardViewItems(Images.kIconRera, "RERA", onReraButtonTapAction),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Expanded cardViewItems(String icon, String text, Function() onTap) {
    return Expanded(
      child: PmlButton(
        height: 110,
        color: AppColors.lightGrey.withOpacity(0.5),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 38.0, color: AppColors.white),
            verticalSpace(16.0),
            Text(text.toUpperCase(), style: textStyleWhite12px500w, textAlign: TextAlign.center),
          ],
        ),
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
                drawerGlobalKey.currentState!.openDrawer();
                BaseProvider provider = Provider.of(context, listen: false);
                provider.open();

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

  void onReraButtonTapAction() {
    launch("${projectDetailResponse!.reraWebsite}");
  }

  @override
  onError(String? message) {
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
    var currentUser = await (AuthUser.getInstance().getCurrentUser() as FutureOr<CurrentUser>);
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

  openWhatsapp(String? mobileNumber) async {
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
      try {
        await launch(whatsappURl_android);
      } catch (xe) {
        onError(xe.toString());
      }
    }
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
    baseProvider.profileDetailResponse = profileDetailResponse;
  }
}
