import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/ui/document_screen.dart';
import 'package:krc/ui/home/home_presenter.dart';
import 'package:krc/ui/home/home_view.dart';
import 'package:krc/ui/home/model/project_detail_response.dart';
import 'package:krc/ui/image_screen.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin implements HomeView {
  AnimationController menuAnimController;
  ProjectDetailResponse projectDetailResponse;
  HomePresenter _homePresenter;

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
                    Text("${projectDetailResponse?.projectName??"Project Name"}", style: textStyleWhite16px600w),
                    Spacer(),
                    // Image.asset(Images.kCircleLeft, width: 50.0, height: 30.0),
                  ],
                ),
                verticalSpace(20.0),

                Image.memory(Utility.convertMemoryImage(projectDetailResponse?.projectImage), fit: BoxFit.fill),
                verticalSpace(20.0),
                Text("${projectDetailResponse?.projectName??"Project Name: "}", style: textStyleWhite16px600w),
                verticalSpace(10.0),
                Text("${projectDetailResponse?.projectDescription??""}", style: textStyleWhite14px500w),
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(Images.kIconImages),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
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
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(Images.kIconSms),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(Images.kIconWhats),
          ),
        ),
      ],
    );
  }

  Row widgetCallGmail() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(Images.kIconCall),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(Images.kIconGmail),
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
                print('is opened ${baseProvider.isOpen}');
                if (!baseProvider.isOpen) {
                  baseProvider.open();
                  menuAnimController.forward();
                } else {
                  baseProvider.close();
                  menuAnimController.reverse();
                }
              }),
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

  String s = """Apartments in West Pune | New Launch in West Pune – Raheja 
Nova Nestled amid the magnificent Sahyadri 60+ species of birds flock 
together here. Let’s take a glance 
at a few of its most impressive 
features:

Better AQI Index – The air here is 
94% cleaner* as compared to other city pockets. What more can a fitness enthusiast wish for?3 degree^ cooler temperatureLow decibel levels – With 47% less noise* than the permissible limits, Nova at Raheja Viva is the perfect place to relish rendezvous with your soul and 
discover the bliss of solitude.""";

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectDetailFetched(ProjectDetailResponse projectDetailResponse) {
    this.projectDetailResponse = projectDetailResponse;
    setState(() {});
  }
}
