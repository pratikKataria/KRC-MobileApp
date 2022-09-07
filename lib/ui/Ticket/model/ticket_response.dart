/// returnCode : true
/// ResponseList : [{"subCategory":"","status":"closed","RecordID":"5003C000007xFWSQA2","description":"test123","Category":"","caseNumber":"00001007"}]
/// message : "Success"

class TicketResponse {
  TicketResponse({
      bool returnCode, 
      List<ResponseList> responseList, 
      String message,}){
    _returnCode = returnCode;
    _responseList = responseList;
    _message = message;
}

  TicketResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['ResponseList'] != null) {
      _responseList = [];
      json['ResponseList'].forEach((v) {
        _responseList.add(ResponseList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<ResponseList> _responseList;
  String _message;

  bool get returnCode => _returnCode;
  List<ResponseList> get responseList => _responseList;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responseList != null) {
      map['ResponseList'] = _responseList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// subCategory : ""
/// status : "closed"
/// RecordID : "5003C000007xFWSQA2"
/// description : "test123"
/// Category : ""
/// caseNumber : "00001007"

class ResponseList {
  ResponseList({
      String subCategory, 
      String status, 
      String recordID, 
      String description, 
      String category, 
      String caseNumber,}){
    _subCategory = subCategory;
    _status = status;
    _recordID = recordID;
    _description = description;
    _category = category;
    _caseNumber = caseNumber;
}

  ResponseList.fromJson(dynamic json) {
    _subCategory = json['subCategory'];
    _status = json['status'];
    _recordID = json['RecordID'];
    _description = json['description'];
    _category = json['Category'];
    _caseNumber = json['caseNumber'];
  }
  String _subCategory;
  String _status;
  String _recordID;
  String _description;
  String _category;
  String _caseNumber;

  String get subCategory => _subCategory;
  String get status => _status;
  String get recordID => _recordID;
  String get description => _description;
  String get category => _category;
  String get caseNumber => _caseNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategory'] = _subCategory;
    map['status'] = _status;
    map['RecordID'] = _recordID;
    map['description'] = _description;
    map['Category'] = _category;
    map['caseNumber'] = _caseNumber;
    return map;
  }

}