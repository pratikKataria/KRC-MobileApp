/// returnCode : true
/// message : "View Booking Details already generaed"
/// GenerateBookingDetails : true

class BillingDetailResponse {
  BillingDetailResponse({
      bool? returnCode, 
      String? message, 
      bool? generateBookingDetails,}){
    _returnCode = returnCode;
    _message = message;
    _generateBookingDetails = generateBookingDetails;
}

  BillingDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _generateBookingDetails = json['GenerateBookingDetails'];
  }
  bool? _returnCode;
  String? _message;
  bool? _generateBookingDetails;
BillingDetailResponse copyWith({  bool? returnCode,
  String? message,
  bool? generateBookingDetails,
}) => BillingDetailResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  generateBookingDetails: generateBookingDetails ?? _generateBookingDetails,
);
  bool? get returnCode => _returnCode;
  String? get message => _message;
  bool? get generateBookingDetails => _generateBookingDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['GenerateBookingDetails'] = _generateBookingDetails;
    return map;
  }

}