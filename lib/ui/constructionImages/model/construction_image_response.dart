/// ResponseList : [{"returnCode":true,"message":"SUCCESS","imageTitle":"1st floor","imagelink":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001HbYL&d=%2Fa%2F3C000000I4qd%2FOr1jXdLLLlqMoSBQZWWe2MX8.yBwdHXFykJlBwDMCII&asPdf=false"},{"returnCode":true,"message":"SUCCESS","imageTitle":"2 floor","imagelink":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001HbYV&d=%2Fa%2F3C000000I4qi%2FYRRNpmnMM1RwZvK0CTghF3NB8FGj.aTrkdC5cmk6wkc&asPdf=false"},{"returnCode":true,"message":"SUCCESS","imageTitle":"3 floor","imagelink":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001HbYf&d=%2Fa%2F3C000000I4qn%2FpY6nPkDYaqV5vZSUGjXnI5ntigqvgSbjBVl9t9DiHc0&asPdf=false"}]

class ConstructionImageResponse {
  ConstructionImageResponse({
      List<ResponseList> responseList,}){
    _responseList = responseList;
}

  ConstructionImageResponse.fromJson(dynamic json) {
    if (json['ResponseList'] != null) {
      _responseList = [];
      json['ResponseList'].forEach((v) {
        _responseList.add(ResponseList.fromJson(v));
      });
    }
  }
  List<ResponseList> _responseList;

  List<ResponseList> get responseList => _responseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_responseList != null) {
      map['ResponseList'] = _responseList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// returnCode : true
/// message : "SUCCESS"
/// imageTitle : "1st floor"
/// imagelink : "https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001HbYL&d=%2Fa%2F3C000000I4qd%2FOr1jXdLLLlqMoSBQZWWe2MX8.yBwdHXFykJlBwDMCII&asPdf=false"

class ResponseList {
  ResponseList({
      bool returnCode, 
      String message, 
      String imageTitle, 
      String imagelink,}){
    _returnCode = returnCode;
    _message = message;
    _imageTitle = imageTitle;
    _imagelink = imagelink;
}

  ResponseList.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _imageTitle = json['imageTitle'];
    _imagelink = json['imagelink'];
  }
  bool _returnCode;
  String _message;
  String _imageTitle;
  String _imagelink;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get imageTitle => _imageTitle;
  String get imagelink => _imagelink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['imageTitle'] = _imageTitle;
    map['imagelink'] = _imagelink;
    return map;
  }

}