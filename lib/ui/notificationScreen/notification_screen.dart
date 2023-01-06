import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_presenter.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
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
    notificationPresenter.getNotificationList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Column(
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
                        child: Text(
                          "New offers for Krc north Tower coming soon. Stay tuned to know more.",
                          style: textStyle14px500w,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  line(),
                ],
              ),
              Column(
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
                        child: Text(
                          "New offers for Krc north Tower coming soon. Stay tuned to know more.",
                          style: textStyle14px500w,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  line(),
                ],
              ),
              /*    KRCListView(
                children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  InkWell cardViewBooking(NotificationList responseList) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        notificationPresenter.readNotification(context, responseList?.notificationID, responseList?.type);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${responseList?.title}", style: textStyleWhite14px600w),
          Text("${responseList?.body}", style: textStyleWhite12px500w),
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
    notificationPresenter.getNotificationListWithoutLoader(context);
  }
}
