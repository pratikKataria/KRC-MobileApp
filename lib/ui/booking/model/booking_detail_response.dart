/// returnCode : true
/// responselist : [{"value":"INR 555","fieldname":"Agreement Value"},{"value":"INR 1000000","fieldname":"Unit Cost"},{"value":"INR 5555","fieldname":"AHU Charges-S"},{"value":"INR 14111111","fieldname":"Budget of Customer"},{"value":"INR 153","fieldname":"BMC Corp Deposit-S"},{"value":"INR 22","fieldname":"Brokerage-ZD"},{"value":"INR 111","fieldname":"Brokerage-ZC"},{"value":"INR 333","fieldname":"Brokerage-ZE"},{"value":"INR 333","fieldname":"Brokerage-ZB"},{"value":"INR 333","fieldname":"ClubHouse Deposit-S"},{"value":"INR 444","fieldname":"Condominium Deposit-S"},{"value":"INR 444","fieldname":"CorpusFund-S"},{"value":"INR null","fieldname":"ElectricMeter Deposit-S"},{"value":"INR 552","fieldname":"GST AntiProfit Discount"},{"value":"INR 123","fieldname":"Interest UnitCost-S"},{"value":"INR 756","fieldname":"Additional CGST"},{"value":"INR 456","fieldname":"Additional SGST"},{"value":"INR 789","fieldname":"LandCost-S"},{"value":"INR 1213","fieldname":"Sales Discount"},{"value":"INR 10144","fieldname":"UnitCost Discount"},{"value":"INR 1415","fieldname":"Registration Charges"},{"value":"INR 1819","fieldname":"ShareMoney-S"},{"value":"INR 2021","fieldname":"Society Deposit-S"},{"value":"INR 24245","fieldname":"Transfer Charges-S"},{"value":"INR 2829","fieldname":"AHU Contractual Work"},{"value":"INR 2223","fieldname":"StampDuty-S"},{"value":"INR 2627","fieldname":"AnnualSubc of Club"},{"value":"INR 3031","fieldname":"Advance Lease Rent"},{"value":"INR 3132","fieldname":"AHU Charges"},{"value":"INR 454","fieldname":"Cable Laying Charges"},{"value":"INR 454","fieldname":"ReDoc Charges"},{"value":"INR 454","fieldname":"CableTV Charges"},{"value":"INR 33435","fieldname":"ClubHouse Membership Charges"},{"value":"INR 4545","fieldname":"Electric SubStation Charges"},{"value":"INR 45454","fieldname":"Extra Amenities Charges"},{"value":"INR 4545","fieldname":"Reco FitoutSuppSer"},{"value":"INR 454","fieldname":"Extra Work"},{"value":"INR 4544","fieldname":"Forfeiture Charges"},{"value":"INR 4545","fieldname":"Garden Charges"},{"value":"INR 4545","fieldname":"Furniture Charges"},{"value":"INR 54545","fieldname":"Infrastructure Utilities"},{"value":"INR 545454","fieldname":"Legal Charges"},{"value":"INR 54545","fieldname":"Interest Unit Cost"},{"value":"INR 4545","fieldname":"Piped Gas Connection Charges"},{"value":"INR 54545","fieldname":"Miscellaneous Charges"},{"value":"INR 4545","fieldname":"Society Forma Charges"},{"value":"INR 4545","fieldname":"SwimmingPool Charges"},{"value":"INR 454","fieldname":"Transfer Charges"},{"value":"INR 4545","fieldname":"LandAbatement Charges"},{"value":"INR null","fieldname":"Electric Infra Charges"},{"value":"INR 12","fieldname":"CGST"},{"value":"INR 18","fieldname":"SGST"},{"value":"test coowner1","fieldname":"Co-Owner 1"},{"value":"test coowner 2","fieldname":"Co-Owner 2"},{"value":"co 3","fieldname":"Co-Owner 3"},{"value":null,"fieldname":"Co-Owner 4"},{"value":null,"fieldname":"Co-Owner 5"},{"value":null,"fieldname":"Co-Owner 6"}]
/// message : "Success"

class BookingDetailResponse {
  BookingDetailResponse({
      bool returnCode, 
      List<BookingDetailResponselist> responselist,
      String message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  BookingDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist.add(BookingDetailResponselist.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<BookingDetailResponselist> _responselist;
  String _message;

  bool get returnCode => _returnCode;
  List<BookingDetailResponselist> get responselist => _responselist;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responselist != null) {
      map['responselist'] = _responselist.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// value : "INR 555"
/// fieldname : "Agreement Value"

class BookingDetailResponselist {
  BookingDetailResponselist({
      String value, 
      String fieldname,}){
    _value = value;
    _fieldname = fieldname;
}

  BookingDetailResponselist.fromJson(dynamic json) {
    _value = json['value'];
    _fieldname = json['fieldname'];
  }
  String _value;
  String _fieldname;

  String get value => _value;
  String get fieldname => _fieldname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['fieldname'] = _fieldname;
    return map;
  }

}