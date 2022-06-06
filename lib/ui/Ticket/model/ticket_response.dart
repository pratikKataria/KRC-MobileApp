/// returnCode : true
/// ResponseList : [{"status":"open","description":"test123","caseNumber":"00001007"},{"status":"open","description":"test for case genaration","caseNumber":"00001008"},{"status":"open","description":"test for case genaration","caseNumber":"00001009"},{"status":"open","description":"test for case genaration","caseNumber":"00001010"},{"status":"open","description":"test for case genaration","caseNumber":"00001011"},{"status":"open","description":"test for case genaration","caseNumber":"00001012"}]
/// message : "Success"

class TicketResponse {
  TicketResponse({
    bool returnCode,
    List<ResponseList> responseList,
    String message,
  }) {
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

/// status : "open"
/// description : "test123"
/// caseNumber : "00001007"

class ResponseList {
  ResponseList({
    String status,
    String description,
    String caseNumber,
  }) {
    _status = status;
    _description = description;
    _caseNumber = caseNumber;
  }

  ResponseList.fromJson(dynamic json) {
    _status = json['status'];
    _description = json['description'];
    _caseNumber = json['caseNumber'];
  }

  String _status;
  String _description;
  String _caseNumber;

  String get status => _status;

  String get description => _description;

  String get caseNumber => _caseNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['description'] = _description;
    map['caseNumber'] = _caseNumber;
    return map;
  }
}
