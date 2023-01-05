/// returnCode : true
/// message : "Success"
/// bookingList : [{"Unit":"105","TowerId":"a0I3C0000020yxwUAA","Tower":"Tower 1","TopScreenImage":"","ProjectId":"a0B3C000005S7KnUAK","Project":"KRC","bookingId":"a013C00000AKnAZQA1"}]

class BookingListResponse {
  BookingListResponse({
      bool? returnCode, 
      String? message, 
      List<BookingList>? bookingList,}){
    _returnCode = returnCode;
    _message = message;
    _bookingList = bookingList;
}

  BookingListResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    if (json['bookingList'] != null) {
      _bookingList = [];
      json['bookingList'].forEach((v) {
        _bookingList?.add(BookingList.fromJson(v));
      });
    }
  }
  bool? _returnCode;
  String? _message;
  List<BookingList>? _bookingList;
BookingListResponse copyWith({  bool? returnCode,
  String? message,
  List<BookingList>? bookingList,
}) => BookingListResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  bookingList: bookingList ?? _bookingList,
);
  bool? get returnCode => _returnCode;
  String? get message => _message;
  List<BookingList>? get bookingList => _bookingList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    if (_bookingList != null) {
      map['bookingList'] = _bookingList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Unit : "105"
/// TowerId : "a0I3C0000020yxwUAA"
/// Tower : "Tower 1"
/// TopScreenImage : ""
/// ProjectId : "a0B3C000005S7KnUAK"
/// Project : "KRC"
/// bookingId : "a013C00000AKnAZQA1"

class BookingList {
  BookingList({
      String? unit, 
      String? towerId, 
      String? tower, 
      String? topScreenImage, 
      String? projectId, 
      String? project, 
      String? bookingId,}){
    _unit = unit;
    _towerId = towerId;
    _tower = tower;
    _topScreenImage = topScreenImage;
    _projectId = projectId;
    _project = project;
    _bookingId = bookingId;
}

  BookingList.fromJson(dynamic json) {
    _unit = json['Unit'];
    _towerId = json['TowerId'];
    _tower = json['Tower'];
    _topScreenImage = json['TopScreenImage'];
    _projectId = json['ProjectId'];
    _project = json['Project'];
    _bookingId = json['bookingId'];
  }
  String? _unit;
  String? _towerId;
  String? _tower;
  String? _topScreenImage;
  String? _projectId;
  String? _project;
  String? _bookingId;
BookingList copyWith({  String? unit,
  String? towerId,
  String? tower,
  String? topScreenImage,
  String? projectId,
  String? project,
  String? bookingId,
}) => BookingList(  unit: unit ?? _unit,
  towerId: towerId ?? _towerId,
  tower: tower ?? _tower,
  topScreenImage: topScreenImage ?? _topScreenImage,
  projectId: projectId ?? _projectId,
  project: project ?? _project,
  bookingId: bookingId ?? _bookingId,
);
  String? get unit => _unit;
  String? get towerId => _towerId;
  String? get tower => _tower;
  String? get topScreenImage => _topScreenImage;
  String? get projectId => _projectId;
  String? get project => _project;
  String? get bookingId => _bookingId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unit'] = _unit;
    map['TowerId'] = _towerId;
    map['Tower'] = _tower;
    map['TopScreenImage'] = _topScreenImage;
    map['ProjectId'] = _projectId;
    map['Project'] = _project;
    map['bookingId'] = _bookingId;
    return map;
  }

}