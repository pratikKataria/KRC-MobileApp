/// returnCode : true
/// responselist : [{"viewInvoicePDf":"https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/sfc/p/3C0000004x3c/a/3C000000INAR/t4qsI0wwSG0PXNVt1ClY7PtgLVDf223eth9j_h0g9D8","Total":100000,"recordID":"a0H3C000006rwGDUAY","InvoiceNumber":3432425,"InvoiceName":"Test Invoice 6jan1","DownloadInvoicePDf":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001i0aQ&d=%2Fa%2F3C000000INAR%2Ft4qsI0wwSG0PXNVt1ClY7PtgLVDf223eth9j_h0g9D8&asPdf=false"}]
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

/// viewInvoicePDf : "https://krahejacorp--krcsandbox.sandbox.my.salesforce.com/sfc/p/3C0000004x3c/a/3C000000INAR/t4qsI0wwSG0PXNVt1ClY7PtgLVDf223eth9j_h0g9D8"
/// Total : 100000
/// recordID : "a0H3C000006rwGDUAY"
/// InvoiceNumber : 3432425
/// InvoiceName : "Test Invoice 6jan1"
/// DownloadInvoicePDf : "https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001i0aQ&d=%2Fa%2F3C000000INAR%2Ft4qsI0wwSG0PXNVt1ClY7PtgLVDf223eth9j_h0g9D8&asPdf=false"

class Responselist {
  Responselist({
      String? viewInvoicePDf, 
      num? total, 
      String? recordID, 
      num? invoiceNumber, 
      String? invoiceName, 
      String? downloadInvoicePDf,}){
    _viewInvoicePDf = viewInvoicePDf;
    _total = total;
    _recordID = recordID;
    _invoiceNumber = invoiceNumber;
    _invoiceName = invoiceName;
    _downloadInvoicePDf = downloadInvoicePDf;
}

  Responselist.fromJson(dynamic json) {
    _viewInvoicePDf = json['viewInvoicePDf'];
    _total = json['Total'];
    _recordID = json['recordID'];
    _invoiceNumber = json['InvoiceNumber'];
    _invoiceName = json['InvoiceName'];
    _downloadInvoicePDf = json['DownloadInvoicePDf'];
  }
  String? _viewInvoicePDf;
  num? _total;
  String? _recordID;
  num? _invoiceNumber;
  String? _invoiceName;
  String? _downloadInvoicePDf;
Responselist copyWith({  String? viewInvoicePDf,
  num? total,
  String? recordID,
  num? invoiceNumber,
  String? invoiceName,
  String? downloadInvoicePDf,
}) => Responselist(  viewInvoicePDf: viewInvoicePDf ?? _viewInvoicePDf,
  total: total ?? _total,
  recordID: recordID ?? _recordID,
  invoiceNumber: invoiceNumber ?? _invoiceNumber,
  invoiceName: invoiceName ?? _invoiceName,
  downloadInvoicePDf: downloadInvoicePDf ?? _downloadInvoicePDf,
);
  String? get viewInvoicePDf => _viewInvoicePDf;
  num? get total => _total;
  String? get recordID => _recordID;
  num? get invoiceNumber => _invoiceNumber;
  String? get invoiceName => _invoiceName;
  String? get downloadInvoicePDf => _downloadInvoicePDf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['viewInvoicePDf'] = _viewInvoicePDf;
    map['Total'] = _total;
    map['recordID'] = _recordID;
    map['InvoiceNumber'] = _invoiceNumber;
    map['InvoiceName'] = _invoiceName;
    map['DownloadInvoicePDf'] = _downloadInvoicePDf;
    return map;
  }

}