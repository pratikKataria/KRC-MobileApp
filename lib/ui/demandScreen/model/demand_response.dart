/// returnCode : true
/// responselist : [{"Total":null,"recordID":"a0H3C0000061J4XUAU","InvoiceNumber":101,"InvoiceName":"Inv-101"}]
/// message : "Success"

class DemandResponse {
  DemandResponse({
      bool? returnCode, 
      List<Responselist>? responselist, 
      String? message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  DemandResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist?.add(Responselist.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _returnCode;
  List<Responselist>? _responselist;
  String? _message;
DemandResponse copyWith({  bool? returnCode,
  List<Responselist>? responselist,
  String? message,
}) => DemandResponse(  returnCode: returnCode ?? _returnCode,
  responselist: responselist ?? _responselist,
  message: message ?? _message,
);
  bool? get returnCode => _returnCode;
  List<Responselist>? get responselist => _responselist;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responselist != null) {
      map['responselist'] = _responselist?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// Total : null
/// recordID : "a0H3C0000061J4XUAU"
/// InvoiceNumber : 101
/// InvoiceName : "Inv-101"

class Responselist {
  Responselist({
      dynamic total, 
      String? recordID, 
      num? invoiceNumber, 
      String? invoiceName,}){
    _total = total;
    _recordID = recordID;
    _invoiceNumber = invoiceNumber;
    _invoiceName = invoiceName;
}

  Responselist.fromJson(dynamic json) {
    _total = json['Total'];
    _recordID = json['recordID'];
    _invoiceNumber = json['InvoiceNumber'];
    _invoiceName = json['InvoiceName'];
  }
  dynamic _total;
  String? _recordID;
  num? _invoiceNumber;
  String? _invoiceName;
Responselist copyWith({  dynamic total,
  String? recordID,
  num? invoiceNumber,
  String? invoiceName,
}) => Responselist(  total: total ?? _total,
  recordID: recordID ?? _recordID,
  invoiceNumber: invoiceNumber ?? _invoiceNumber,
  invoiceName: invoiceName ?? _invoiceName,
);
  dynamic get total => _total;
  String? get recordID => _recordID;
  num? get invoiceNumber => _invoiceNumber;
  String? get invoiceName => _invoiceName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Total'] = _total;
    map['recordID'] = _recordID;
    map['InvoiceNumber'] = _invoiceNumber;
    map['InvoiceName'] = _invoiceName;
    return map;
  }

}