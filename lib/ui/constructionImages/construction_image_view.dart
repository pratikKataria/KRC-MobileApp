import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/constructionImages/model/construction_image_response.dart';

abstract class ConstructionImageView extends BaseView {
  void onConstructionImagesFetched(ConstructionImageResponse constructionImageResponse) {}
}
