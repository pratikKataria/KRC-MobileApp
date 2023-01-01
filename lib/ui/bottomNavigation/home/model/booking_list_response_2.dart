/// returnCode : true
/// message : "Success"
/// bookingList : [{"Unit":"105","Tower":"Tower 1","TopScreenImage":"","Project":"KRC"}]

class BookingListResponse2 {
  BookingListResponse2({
      bool? returnCode, 
      String? message, 
      List<BookingList>? bookingList,}){
    _returnCode = returnCode;
    _message = message;
    _bookingList = bookingList;
}

  BookingListResponse2.fromJson(dynamic json) {
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
BookingListResponse2 copyWith({  bool? returnCode,
  String? message,
  List<BookingList>? bookingList,
}) => BookingListResponse2(  returnCode: returnCode ?? _returnCode,
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
/// Tower : "Tower 1"
/// TopScreenImage : ""
/// Project : "KRC"

class BookingList {
  BookingList({
      String? unit, 
      String? tower, 
      String? topScreenImage, 
      String? project,}){
    _unit = unit;
    _tower = tower;
    _topScreenImage = topScreenImage;
    _project = project;
}

  BookingList.fromJson(dynamic json) {
    _unit = json['Unit'];
    _tower = json['Tower'];
    _topScreenImage = json['TopScreenImage'];
    _project = json['Project'];
  }
  String? _unit;
  String? _tower;
  String? _topScreenImage;
  String? _project;
BookingList copyWith({  String? unit,
  String? tower,
  String? topScreenImage,
  String? project,
}) => BookingList(  unit: unit ?? _unit,
  tower: tower ?? _tower,
  topScreenImage: topScreenImage ?? _topScreenImage,
  project: project ?? _project,
);
  String? get unit => _unit;
  String? get tower => _tower;
  String? get topScreenImage => _topScreenImage;
  String? get project => _project;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unit'] = _unit;
    map['Tower'] = _tower;
    map['TopScreenImage'] = _topScreenImage;
    map['Project'] = _project;
    return map;
  }

}