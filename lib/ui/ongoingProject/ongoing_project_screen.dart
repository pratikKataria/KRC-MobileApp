import 'package:flutter/material.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_view.dart';
import 'package:krc/ui/ongoingProject/model/ongoing_project_response.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';

class OngoingProjectScreen extends StatefulWidget {
  const OngoingProjectScreen({Key? key}) : super(key: key);

  @override
  _OngoingProjectState createState() => _OngoingProjectState();
}

class _OngoingProjectState extends State<OngoingProjectScreen> implements NotificationView {
  List<UpcomingProjecList> listOfBanks = [];

  @override
  void initState() {
    super.initState();
    getOngoingProjectDetail();
    // notificationPresenter.getNotificationList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            verticalSpace(20.0),
            // cardViewBooking(),
            // cardViewBooking(),
            ...listOfBanks.map((e) => cardViewBooking(e)).toList(),
            //     KRCListView(
            //   children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
            // )
          ],
        ),
      ),
    );
  }

  InkWell cardViewBooking(UpcomingProjecList e) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.memory(Utility.convertMemoryImage(e.projectImage), height: 150.0),
              Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: Image.asset(Assets.imagesIcShareLink, width: 28.0).onClick(() {
                    Utility.launchUrlX(context, e.website);
                  })),
            ],
          ),
          verticalSpace(10.0),
          Text(e.projectName ?? "", style: textStyle14px600w),
          Text(e.description ?? "", style: textStyle14px500w),
          verticalSpace(30.0),
          line(),
          verticalSpace(30.0),
        ],
      ),
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onNotificationListFetched(NotificationResponse notificationResponse) {
    // notificationList.clear();
    // notificationList.addAll(notificationResponse.notificationList!);
    setState(() {});
  }

  void navigateToSpecificScreen(String type) {
    switch (type.toLowerCase()) {
      case "invoice":
        navigate(DemandScreen());
        break;
      case "receipt":
        navigate(ReceiptScreen());
        break;
      case "construction image":
        navigate(ConstructionImagesScreen());
        break;
      case "ticket":
        navigate(TicketScreen());
        break;
      default:
        // do nothing
        break;
    }
  }

  void navigate(Widget toScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => toScreen));
  }

  @override
  void onNotificationRead(String? type) {
    navigateToSpecificScreen(type ?? "");
    // notificationPresenter.getNotificationListWithoutLoader(context);
  }

  void getOngoingProjectDetail() async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"accountID": "a0B3C000005S7KnUAK"};

    Dialogs.showLoader(context, "Getting ongoing project ...");
    apiController.post(EndPoints.POST_ONGOING_PROJECT, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        OngoingProjectResponse quickPayResponse = OngoingProjectResponse.fromJson(response.data);
        if (quickPayResponse.returnCode ?? false) {
          setState(() {
            listOfBanks.addAll(quickPayResponse.upcomingProjecList ?? []);
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
