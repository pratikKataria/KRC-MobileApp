import 'dart:io';

import 'package:flutter/material.dart';
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment", style: textStyleWhite14px600w),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        color: AppColors.white.withOpacity(0.35),
                        child: Text("200,000 Pay Now", style: textStyleWhite14px600w),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10.0),
                widgetCallGmail(),
                widgetSmsWhatsApp(),
                widgetDocumentAccountSum(),
                widgetImages(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row widgetImages() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConstructionImagesScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconImages),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              _modalBottomSheetRera();
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconRera),
            ),
          ),
        ),
      ],
    );
  }

  Row widgetDocumentAccountSum() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: AppColors.transparent,
            splashColor: AppColors.transparent,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconDocument),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              _modalBottomSheetMenu();
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconAccount),
            ),
          ),
        ),
      ],
    );
  }

  Row widgetSmsWhatsApp() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              String url = "sms:+91${_rmDetailResponse?.rmPhone}";
              await launch(url);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconSms),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              openWhatsapp(_rmDetailResponse?.rmPhone);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconWhats),
            ),
          ),
        ),
      ],
    );
  }

  Row widgetCallGmail() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              String url = "tel:+91${_rmDetailResponse?.rmPhone}";
              await launch(url);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconCall),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              // Android and iOS
              String uri = 'mailto:${_rmDetailResponse?.rmEmailID}?subject=%20&body=%20';
              await launch(uri);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconGmail),
            ),
          ),
        ),
      ],
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
          Consumer<BaseProvider>(
            builder: (context, provider, _) {
              if (provider.isOpen) {
                menuAnimController.forward();
              } else {
                menuAnimController.reverse();
              }
              return PmlButton(
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
                    print('is opened ${provider.isOpen}');
                    if (!provider.isOpen) {
                      provider.open();
                      menuAnimController.forward();
                    } else {
                      provider.close();
                      menuAnimController.reverse();
                    }
                  });
            },
          ),
          horizontalSpace(10.0),
          Spacer(),
          Image.asset(Images.kAppIcon, width: 50.0, height: 30.0),
          // KitButton(child: Image.asset(Images.kNotification, width: 24.0, height: 24.0, color: AppColors.lineColorGrey)),
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
}
