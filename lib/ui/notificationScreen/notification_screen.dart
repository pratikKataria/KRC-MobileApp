import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_presenter.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/user/login_response.dart' as login;
import 'notification_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<NotificationScreen> with TickerProviderStateMixin implements NotificationView {
  AnimationController? menuAnimController;
  late TabController _tabController = TabController(length: 0, vsync: this);

  late NotificationPresenter notificationPresenter;
  List<NotificationList> notificationList = [];
  List<login.AccountList> listOfAccounts = [];
  Map<String, List<NotificationList>> mapOfOpportunityIdAndReceipts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      listOfAccounts.addAll((currentUser?.userCredentials?.accountList ?? []));
      _tabController = TabController(length: listOfAccounts.length, vsync: this);
      mapOfOpportunityIdAndReceipts[listOfAccounts.first.accountID ?? ''] = notificationList;
      headerTextController.addListener(() {
        if (headerTextController.value == Screens.kNotificationScreen) {
          notificationPresenter = NotificationPresenter(this);
          if (listOfAccounts.isNotEmpty) notificationPresenter.getNotificationList(context, listOfAccounts.first.accountID ?? '');
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(   bottom: false,
        child: ListView(
          children: [
            verticalSpace(10.0),
            if (_tabController.length > 1) buildTabs(),
            verticalSpace(10.0),
            if (notificationList.isEmpty)
              Container(margin: EdgeInsets.only(top: 150.0), child: Center(child: Text("No Notification Present", style: textStyle14px500w))),
            ...notificationList.map<Widget>((e) => Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: cardViewNotification(e),
            )).toList(),
            /*    KRCListView(
              children: notificationList.map<Widget>((e) => cardViewBooking(e)).toList(),
            )*/
          ],
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

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      dividerHeight: 0,
      indicatorColor: AppColors.colorPrimary,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      onTap: (int index) async {
        String accountId = listOfAccounts[index].accountID ?? "";
        print("account id of selected tab is ${accountId}");
        notificationPresenter.getNotificationList(context, accountId);
        mapOfOpportunityIdAndReceipts[accountId] = notificationList;
        setState(() {});
        notificationList.clear();
      },
      tabs: [...listOfAccounts.map((e) => Tab(text: "${e.name}\n${e.mobile}"))],
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
