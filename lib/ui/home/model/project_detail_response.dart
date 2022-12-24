/// returnCode : true
/// ReraWebsite : "www.rera.com"
/// ReraId : "1234"
/// ProjectName : "KRC"
/// ProjectImage : "kj"
/// ProjectDescription : "K Raheja Corp Homes has always strived to give South Pune the best it deserves. And now, we bring you large 3 bed homes at Raheja Reserve, the most acclaimed development of South Pune. Be it the amenities like multiple themed gardens that evoke pure admiration, 600+ trees, and expansive greens that let your heart wander, every aspect here is truly iconic. Add to this, the unmatched convenience and excellent connectivity of NIBM, and there is nothing more you would wish for."
/// message : "SUCCESS"

class ProjectDetailResponse {
  ProjectDetailResponse({
      bool? returnCode, 
      String? reraWebsite, 
      String? reraId, 
      String? projectName, 
      String? projectImage, 
      String? projectDescription, 
      String? message,}){
    _returnCode = returnCode;
    _reraWebsite = reraWebsite;
    _reraId = reraId;
    _projectName = projectName;
    _projectImage = projectImage;
    _projectDescription = projectDescription;
    _message = message;
}

  ProjectDetailResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _reraWebsite = json['ReraWebsite'];
    _reraId = json['ReraId'];
    _projectName = json['ProjectName'];
    _projectImage = json['ProjectImage'];
    _projectDescription = json['ProjectDescription'];
    _message = json['message'];
  }
  bool? _returnCode;
  String? _reraWebsite;
  String? _reraId;
  String? _projectName;
  String? _projectImage;
  String? _projectDescription;
  String? _message;

  bool? get returnCode => _returnCode;
  String? get reraWebsite => _reraWebsite;
  String? get reraId => _reraId;
  String? get projectName => _projectName;
  String? get projectImage => _projectImage;
  String? get projectDescription => _projectDescription;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['ReraWebsite'] = _reraWebsite;
    map['ReraId'] = _reraId;
    map['ProjectName'] = _projectName;
    map['ProjectImage'] = _projectImage;
    map['ProjectDescription'] = _projectDescription;
    map['message'] = _message;
    return map;
  }

  set message(String? value) {
    _message = value;
  }

  set projectDescription(String? value) {
    _projectDescription = value;
  }

  set projectImage(String? value) {
    _projectImage = value;
  }

  set projectName(String? value) {
    _projectName = value;
  }

  set reraId(String? value) {
    _reraId = value;
  }

  set reraWebsite(String? value) {
    _reraWebsite = value;
  }

  set returnCode(bool? value) {
    _returnCode = value;
  }
}