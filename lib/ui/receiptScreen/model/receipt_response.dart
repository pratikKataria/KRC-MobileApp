/// returnCode : true
/// responselist : [{"ReceiptPDF":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001YwZm&d=%2Fa%2F3C000000I6xH%2FzC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ&asPdf=false","ReceiptNumber":206,"InvoiceNumber":123,"amount":5000}]
/// message : "Success"

class ReceiptResponse {
  ReceiptResponse({
      bool returnCode, 
      List<Responselist> responselist, 
      String message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  ReceiptResponse.fromJson(dynamic json) {
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

/// ReceiptPDF : "https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001YwZm&d=%2Fa%2F3C000000I6xH%2FzC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ&asPdf=false"
/// ReceiptNumber : 206
/// InvoiceNumber : 123
/// amount : 5000

class Responselist {
  Responselist({
      String receiptPDF, 
      int receiptNumber, 
      int invoiceNumber, 
      int amount,}){
    _receiptPDF = receiptPDF;
    _receiptNumber = receiptNumber;
    _invoiceNumber = invoiceNumber;
    _amount = amount;
}

  Responselist.fromJson(dynamic json) {
    _receiptPDF = json['ReceiptPDF'];
    _receiptNumber = json['ReceiptNumber'];
    _invoiceNumber = json['InvoiceNumber'];
    _amount = json['amount'];
  }
  String _receiptPDF;
  int _receiptNumber;
  int _invoiceNumber;
  int _amount;

  String get receiptPDF => _receiptPDF;
  int get receiptNumber => _receiptNumber;
  int get invoiceNumber => _invoiceNumber;
  int get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ReceiptPDF'] = _receiptPDF;
    map['ReceiptNumber'] = _receiptNumber;
    map['InvoiceNumber'] = _invoiceNumber;
    map['amount'] = _amount;
    return map;
  }

}