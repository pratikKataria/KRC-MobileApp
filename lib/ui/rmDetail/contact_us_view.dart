import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';

abstract class ContactUsView extends BaseView {
  void onRmDetailFetched(RmDetailResponse rmDetailResponse);
}
