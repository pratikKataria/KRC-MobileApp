import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/document/model/document_response.dart';
import 'model/booking_response.dart';

abstract class DocumentView extends BaseView {
  void onBookingListFetched(BookingResponse profileDetailResponse);
  void onDocumentsFileFetched(DocumentResponse bookingResponse);
}
