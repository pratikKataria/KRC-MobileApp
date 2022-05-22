import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/home/model/project_detail_response.dart';

abstract class HomeView extends BaseView {
  void onProjectDetailFetched(ProjectDetailResponse projectDetailResponse);
}
