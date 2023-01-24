/// returnCode : true
/// message : "Success"
/// downloadlink : "https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001iEF9&d=%2Fa%2F3C000000IO4P%2FUJGwluV4JoxtkHcBZWu1q3GeFMFi975GobfM28DGZ.g&asPdf=false"

class DownloadBillingDetailResponse {
  DownloadBillingDetailResponse({
      bool? returnCode, 
      String? message, 
      String? downloadlink,}){
    _returnCode = returnCode;
    _message = message;
    _downloadlink = downloadlink;
}

  DownloadBillingDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _downloadlink = json['downloadlink'];
  }
  bool? _returnCode;
  String? _message;
  String? _downloadlink;
DownloadBillingDetailResponse copyWith({  bool? returnCode,
  String? message,
  String? downloadlink,
}) => DownloadBillingDetailResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  downloadlink: downloadlink ?? _downloadlink,
);
  bool? get returnCode => _returnCode;
  String? get message => _message;
  String? get downloadlink => _downloadlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['downloadlink'] = _downloadlink;
    return map;
  }
}