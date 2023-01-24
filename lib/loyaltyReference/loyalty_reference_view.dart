import 'package:krc/ui/base/base_view.dart';
import 'model/all_lead_response.dart';
import 'model/loyalty_reference_response.dart';
import 'model/picklist_value_Response.dart';

abstract class LoyaltyReferenceView extends BaseView {
  void onClientRefered(LoyaltyReferenceResponse loyaltyReferenceResponse);
  void onPickListValueFetched(List<PicklistValueResponse> list);
  void onAllLeadFetched(AllLeadResponse response);
}
