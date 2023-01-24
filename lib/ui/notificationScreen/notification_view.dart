import 'package:krc/ui/base/base_view.dart';

import 'model/notification_response.dart';

abstract class NotificationView extends BaseView {
  void onNotificationListFetched(NotificationResponse notificationResponse);
  void onNotificationRead(String? type);
}
