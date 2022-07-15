import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_presenter.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';

import 'notification_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<NotificationScreen> implements NotificationView {
  AnimationController menuAnimController;

  NotificationPresenter bookingPresenter;
  List<NotificationList> notificationList = [];

  @override
  void initState() {
    super.initState();
    bookingPresenter = NotificationPresenter(this);
    bookingPresenter.getBookingList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Notifications"),
            verticalSpace(20.0),
            KRCListView(
              children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )
          ],
        ),
      ),
    );
  }

  cardViewBooking(NotificationList responseList) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        navigateToSpecificScreen(responseList?.type??"");
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
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onNotificationListFetched(NotificationResponse notificationResponse) {
    notificationList.clear();
    notificationList.addAll(notificationResponse.notificationList);
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
}
