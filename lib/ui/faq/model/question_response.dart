/// rp : [{"returnCode":true,"question":"<p>What is Tds on Property?</p>","message":"success","answer":"<p>TDS has to be paid on the property by the owner, equivalent to 1 percent of the total unit cost. </p>"},{"returnCode":true,"question":"<p>what if I don&#39;t Have a Pancard?</p>","message":"success","answer":"<p>PanCard is a mandatory document for all financial transactions please apply for the same.</p>"}]

class QuestionResponse {
  QuestionResponse({
      List<Rp>? rp,}){
    _rp = rp;
}

  QuestionResponse.fromJson(dynamic json) {
    if (json['rp'] != null) {
      _rp = [];
      json['rp'].forEach((v) {
        _rp!.add(Rp.fromJson(v));
      });
    }
  }
  List<Rp>? _rp;

  List<Rp>? get rp => _rp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_rp != null) {
      map['rp'] = _rp!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// returnCode : true
/// question : "<p>What is Tds on Property?</p>"
/// message : "success"
/// answer : "<p>TDS has to be paid on the property by the owner, equivalent to 1 percent of the total unit cost. </p>"

class Rp {
  Rp({
      bool? returnCode, 
      String? question, 
      String? message, 
      String? answer,}){
    _returnCode = returnCode;
    _question = question;
    _message = message;
    _answer = answer;
}

  Rp.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _question = json['question'];
    _message = json['message'];
    _answer = json['answer'];
  }
  bool? _returnCode;
  String? _question;
  String? _message;
  String? _answer;

  bool? get returnCode => _returnCode;
  String? get question => _question;
  String? get message => _message;
  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['question'] = _question;
    map['message'] = _message;
    map['answer'] = _answer;
    return map;
  }

}