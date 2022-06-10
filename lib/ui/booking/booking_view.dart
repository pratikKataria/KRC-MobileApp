import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/booking/model/booking_response.dart';

abstract class BookingView extends BaseView {
  void onBookingListFetched(BookingResponse profileDetailResponse);
}
