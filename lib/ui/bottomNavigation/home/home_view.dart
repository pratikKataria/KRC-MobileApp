import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/bottomNavigation/home/model/project_detail_response.dart';
 import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/user/token_response.dart';

import 'model/rm_detail_response.dart';

abstract class HomeView extends BaseView {
  void onProjectDetailFetched(ProjectDetailResponse projectDetailResponse);
  void onTokenRegenerated(TokenResponse tokenResponse);
  void onRmDetailFetched(RmDetailResponse rmDetailResponse);
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse);
}
