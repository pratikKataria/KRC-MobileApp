import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';

abstract class ProfileView extends BaseView {
  void onProfileUploaded();
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse);
}
