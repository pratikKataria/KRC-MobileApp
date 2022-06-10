import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';

abstract class ReceiptView extends BaseView {
  void onReceiptListFetched(ReceiptResponse receiptResponse);
}
