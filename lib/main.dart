import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/controller/navigator_controller.dart';
import 'package:krc/loyaltyReference/loyalty_reference_detail_screen.dart';
import 'package:krc/loyaltyReference/loyalty_reference_screen.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Strings.dart';
import 'package:krc/ui/Ticket/create_new_ticket.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/booking/booking_detail_screen.dart';
import 'package:krc/ui/bottomNavigation/bottom_navigation_base_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/core/login/login_screen.dart';
import 'package:krc/ui/core/termsAndCondition/terms_and_condition_screen.dart';
import 'package:krc/ui/demandScreen/demand_screen.dart';
import 'package:krc/ui/document/document_screen.dart';
import 'package:krc/ui/faq/FAQScreen.dart';
import 'package:krc/ui/notificationScreen/notification_screen.dart';
import 'package:krc/ui/ongoingProject/ongoing_project_screen.dart';
import 'package:krc/ui/oustandingPaymentScreen/outstanding_payment_screen.dart';
import 'package:krc/ui/profile/profile_screen.dart';
import 'package:krc/ui/quickPayScreen/quick_pay_screen.dart';
import 'package:krc/ui/receiptScreen/receipt_screen.dart';
import 'package:krc/ui/rmDetail/contact_us_screen.dart';
import 'package:krc/ui/uploadTDS/upload_tds_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/scroll_behavior.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'res/RouteTransition.dart';
import 'res/Screens.dart';
import 'ui/base/BaseWidget.dart';
import 'utils/Utility.dart';
import 'utils/push_notification_service.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'a', // id
    'High Importance Notifications', // title
    showBadge: true,
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Utility.statusBarAndNavigationBarColor();
  Utility.portrait();

  // await Firebasep.initializeApp();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA9PpNpiNMkyI0nnxnjgboSHLji_2jqnqw",
            appId: "1:970701622319:ios:124e18c9d426b905030ada",
            messagingSenderId: "970701622319",
            projectId: "cp-mobile-app-a7646"));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_app_logo',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [NotificationChannelGroup(channelGroupName: 'Basic group', channelGroupKey: 'basic_channel_group')],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  await PushNotificationService().setupInteractedMessage();

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();
  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp(authResult));
}

class MyApp extends StatelessWidget {
  final bool authResult;

  const MyApp(this.authResult, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: kAppName,
      theme: ThemeData(primarySwatch: AppColors.primaryColorShades ,scaffoldBackgroundColor: AppColors.screenBackgroundColor),
      navigatorKey: navigatorController,
      builder: (_, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          // child: child!,
          child: BaseWidget(child: child!),
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        headerTextController.value = settings.name!;

        switch (settings.name) {
          case "/":
            return RouteTransition(widget: Container());
          case Screens.kHomeScreen:
            return RouteTransition(widget: BottomNavigationBaseScreen());
          case Screens.kQuickPayScreen:
            return RouteTransition(widget: QuickPayScreen());
          case Screens.kTicketsScreen:
            return RouteTransition(widget: TicketScreen());
          case Screens.kContactUsScreen:
            return RouteTransition(widget: ContactUsScreen());
          case Screens.kNotificationScreen:
            return RouteTransition(widget: NotificationScreen());
          case Screens.kContactUsScreen:
            return RouteTransition(widget: ContactUsScreen());
          case Screens.kDocumentScreen:
            return RouteTransition(widget: DocumentScreen());
          case Screens.kConstructionUpdateScreen:
            return RouteTransition(widget: ConstructionImagesScreen());
          case Screens.kOutstandingPayment:
            return RouteTransition(widget: OutstandingPaymentsScreen());
          case Screens.kDemandScreen:
            return RouteTransition(widget: DemandScreen());
          case Screens.kReceiptScreen:
            return RouteTransition(widget: ReceiptScreen());
          case Screens.kProfileScreen:
            return RouteTransition(widget: ProfileScreen());
          case Screens.kFaqScreen:
            return RouteTransition(widget: FAQScreen());
          case Screens.kOngoingScreen:
            return RouteTransition(widget: OngoingProjectScreen());
          case Screens.kCreateTicketsScreen:
            return RouteTransition(widget: CreateNewTicket());
          case Screens.kTermsAndConditions:
            return RouteTransition(widget: TermsAndConditionScreen());
          case Screens.kBookingDetailScreen:
            return RouteTransition(widget: BookingDetailScreen());
          case Screens.kLoyaltyReferenceScreen:
            return RouteTransition(widget: LoyaltyReferenceScreen());
          case Screens.kReferFriendScreen:
            return RouteTransition(widget: LoyaltyReferenceDetailScreen());
          case Screens.kUploadTDSScreen:
            return RouteTransition(widget: TDSScreen());
          default:
            return RouteTransition(widget: LoginScreen());
        }
      },
      home: checkAuthUser(authResult),
    );
  }

  checkAuthUser(authResult) {
    if (authResult) {
      return BottomNavigationBaseScreen();
    } else {
      return LoginScreen();
    }
  }

  void RegisterFirebaseNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("Message Received: ${message.data}");

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                icon: '@mipmap/ic_launcher_foreground',
              ),
            ));
      }
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )));
  }
}