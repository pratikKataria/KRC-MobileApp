/// unitNO : "105"
/// Tower : "a0I3C0000020yxwUAA"
/// returnCode : true
/// responselist : [{"FileName":"PRICE SHEET","Downloadlink":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001Z9iF&d=%2Fa%2F3C000000I7zJ%2F0mxzlqu9O7aFu0bgia7hqyYcP4P1uTUK6EhnGbPe3ts&asPdf=false"},{"FileName":"DOCUMENT TO SALE","Downloadlink":"https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001Z9iK&d=%2Fa%2F3C000000I7zO%2FfY00hSzFkuM2xuGDL3AcHI.CnOCzpvpImKqGBvIW.tI&asPdf=false"}]
/// message : "Success"

class DocumentResponse {
  DocumentResponse({
      String? unitNO, 
      String? tower, 
      bool? returnCode, 
      List<DocResponselist>? responselist,
      String? message,}){
    _unitNO = unitNO;
    _tower = tower;
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  DocumentResponse.fromJson(dynamic json) {
    _unitNO = json['unitNO'];
    _tower = json['Tower'];
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist!.add(DocResponselist.fromJson(v));
      });
    }
    _message = json['message'];
  }
  String? _unitNO;
  String? _tower;
  bool? _returnCode;
  List<DocResponselist>? _responselist;
  String? _message;

  String? get unitNO => _unitNO;
  String? get tower => _tower;
  bool? get returnCode => _returnCode;
  List<DocResponselist>? get responselist => _responselist;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitNO'] = _unitNO;
    map['Tower'] = _tower;
    map['returnCode'] = _returnCode;
    if (_responselist != null) {
      map['responselist'] = _responselist!.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// FileName : "PRICE SHEET"
/// Downloadlink : "https://krahejacorp--krcsandbox--c.documentforce.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001Z9iF&d=%2Fa%2F3C000000I7zJ%2F0mxzlqu9O7aFu0bgia7hqyYcP4P1uTUK6EhnGbPe3ts&asPdf=false"

class DocResponselist {
  DocResponselist({
      String? fileName, 
      String? downloadlink,}){
    _fileName = fileName;
    _downloadlink = downloadlink;
}

  DocResponselist.fromJson(dynamic json) {
    _fileName = json['FileName'];
    _downloadlink = json['Downloadlink'];
  }
  String? _fileName;
  String? _downloadlink;

  String? get fileName => _fileName;
  String? get downloadlink => _downloadlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FileName'] = _fileName;
    map['Downloadlink'] = _downloadlink;
    return map;
  }

}