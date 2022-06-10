/// returnCode : true
/// responselist : [{"Total":1100000000,"paymentAgainst8":"sample8","paymentAgainst7":"sample7","paymentAgainst6":"booking amount","paymentAgainst5":"other tax amount","paymentAgainst4":"sgst amount","paymentAgainst3":"cgst amount","paymentAgainst2":"AMU amount","paymentAgainst1":"booking amount","InvoicePDf":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001Yve6&d=%2Fa%2F3C000000I6wY%2FlD1FKT6HfAJxfM.bFYtyJmCoUttLVxMi3RJHd7xq_2U&asPdf=false","InvoiceNumber":11115}]
/// message : "Success"

class DemandResponse {
  DemandResponse({
      bool returnCode, 
      List<Responselist> responselist, 
      String message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  DemandResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist.add(Responselist.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<Responselist> _responselist;
  String _message;

  bool get returnCode => _returnCode;
  List<Responselist> get responselist => _responselist;
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

/// Total : 1100000000
/// paymentAgainst8 : "sample8"
/// paymentAgainst7 : "sample7"
/// paymentAgainst6 : "booking amount"
/// paymentAgainst5 : "other tax amount"
/// paymentAgainst4 : "sgst amount"
/// paymentAgainst3 : "cgst amount"
/// paymentAgainst2 : "AMU amount"
/// paymentAgainst1 : "booking amount"
/// InvoicePDf : "https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001Yve6&d=%2Fa%2F3C000000I6wY%2FlD1FKT6HfAJxfM.bFYtyJmCoUttLVxMi3RJHd7xq_2U&asPdf=false"
/// InvoiceNumber : 11115

class Responselist {
  Responselist({
      int total, 
      String paymentAgainst8, 
      String paymentAgainst7, 
      String paymentAgainst6, 
      String paymentAgainst5, 
      String paymentAgainst4, 
      String paymentAgainst3, 
      String paymentAgainst2, 
      String paymentAgainst1, 
      String invoicePDf, 
      int invoiceNumber,}){
    _total = total;
    _paymentAgainst8 = paymentAgainst8;
    _paymentAgainst7 = paymentAgainst7;
    _paymentAgainst6 = paymentAgainst6;
    _paymentAgainst5 = paymentAgainst5;
    _paymentAgainst4 = paymentAgainst4;
    _paymentAgainst3 = paymentAgainst3;
    _paymentAgainst2 = paymentAgainst2;
    _paymentAgainst1 = paymentAgainst1;
    _invoicePDf = invoicePDf;
    _invoiceNumber = invoiceNumber;
}

  Responselist.fromJson(dynamic json) {
    _total = json['Total'];
    _paymentAgainst8 = json['paymentAgainst8'];
    _paymentAgainst7 = json['paymentAgainst7'];
    _paymentAgainst6 = json['paymentAgainst6'];
    _paymentAgainst5 = json['paymentAgainst5'];
    _paymentAgainst4 = json['paymentAgainst4'];
    _paymentAgainst3 = json['paymentAgainst3'];
    _paymentAgainst2 = json['paymentAgainst2'];
    _paymentAgainst1 = json['paymentAgainst1'];
    _invoicePDf = json['InvoicePDf'];
    _invoiceNumber = json['InvoiceNumber'];
  }
  int _total;
  String _paymentAgainst8;
  String _paymentAgainst7;
  String _paymentAgainst6;
  String _paymentAgainst5;
  String _paymentAgainst4;
  String _paymentAgainst3;
  String _paymentAgainst2;
  String _paymentAgainst1;
  String _invoicePDf;
  int _invoiceNumber;

  int get total => _total;
  String get paymentAgainst8 => _paymentAgainst8;
  String get paymentAgainst7 => _paymentAgainst7;
  String get paymentAgainst6 => _paymentAgainst6;
  String get paymentAgainst5 => _paymentAgainst5;
  String get paymentAgainst4 => _paymentAgainst4;
  String get paymentAgainst3 => _paymentAgainst3;
  String get paymentAgainst2 => _paymentAgainst2;
  String get paymentAgainst1 => _paymentAgainst1;
  String get invoicePDf => _invoicePDf;
  int get invoiceNumber => _invoiceNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Total'] = _total;
    map['paymentAgainst8'] = _paymentAgainst8;
    map['paymentAgainst7'] = _paymentAgainst7;
    map['paymentAgainst6'] = _paymentAgainst6;
    map['paymentAgainst5'] = _paymentAgainst5;
    map['paymentAgainst4'] = _paymentAgainst4;
    map['paymentAgainst3'] = _paymentAgainst3;
    map['paymentAgainst2'] = _paymentAgainst2;
    map['paymentAgainst1'] = _paymentAgainst1;
    map['InvoicePDf'] = _invoicePDf;
    map['InvoiceNumber'] = _invoiceNumber;
    return map;
  }

}