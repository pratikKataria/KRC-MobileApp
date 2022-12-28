import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_presenter.dart';
import 'package:krc/ui/notificationScreen/notification_view.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
import 'package:krc/utils/Utility.dart';

class OngoingProjectScreen extends StatefulWidget {
  const OngoingProjectScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<OngoingProjectScreen> implements NotificationView {
  AnimationController? menuAnimController;

  late NotificationPresenter notificationPresenter;
  List<NotificationList> notificationList = [];

  @override
  void initState() {
    super.initState();
    notificationPresenter = NotificationPresenter(this);
    // notificationPresenter.getNotificationList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20.0),
            cardViewBooking(),
            cardViewBooking(),
            /*    KRCListView(
              children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )*/
          ],
        ),
      ),
    );
  }

  InkWell cardViewBooking() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Placeholder(fallbackHeight: 150.0),
              Positioned(right: 16.0, top: 16.0, child: Image.asset(Assets.imagesIcShareLink, width: 28.0)),
            ],
          ),
          verticalSpace(20.0),
          Text("Raheja Stellar", style: textStyle14px500w),
          Text("Ultra luxe 4 & 3 bed residences in Pune, NIBM – Raheja Stellar", style: textStyle14px500w),
          verticalSpace(20.0),
          line(),
          verticalSpace(20.0),
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
