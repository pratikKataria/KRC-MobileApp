import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart';
import 'package:krc/ui/base/base_view.dart';

abstract class TicketView extends BaseView {
  void onTicketFetched(TicketResponse rmDetailResponse);
  void onTicketCreated(CreateTicketResponse rmDetailResponse);
}
