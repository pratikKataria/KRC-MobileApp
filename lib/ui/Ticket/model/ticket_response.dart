/// returnCode : true
/// ResponseList : [{"subCategory":"","status":"open","RecordID":"5003C000007xFWSQA2","description":"test123","Date_Time":"2022-05-24T10:29:34.000Z","Category":"Onboarding","caseNumber":"00001007"}]
/// message : "Success"

class TicketResponse {
  TicketResponse({
      bool? returnCode, 
      List<ResponseList>? responseList, 
      String? message,}){
    _returnCode = returnCode;
    _responseList = responseList;
    _message = message;
}

  TicketResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['ResponseList'] != null) {
      _responseList = [];
      json['ResponseList'].forEach((v) {
        _responseList?.add(ResponseList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _returnCode;
  List<ResponseList>? _responseList;
  String? _message;
TicketResponse copyWith({  bool? returnCode,
  List<ResponseList>? responseList,
  String? message,
}) => TicketResponse(  returnCode: returnCode ?? _returnCode,
  responseList: responseList ?? _responseList,
  message: message ?? _message,
);
  bool? get returnCode => _returnCode;
  List<ResponseList>? get responseList => _responseList;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responseList != null) {
      map['ResponseList'] = _responseList?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// subCategory : ""
/// status : "open"
/// RecordID : "5003C000007xFWSQA2"
/// description : "test123"
/// Date_Time : "2022-05-24T10:29:34.000Z"
/// Category : "Onboarding"
/// caseNumber : "00001007"

class ResponseList {
  ResponseList({
      String? subCategory, 
      String? status, 
      String? recordID, 
      String? description, 
      String? dateTime, 
      String? category, 
      String? caseNumber,}){
    _subCategory = subCategory;
    _status = status;
    _recordID = recordID;
    _description = description;
    _dateTime = dateTime;
    _category = category;
    _caseNumber = caseNumber;
}

  ResponseList.fromJson(dynamic json) {
    _subCategory = json['subCategory'];
    _status = json['status'];
    _recordID = json['RecordID'];
    _description = json['description'];
    _dateTime = json['Date_Time'];
    _category = json['Category'];
    _caseNumber = json['caseNumber'];
  }
  String? _subCategory;
  String? _status;
  String? _recordID;
  String? _description;
  String? _dateTime;
  String? _category;
  String? _caseNumber;
ResponseList copyWith({  String? subCategory,
  String? status,
  String? recordID,
  String? description,
  String? dateTime,
  String? category,
  String? caseNumber,
}) => ResponseList(  subCategory: subCategory ?? _subCategory,
  status: status ?? _status,
  recordID: recordID ?? _recordID,
  description: description ?? _description,
  dateTime: dateTime ?? _dateTime,
  category: category ?? _category,
  caseNumber: caseNumber ?? _caseNumber,
);
  String? get subCategory => _subCategory;
  String? get status => _status;
  String? get recordID => _recordID;
  String? get description => _description;
  String? get dateTime => _dateTime;
  String? get category => _category;
  String? get caseNumber => _caseNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategory'] = _subCategory;
    map['status'] = _status;
    map['RecordID'] = _recordID;
    map['description'] = _description;
    map['Date_Time'] = _dateTime;
    map['Category'] = _category;
    map['caseNumber'] = _caseNumber;
    return map;
  }

}