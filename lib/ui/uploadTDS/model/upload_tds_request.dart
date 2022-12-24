/// TotalTransaction : "5555"
/// AcknowledgementNumber : "471444"
/// FYYear : "2022"
/// Comments : "test tds send from mobile"
/// TransactionDate : "15/04/2022"
/// bookingID : "a013C00000AKnAZQA1"
/// TdsAmount : "1000"
/// TDSPDF : "JVBE"

class UploadTdsRequest {
  UploadTdsRequest({
      String? totalTransaction, 
      String? acknowledgementNumber, 
      String? fYYear, 
      String? comments, 
      String? transactionDate, 
      String? bookingID, 
      String? tdsAmount, 
      String? tdspdf,}){
    _totalTransaction = totalTransaction;
    _acknowledgementNumber = acknowledgementNumber;
    _fYYear = fYYear;
    _comments = comments;
    _transactionDate = transactionDate;
    _bookingID = bookingID;
    _tdsAmount = tdsAmount;
    _tdspdf = tdspdf;
}

  UploadTdsRequest.fromJson(dynamic json) {
    _totalTransaction = json['TotalTransaction'];
    _acknowledgementNumber = json['AcknowledgementNumber'];
    _fYYear = json['FYYear'];
    _comments = json['Comments'];
    _transactionDate = json['TransactionDate'];
    _bookingID = json['bookingID'];
    _tdsAmount = json['TdsAmount'];
    _tdspdf = json['TDSPDF'];
  }
  String? _totalTransaction;
  String? _acknowledgementNumber;
  String? _fYYear;
  String? _comments;
  String? _transactionDate;
  String? _bookingID;
  String? _tdsAmount;
  String? _tdspdf;

  String? get totalTransaction => _totalTransaction;
  String? get acknowledgementNumber => _acknowledgementNumber;
  String? get fYYear => _fYYear;
  String? get comments => _comments;
  String? get transactionDate => _transactionDate;
  String? get bookingID => _bookingID;
  String? get tdsAmount => _tdsAmount;
  String? get tdspdf => _tdspdf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalTransaction'] = _totalTransaction;
    map['AcknowledgementNumber'] = _acknowledgementNumber;
    map['FYYear'] = _fYYear;
    map['Comments'] = _comments;
    map['TransactionDate'] = _transactionDate;
    map['bookingID'] = _bookingID;
    map['TdsAmount'] = _tdsAmount;
    map['TDSPDF'] = _tdspdf;
    return map;
  }

  set tdspdf(String? value) {
    _tdspdf = value;
  }

  set tdsAmount(String? value) {
    _tdsAmount = value;
  }

  set bookingID(String? value) {
    _bookingID = value;
  }

  set transactionDate(String? value) {
    _transactionDate = value;
  }

  set comments(String? value) {
    _comments = value;
  }

  set fYYear(String? value) {
    _fYYear = value;
  }

  set acknowledgementNumber(String? value) {
    _acknowledgementNumber = value;
  }

  set totalTransaction(String? value) {
    _totalTransaction = value;
  }
}