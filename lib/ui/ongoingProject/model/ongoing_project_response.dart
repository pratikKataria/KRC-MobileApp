/// upcomingProjecList : [{"Website":"www.yahoo.com","Project_Name":"Test Upcoming Project2","Project_Image":"","Description":"Salesforce is the world's #1 customer relationship management (CRM) platform. We help your marketing, sales, commerce, service and IT teams work as one from anywhere — so you can keep your customers happy everywhere."},{"Website":"www.google.com","Project_Name":"Test Upcomig Project1","Project_Image":"","Description":"Salesforce is the world's #1 customer relationship management (CRM) platform. We help your marketing, sales, commerce, service and IT teams work as one from anywhere — so you can keep your customers happy everywhere."}]
/// returnCode : true
/// message : "Success"

class OngoingProjectResponse {
  OngoingProjectResponse({
      List<UpcomingProjecList>? upcomingProjecList, 
      bool? returnCode, 
      String? message,}){
    _upcomingProjecList = upcomingProjecList;
    _returnCode = returnCode;
    _message = message;
}

  OngoingProjectResponse.fromJson(dynamic json) {
    if (json['upcomingProjecList'] != null) {
      _upcomingProjecList = [];
      json['upcomingProjecList'].forEach((v) {
        _upcomingProjecList?.add(UpcomingProjecList.fromJson(v));
      });
    }
    _returnCode = json['returnCode'];
    _message = json['message'];
  }

  List<UpcomingProjecList>? _upcomingProjecList;
  bool? _returnCode;
  String? _message;
OngoingProjectResponse copyWith({  List<UpcomingProjecList>? upcomingProjecList,
  bool? returnCode,
  String? message,
}) => OngoingProjectResponse(  upcomingProjecList: upcomingProjecList ?? _upcomingProjecList,
  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
);
  List<UpcomingProjecList>? get upcomingProjecList => _upcomingProjecList;
  bool? get returnCode => _returnCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_upcomingProjecList != null) {
      map['upcomingProjecList'] = _upcomingProjecList?.map((v) => v.toJson()).toList();
    }
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}

/// Website : "www.yahoo.com"
/// Project_Name : "Test Upcoming Project2"
/// Project_Image : ""
/// Description : "Salesforce is the world's #1 customer relationship management (CRM) platform. We help your marketing, sales, commerce, service and IT teams work as one from anywhere — so you can keep your customers happy everywhere."

class UpcomingProjecList {
  UpcomingProjecList({
      String? website, 
      String? projectName, 
      String? projectImage, 
      String? description,}){
    _website = website;
    _projectName = projectName;
    _projectImage = projectImage;
    _description = description;
}

  UpcomingProjecList.fromJson(dynamic json) {
    _website = json['Website'];
    _projectName = json['Project_Name'];
    _projectImage = json['Project_Image'];
    _description = json['Description'];
  }
  String? _website;
  String? _projectName;
  String? _projectImage;
  String? _description;
UpcomingProjecList copyWith({  String? website,
  String? projectName,
  String? projectImage,
  String? description,
}) => UpcomingProjecList(  website: website ?? _website,
  projectName: projectName ?? _projectName,
  projectImage: projectImage ?? _projectImage,
  description: description ?? _description,
);
  String? get website => _website;
  String? get projectName => _projectName;
  String? get projectImage => _projectImage;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Website'] = _website;
    map['Project_Name'] = _projectName;
    map['Project_Image'] = _projectImage;
    map['Description'] = _description;
    return map;
  }

}