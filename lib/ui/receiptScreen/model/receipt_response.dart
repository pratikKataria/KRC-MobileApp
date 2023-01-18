/// returnCode : true
/// responselist : [{"ViewReceiptPDF":"https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/sfc/p/3C0000004x3c/a/3C000000I6xH/zC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ","RecordID":"a033C000003irGoQAI","ReceiptNumber":206,"ReceiptDate":"09/06/2022","Receipt_Name":"a033C000003irGo","InvoiceNumber":"","DownloadReceiptPDF":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001YwZm&d=%2Fa%2F3C000000I6xH%2FzC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ&asPdf=false","amount":5000}]
/// message : "Success"

class ReceiptResponse {
  ReceiptResponse({
      bool? returnCode, 
      List<Responselist>? responselist, 
      String? message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  ReceiptResponse.fromJson(dynamic json) {
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
ReceiptResponse copyWith({  bool? returnCode,
  List<Responselist>? responselist,
  String? message,
}) => ReceiptResponse(  returnCode: returnCode ?? _returnCode,
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

/// ViewReceiptPDF : "https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/sfc/p/3C0000004x3c/a/3C000000I6xH/zC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ"
/// RecordID : "a033C000003irGoQAI"
/// ReceiptNumber : 206
/// ReceiptDate : "09/06/2022"
/// Receipt_Name : "a033C000003irGo"
/// InvoiceNumber : ""
/// DownloadReceiptPDF : "https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001YwZm&d=%2Fa%2F3C000000I6xH%2FzC22fHnl98EqOsu8YzHQzPEWdsgCRw5aCnbZc5Rk5MQ&asPdf=false"
/// amount : 5000

class Responselist {
  Responselist({
      String? viewReceiptPDF, 
      String? recordID, 
      num? receiptNumber, 
      String? receiptDate, 
      String? receiptName,
    num? invoiceNumber,
      String? downloadReceiptPDF, 
      num? amount,}){
    _viewReceiptPDF = viewReceiptPDF;
    _recordID = recordID;
    _receiptNumber = receiptNumber;
    _receiptDate = receiptDate;
    _receiptName = receiptName;
    _invoiceNumber = invoiceNumber;
    _downloadReceiptPDF = downloadReceiptPDF;
    _amount = amount;
}

  Responselist.fromJson(dynamic json) {
    _viewReceiptPDF = json['ViewReceiptPDF'];
    _recordID = json['RecordID'];
    _receiptNumber = json['ReceiptNumber'];
    _receiptDate = json['ReceiptDate'];
    _receiptName = json['Receipt_Name'];
    _invoiceNumber = json['InvoiceNumber'];
    _downloadReceiptPDF = json['DownloadReceiptPDF'];
    _amount = json['amount'];
  }
  String? _viewReceiptPDF;
  String? _recordID;
  num? _receiptNumber;
  String? _receiptDate;
  String? _receiptName;
  num? _invoiceNumber;
  String? _downloadReceiptPDF;
  num? _amount;
Responselist copyWith({  String? viewReceiptPDF,
  String? recordID,
  num? receiptNumber,
  String? receiptDate,
  String? receiptName,
  num? invoiceNumber,
  String? downloadReceiptPDF,
  num? amount,
}) => Responselist(  viewReceiptPDF: viewReceiptPDF ?? _viewReceiptPDF,
  recordID: recordID ?? _recordID,
  receiptNumber: receiptNumber ?? _receiptNumber,
  receiptDate: receiptDate ?? _receiptDate,
  receiptName: receiptName ?? _receiptName,
  invoiceNumber: invoiceNumber ?? _invoiceNumber,
  downloadReceiptPDF: downloadReceiptPDF ?? _downloadReceiptPDF,
  amount: amount ?? _amount,
);
  String? get viewReceiptPDF => _viewReceiptPDF;
  String? get recordID => _recordID;
  num? get receiptNumber => _receiptNumber;
  String? get receiptDate => _receiptDate;
  String? get receiptName => _receiptName;
  num? get invoiceNumber => _invoiceNumber;
  String? get downloadReceiptPDF => _downloadReceiptPDF;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ViewReceiptPDF'] = _viewReceiptPDF;
    map['RecordID'] = _recordID;
    map['ReceiptNumber'] = _receiptNumber;
    map['ReceiptDate'] = _receiptDate;
    map['Receipt_Name'] = _receiptName;
    map['InvoiceNumber'] = _invoiceNumber;
    map['DownloadReceiptPDF'] = _downloadReceiptPDF;
    map['amount'] = _amount;
    return map;
  }

}