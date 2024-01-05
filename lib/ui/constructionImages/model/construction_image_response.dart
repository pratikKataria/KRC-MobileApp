/// ResponseList : [{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001WYUJUA4","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkgE&d=%2Fa%2F3C000000JvH6%2FgobN.L4sVcKo9bXJJs2jzk5ylmYZBmT7aad29IrTB_c&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001WYX2UAO","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkbz&d=%2Fa%2F3C000000JvGO%2FaK.Lg0LU6qj2bD4hEKtys1KZsJdeWtF65T9laqeErto&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001WYWxUAO","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkgJ&d=%2Fa%2F3C000000JvHB%2FhGgc.NAVDNKDmnnJqd8yWRJwld1YQfVpyTDUX0bSKiM&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001VusLUAS","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkg0&d=%2Fa%2F3C000000JvGw%2FySUzy2J5yDYOA7HdmbgGfK24adUoyS55a35QGmrzq04&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001VusGUAS","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkg9&d=%2Fa%2F3C000000JvGr%2FLsyqFzaSQEL8p.lqSQ1Ry6JLGUJydm47GnYzOwhSWog&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001VupMUAS","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkg4&d=%2Fa%2F3C000000JvGm%2FIjKnHRpjMGM2w8oYDKvLaj5bk9CLfWFHKqZPs2mob9U&asPdf=false"},{"Unit":"1","Tower":"Raheja Assencio","returnCode":true,"RecordID":"a0J3C000001VuKcUAK","Project":"Raheja Asencio","message":"SUCCESS","imageTitle":null,"imagelink":"https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkby&d=%2Fa%2F3C000000JvGN%2Fb1OSNan97reFr2H9r.S_uy2q.v69YCuP3lRbHZ4GXVw&asPdf=false"}]

class ConstructionImageResponse {
  ConstructionImageResponse({
      List<ResponseList>? responseList,}){
    _responseList = responseList;
}

  ConstructionImageResponse.fromJson(dynamic json) {
    if (json['ResponseList'] != null) {
      _responseList = [];
      json['ResponseList'].forEach((v) {
        _responseList?.add(ResponseList.fromJson(v));
      });
    }
  }
  List<ResponseList>? _responseList;
ConstructionImageResponse copyWith({  List<ResponseList>? responseList,
}) => ConstructionImageResponse(  responseList: responseList ?? _responseList,
);
  List<ResponseList>? get responseList => _responseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_responseList != null) {
      map['ResponseList'] = _responseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Unit : "1"
/// Tower : "Raheja Assencio"
/// returnCode : true
/// RecordID : "a0J3C000001WYUJUA4"
/// Project : "Raheja Asencio"
/// message : "SUCCESS"
/// imageTitle : null
/// imagelink : "https://krahejacorp--krcsandbox.sandbox.file.force.com/sfc/dist/version/download/?oid=00D3C0000004x3c&ids=0683C000001jkgE&d=%2Fa%2F3C000000JvH6%2FgobN.L4sVcKo9bXJJs2jzk5ylmYZBmT7aad29IrTB_c&asPdf=false"

class ResponseList {
  ResponseList({
      String? unit, 
      String? tower, 
      bool? returnCode, 
      String? recordID, 
      String? project, 
      String? message, 
      dynamic imageTitle, 
      String? imagelink,}){
    _unit = unit;
    _tower = tower;
    _returnCode = returnCode;
    _recordID = recordID;
    _project = project;
    _message = message;
    _imageTitle = imageTitle;
    _imagelink = imagelink;
}

  ResponseList.fromJson(dynamic json) {
    _unit = json['Unit'];
    _tower = json['Tower'];
    _returnCode = json['returnCode'];
    _recordID = json['RecordID'];
    _project = json['Project'];
    _message = json['message'];
    _imageTitle = json['imageTitle'];
    _imagelink = json['imagelink'];
  }
  String? _unit;
  String? _tower;
  bool? _returnCode;
  String? _recordID;
  String? _project;
  String? _message;
  dynamic _imageTitle;
  String? _imagelink;
ResponseList copyWith({  String? unit,
  String? tower,
  bool? returnCode,
  String? recordID,
  String? project,
  String? message,
  dynamic imageTitle,
  String? imagelink,
}) => ResponseList(  unit: unit ?? _unit,
  tower: tower ?? _tower,
  returnCode: returnCode ?? _returnCode,
  recordID: recordID ?? _recordID,
  project: project ?? _project,
  message: message ?? _message,
  imageTitle: imageTitle ?? _imageTitle,
  imagelink: imagelink ?? _imagelink,
);
  String? get unit => _unit;
  String? get tower => _tower;
  bool? get returnCode => _returnCode;
  String? get recordID => _recordID;
  String? get project => _project;
  String? get message => _message;
  dynamic get imageTitle => _imageTitle;
  String? get imagelink => _imagelink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unit'] = _unit;
    map['Tower'] = _tower;
    map['returnCode'] = _returnCode;
    map['RecordID'] = _recordID;
    map['Project'] = _project;
    map['message'] = _message;
    map['imageTitle'] = _imageTitle;
    map['imagelink'] = _imagelink;
    return map;
  }

}