import 'package:krc/ui/Ticket/model/create_ticket_response.dart';
import 'package:krc/ui/Ticket/model/reopen_response.dart';
import 'package:krc/ui/Ticket/model/ticket_category_response.dart';
import 'package:krc/ui/Ticket/model/ticket_response.dart';
import 'package:krc/ui/base/base_view.dart';

abstract class TicketView extends BaseView {
  void onTicketFetched(TicketResponse rmDetailResponse);

  void onTicketCreated(CreateTicketResponse rmDetailResponse);

  void onTicketCategoryFetched(TicketCategoryResponse rmDetailResponse);

  void onSubCategoryFetched(TicketCategoryResponse rmDetailResponse);
  void onTicketReopened(ReopenResponse rmDetailResponse);
}
