/// returnCode : true
/// responselist : [{"Type_of_Parking":"Car","RERA_Carpet_Area":"10000","Number_of_Parking_Spaces":"1000000","Floor_No":"105","Building_No":"1299","bookingID":"a013C00000AKnAZQA1","Apartment_Type":"2 BHK","Apartment_No":"105","Agreement_Value":"1000000"}]
/// message : "SUCCESS"

class BookingResponse {
  BookingResponse({
      bool? returnCode, 
      List<Responselist>? responselist, 
      String? message,}){
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
}

  BookingResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist?.add(Responselist.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _returnCode;
  List<Responselist>? _responselist;
  String? _message;
BookingResponse copyWith({  bool? returnCode,
  List<Responselist>? responselist,
  String? message,
}) => BookingResponse(  returnCode: returnCode ?? _returnCode,
  responselist: responselist ?? _responselist,
  message: message ?? _message,
);
  bool? get returnCode => _returnCode;
  List<Responselist>? get responselist => _responselist;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responselist != null) {
      map['responselist'] = _responselist?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// Type_of_Parking : "Car"
/// RERA_Carpet_Area : "10000"
/// Number_of_Parking_Spaces : "1000000"
/// Floor_No : "105"
/// Building_No : "1299"
/// bookingID : "a013C00000AKnAZQA1"
/// Apartment_Type : "2 BHK"
/// Apartment_No : "105"
/// Agreement_Value : "1000000"

class Responselist {
  Responselist({
      String? typeOfParking, 
      String? rERACarpetArea, 
      String? numberOfParkingSpaces, 
      String? floorNo, 
      String? buildingNo, 
      String? bookingID, 
      String? apartmentType, 
      String? apartmentNo, 
      String? agreementValue,}){
    _typeOfParking = typeOfParking;
    _rERACarpetArea = rERACarpetArea;
    _numberOfParkingSpaces = numberOfParkingSpaces;
    _floorNo = floorNo;
    _buildingNo = buildingNo;
    _bookingID = bookingID;
    _apartmentType = apartmentType;
    _apartmentNo = apartmentNo;
    _agreementValue = agreementValue;
}

  Responselist.fromJson(dynamic json) {
    _typeOfParking = json['Type_of_Parking'];
    _rERACarpetArea = json['RERA_Carpet_Area'];
    _numberOfParkingSpaces = json['Number_of_Parking_Spaces'];
    _floorNo = json['Floor_No'];
    _buildingNo = json['Building_No'];
    _bookingID = json['bookingID'];
    _apartmentType = json['Apartment_Type'];
    _apartmentNo = json['Apartment_No'];
    _agreementValue = json['Agreement_Value'];
  }
  String? _typeOfParking;
  String? _rERACarpetArea;
  String? _numberOfParkingSpaces;
  String? _floorNo;
  String? _buildingNo;
  String? _bookingID;
  String? _apartmentType;
  String? _apartmentNo;
  String? _agreementValue;
Responselist copyWith({  String? typeOfParking,
  String? rERACarpetArea,
  String? numberOfParkingSpaces,
  String? floorNo,
  String? buildingNo,
  String? bookingID,
  String? apartmentType,
  String? apartmentNo,
  String? agreementValue,
}) => Responselist(  typeOfParking: typeOfParking ?? _typeOfParking,
  rERACarpetArea: rERACarpetArea ?? _rERACarpetArea,
  numberOfParkingSpaces: numberOfParkingSpaces ?? _numberOfParkingSpaces,
  floorNo: floorNo ?? _floorNo,
  buildingNo: buildingNo ?? _buildingNo,
  bookingID: bookingID ?? _bookingID,
  apartmentType: apartmentType ?? _apartmentType,
  apartmentNo: apartmentNo ?? _apartmentNo,
  agreementValue: agreementValue ?? _agreementValue,
);
  String? get typeOfParking => _typeOfParking;
  String? get rERACarpetArea => _rERACarpetArea;
  String? get numberOfParkingSpaces => _numberOfParkingSpaces;
  String? get floorNo => _floorNo;
  String? get buildingNo => _buildingNo;
  String? get bookingID => _bookingID;
  String? get apartmentType => _apartmentType;
  String? get apartmentNo => _apartmentNo;
  String? get agreementValue => _agreementValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type_of_Parking'] = _typeOfParking;
    map['RERA_Carpet_Area'] = _rERACarpetArea;
    map['Number_of_Parking_Spaces'] = _numberOfParkingSpaces;
    map['Floor_No'] = _floorNo;
    map['Building_No'] = _buildingNo;
    map['bookingID'] = _bookingID;
    map['Apartment_Type'] = _apartmentType;
    map['Apartment_No'] = _apartmentNo;
    map['Agreement_Value'] = _agreementValue;
    return map;
  }

}