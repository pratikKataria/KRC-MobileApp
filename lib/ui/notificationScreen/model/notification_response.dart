/// returnCode : true
/// NotificationList : [{"Type":"Invoice","Title":"New Invoice","Published_date":"2022-07-08","NotificationID":"a0A3C000005omWMUAY","Notification_viewed":false,"NavigateToRecordID":"a0H3C0000061L7JUAU","Body":"New Invoice generated  : 101011"},{"Type":"Receipt","Title":"New Receipt","Published_date":"2022-07-08","NotificationID":"a0A3C000005omPaUAI","Notification_viewed":false,"NavigateToRecordID":"a033C000003rZHmQAM","Body":"New Receipt generated  : 15008"},{"Type":"Receipt","Title":"test event","Published_date":"2022-07-29","NotificationID":"a0A3C000005omO9UAI","Notification_viewed":false,"NavigateToRecordID":"a033C000003rZFtQAM","Body":"test"},{"Type":"Receipt","Title":"test for receipt","Published_date":"2022-07-09","NotificationID":"a0A3C000005omNpUAI","Notification_viewed":false,"NavigateToRecordID":"a0H3C00000612IXUAY","Body":"this is the text entered in description field of push notification"},{"Type":"Invoice","Title":"New Noti for email","Published_date":null,"NotificationID":"a0A3C000005nuiPUAQ","Notification_viewed":false,"NavigateToRecordID":null,"Body":"New Invoice Generated : 101"},{"Type":"closed Ticket","Title":"Ticket closed","Published_date":"2022-06-24","NotificationID":"a0A3C000005ntGZUAY","Notification_viewed":false,"NavigateToRecordID":"5003C000007y6lYQAQ","Body":"ticket closed"},{"Type":"Construction Image","Title":"New Construction Image","Published_date":"2022-06-28","NotificationID":"a0A3C000005ntG0UAI","Notification_viewed":false,"NavigateToRecordID":"a0J3C0000013GniUAE","Body":"New Construction Image"},{"Type":"Receipt","Title":"New receipt","Published_date":"2022-06-30","NotificationID":"a0A3C000005ntFlUAI","Notification_viewed":false,"NavigateToRecordID":"a033C000003inFAQAY","Body":"New Receipt Generated : test 101"},{"Type":"Invoice","Title":"New Invoice","Published_date":"2022-06-30","NotificationID":"a0A3C000005ntFbUAI","Notification_viewed":false,"NavigateToRecordID":"a0H3C00000612IXUAY","Body":"New Invoice generated : 101"}]
/// message : "Success"

class NotificationResponse {
  NotificationResponse({
      bool returnCode, 
      List<NotificationList> notificationList, 
      String message,}){
    _returnCode = returnCode;
    _notificationList = notificationList;
    _message = message;
}

  NotificationResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['NotificationList'] != null) {
      _notificationList = [];
      json['NotificationList'].forEach((v) {
        _notificationList.add(NotificationList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool _returnCode;
  List<NotificationList> _notificationList;
  String _message;

  bool get returnCode => _returnCode;
  List<NotificationList> get notificationList => _notificationList;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_notificationList != null) {
      map['NotificationList'] = _notificationList.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// Type : "Invoice"
/// Title : "New Invoice"
/// Published_date : "2022-07-08"
/// NotificationID : "a0A3C000005omWMUAY"
/// Notification_viewed : false
/// NavigateToRecordID : "a0H3C0000061L7JUAU"
/// Body : "New Invoice generated  : 101011"

class NotificationList {
  NotificationList({
      String type, 
      String title, 
      String publishedDate, 
      String notificationID, 
      bool notificationViewed, 
      String navigateToRecordID, 
      String body,}){
    _type = type;
    _title = title;
    _publishedDate = publishedDate;
    _notificationID = notificationID;
    _notificationViewed = notificationViewed;
    _navigateToRecordID = navigateToRecordID;
    _body = body;
}

  NotificationList.fromJson(dynamic json) {
    _type = json['Type'];
    _title = json['Title'];
    _publishedDate = json['Published_date'];
    _notificationID = json['NotificationID'];
    _notificationViewed = json['Notification_viewed'];
    _navigateToRecordID = json['NavigateToRecordID'];
    _body = json['Body'];
  }
  String _type;
  String _title;
  String _publishedDate;
  String _notificationID;
  bool _notificationViewed;
  String _navigateToRecordID;
  String _body;

  String get type => _type;
  String get title => _title;
  String get publishedDate => _publishedDate;
  String get notificationID => _notificationID;
  bool get notificationViewed => _notificationViewed;
  String get navigateToRecordID => _navigateToRecordID;
  String get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type'] = _type;
    map['Title'] = _title;
    map['Published_date'] = _publishedDate;
    map['NotificationID'] = _notificationID;
    map['Notification_viewed'] = _notificationViewed;
    map['NavigateToRecordID'] = _navigateToRecordID;
    map['Body'] = _body;
    return map;
  }

}