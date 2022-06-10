import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';

abstract class DemandView extends BaseView {
  void onDemandListFetched(DemandResponse receiptResponse);
}
