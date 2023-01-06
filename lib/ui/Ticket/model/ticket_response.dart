/// returnCode : true
/// ResponseList : [{"time_data":"10:00 AM","subCategory":"Snags Related Issue","status":"open","RecordID":"5003C000009RTl0QAG","description":"test disc","date_data":"05/01/2023","Category":"Post Possession","caseNumber":"00001076"},{"time_data":"10:00 AM","subCategory":"Other Charges","status":"closed","RecordID":"5003C000009RSSAQA4","description":"Creating Tickets from mobile.","date_data":"05/01/2023","Category":"Payment Related","caseNumber":"00001070"},{"time_data":"10:00 AM","subCategory":"Name Addition","status":"open","RecordID":"5003C000008VDLfQAO","description":"Description is mandatory.","date_data":"05/01/2023","Category":"Name Modification","caseNumber":"00001036"},{"time_data":"10:00 AM","subCategory":"Non-receipt of Draft Agreement/Annexures","status":"open","RecordID":"5003C000008VDLVQA4","description":"Description is not mandatory.","date_data":"05/01/2023","Category":"Registration","caseNumber":"00001034"},{"time_data":"10:00 AM","subCategory":"Electricity Bill/MGL","status":"open","RecordID":"5003C000008VBMRQA4","description":"Description might be mandatory.","date_data":"05/01/2023","Category":"Post Possession","caseNumber":"00001033"}]
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

/// time_data : "10:00 AM"
/// subCategory : "Snags Related Issue"
/// status : "open"
/// RecordID : "5003C000009RTl0QAG"
/// description : "test disc"
/// date_data : "05/01/2023"
/// Category : "Post Possession"
/// caseNumber : "00001076"

class ResponseList {
  ResponseList({
      String? timeData, 
      String? subCategory, 
      String? status, 
      String? recordID, 
      String? description, 
      String? dateData, 
      String? category, 
      String? caseNumber,}){
    _timeData = timeData;
    _subCategory = subCategory;
    _status = status;
    _recordID = recordID;
    _description = description;
    _dateData = dateData;
    _category = category;
    _caseNumber = caseNumber;
}

  ResponseList.fromJson(dynamic json) {
    _timeData = json['time_data'];
    _subCategory = json['subCategory'];
    _status = json['status'];
    _recordID = json['RecordID'];
    _description = json['description'];
    _dateData = json['date_data'];
    _category = json['Category'];
    _caseNumber = json['caseNumber'];
  }
  String? _timeData;
  String? _subCategory;
  String? _status;
  String? _recordID;
  String? _description;
  String? _dateData;
  String? _category;
  String? _caseNumber;
ResponseList copyWith({  String? timeData,
  String? subCategory,
  String? status,
  String? recordID,
  String? description,
  String? dateData,
  String? category,
  String? caseNumber,
}) => ResponseList(  timeData: timeData ?? _timeData,
  subCategory: subCategory ?? _subCategory,
  status: status ?? _status,
  recordID: recordID ?? _recordID,
  description: description ?? _description,
  dateData: dateData ?? _dateData,
  category: category ?? _category,
  caseNumber: caseNumber ?? _caseNumber,
);
  String? get timeData => _timeData;
  String? get subCategory => _subCategory;
  String? get status => _status;
  String? get recordID => _recordID;
  String? get description => _description;
  String? get dateData => _dateData;
  String? get category => _category;
  String? get caseNumber => _caseNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time_data'] = _timeData;
    map['subCategory'] = _subCategory;
    map['status'] = _status;
    map['RecordID'] = _recordID;
    map['description'] = _description;
    map['date_data'] = _dateData;
    map['Category'] = _category;
    map['caseNumber'] = _caseNumber;
    return map;
  }

}