/// values : "Test Project,Raymond,null"
/// fieldName : "Project"

class PicklistValueResponse {
  PicklistValueResponse({
    String? values,
    String? fieldName,
  }) {
    _values = values;
    _fieldName = fieldName;
  }

  PicklistValueResponse.fromJson(dynamic json) {
    _values = json['values'];
    _fieldName = json['fieldName'];
  }

  String? _values;
  String? _fieldName;

  String? get values => _values;

  String? get fieldName => _fieldName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = _values;
    map['fieldName'] = _fieldName;
    return map;
  }
}
