import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_presenter.dart';
import 'package:krc/utils/Utility.dart';

import 'notification_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<NotificationScreen> implements NotificationView {
  AnimationController? menuAnimController;

  late NotificationPresenter notificationPresenter;
  List<NotificationList> notificationList = [];

  @override
  void initState() {
    super.initState();
    notificationPresenter = NotificationPresenter(this);

    headerTextController.addListener(() {
      if (headerTextController.value == Screens.kNotificationScreen) {
        notificationPresenter.getNotificationList(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              if (notificationList.isEmpty)
                Container(margin: EdgeInsets.only(top: 150.0), child: Center(child: Text("No Notification Present", style: textStyle14px500w))),
              ...notificationList.map<Widget>((e) => cardViewNotification(e)).toList(),
              /*    KRCListView(
                children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  InkWell cardViewNotification(NotificationList responseList) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        notificationPresenter.readNotification(context, responseList?.notificationID, responseList?.type);
      },
      child: Column(
        children: [
          verticalSpace(20.0),
          Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
              ),
              horizontalSpace(20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${responseList?.title}", style: textStyle14px500w),
                    Text("${responseList?.body}", style: textStyleSubText14px500w),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(20.0),
          line(),
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
    notificationList.clear();
    notificationList.addAll(notificationResponse.notificationList!);
    setState(() {});
  }

  void navigateToSpecificScreen(String type) {
    switch (type.toLowerCase()) {
      case "invoice":
        navigate(Screens.kDemandScreen);
        break;
      case "receipt":
        navigate(Screens.kReceiptScreen);
        break;
      case "construction image":
        navigate(Screens.kConstructionUpdateScreen);
        break;
      case "ticket":
        headerTextController.value = Screens.kTicketsScreen;
        // navigate(Screens.kTicketsScreen);
        break;
      default:
        // do nothing
        break;
    }
  }

  void navigate(String toScreen) {
    Navigator.pushNamed(context, toScreen);
  }

  @override
  void onNotificationRead(String? type) {
    navigateToSpecificScreen(type ?? "");
    notificationPresenter.getNotificationListWithoutLoader(context);
    setState(() {});
  }
}
