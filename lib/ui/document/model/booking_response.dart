/// returnCode : true
/// responselist : [{"UnitNo":"105","UnitCost_Discount":"10144","UnitCost":"1000000","TransferCharges_S":"24245","TransferCharges":"454","Tower":"Tower1","SwimmingPoolChgs":"4545","StampDuty_S":"2223","SONumber":1011,"SocietyFormaChgs_S":"1617","SocietyFormaChgs":"4545","SocietyDeposits_S":"2021","ShareMoney_S":"1819","SGST":"18","SalesDiscount":"1213","RegistrationCharges":"1415","Reco_FitoutSuppSer":"4545","Re_DocCharges":"454","ProjectDescription":"K Raheja Corp Homes has always strived to give South Pune the best it deserves. And now, we bring you large 3 bed homes at Raheja Reserve, the most acclaimed development of South Pune. Be it the amenities like multiple themed gardens that evoke pure admiration, 600+ trees, and expansive greens that let your heart wander, every aspect here is truly iconic. Add to this, the unmatched convenience and excellent connectivity of NIBM, and there is nothing more you would wish for.","Project":"KRC","PipedGasConnChgs":"4545","MiscellaneousChgs":"54545","LegalCharges":"545454","LandCost_S":"789","LandAbatement":"4545","InterestUnitCost_S":"123","Interest_UnitCost":"54545","Infrast_Utilities":"54545","GSTAntiProft_Disc":"552","GardenCharges":"4545","FurnitureCharges":"4545","ForfeitureCharges":"4544","ExtraWork":"454","ExtraAmenities":"45454","ElecyMeterDeposit_S":null,"Ele_SubStnCharges":"4545","CorpusFund_S":"444","CondominiumDepos_S":"444","Co_Owner_6":null,"Co_Owner_5":null,"Co_Owner_4":null,"Co_Owner_3":null,"Co_Owner_2":"test coowner 2","Co_Owner_1":"test coowner1","ClubHousMemChgs":"33435","ClubHouseDeposit_S":"333","CGST":"12","CableTVCharges":"454","CableLyingCharge":"454","BudgetofCustomer":"14111111","Brokerage_ZE":"333","Brokerage_ZD":"22","Brokerage_ZC":"111","Brokerage_ZB":"333","bookingID":"a013C00000AKnAZQA1","BMC_CorpDeposit":"153","ApexBodyDeposits":"555","AnualSubcofClub":"2627","AHUContractualWork":"2829","AHUCharges_S":"5555","AHUCharges":"3132","AgreementValue":null,"AdvanceLeaseRent":"3031","Address":"KRC ESTATE , SOUTH PUNE","AdditionalSGST":"456","AdditionalCGST":"756"}]
/// message : "SUCCESS"

class BookingResponse {
  BookingResponse({
    bool returnCode,
    List<Responselist> responselist,
    String message,
  }) {
    _returnCode = returnCode;
    _responselist = responselist;
    _message = message;
  }

  BookingResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    if (json['responselist'] != null) {
      _responselist = [];
      json['responselist'].forEach((v) {
        _responselist.add(Responselist.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool _returnCode;
  List<Responselist> _responselist;
  String _message;

  bool get returnCode => _returnCode;

  List<Responselist> get responselist => _responselist;

  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    if (_responselist != null) {
      map['responselist'] = _responselist.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

/// UnitNo : "105"
/// UnitCost_Discount : "10144"
/// UnitCost : "1000000"
/// TransferCharges_S : "24245"
/// TransferCharges : "454"
/// Tower : "Tower1"
/// SwimmingPoolChgs : "4545"
/// StampDuty_S : "2223"
/// SONumber : 1011
/// SocietyFormaChgs_S : "1617"
/// SocietyFormaChgs : "4545"
/// SocietyDeposits_S : "2021"
/// ShareMoney_S : "1819"
/// SGST : "18"
/// SalesDiscount : "1213"
/// RegistrationCharges : "1415"
/// Reco_FitoutSuppSer : "4545"
/// Re_DocCharges : "454"
/// ProjectDescription : "K Raheja Corp Homes has always strived to give South Pune the best it deserves. And now, we bring you large 3 bed homes at Raheja Reserve, the most acclaimed development of South Pune. Be it the amenities like multiple themed gardens that evoke pure admiration, 600+ trees, and expansive greens that let your heart wander, every aspect here is truly iconic. Add to this, the unmatched convenience and excellent connectivity of NIBM, and there is nothing more you would wish for."
/// Project : "KRC"
/// PipedGasConnChgs : "4545"
/// MiscellaneousChgs : "54545"
/// LegalCharges : "545454"
/// LandCost_S : "789"
/// LandAbatement : "4545"
/// InterestUnitCost_S : "123"
/// Interest_UnitCost : "54545"
/// Infrast_Utilities : "54545"
/// GSTAntiProft_Disc : "552"
/// GardenCharges : "4545"
/// FurnitureCharges : "4545"
/// ForfeitureCharges : "4544"
/// ExtraWork : "454"
/// ExtraAmenities : "45454"
/// ElecyMeterDeposit_S : null
/// Ele_SubStnCharges : "4545"
/// CorpusFund_S : "444"
/// CondominiumDepos_S : "444"
/// Co_Owner_6 : null
/// Co_Owner_5 : null
/// Co_Owner_4 : null
/// Co_Owner_3 : null
/// Co_Owner_2 : "test coowner 2"
/// Co_Owner_1 : "test coowner1"
/// ClubHousMemChgs : "33435"
/// ClubHouseDeposit_S : "333"
/// CGST : "12"
/// CableTVCharges : "454"
/// CableLyingCharge : "454"
/// BudgetofCustomer : "14111111"
/// Brokerage_ZE : "333"
/// Brokerage_ZD : "22"
/// Brokerage_ZC : "111"
/// Brokerage_ZB : "333"
/// bookingID : "a013C00000AKnAZQA1"
/// BMC_CorpDeposit : "153"
/// ApexBodyDeposits : "555"
/// AnualSubcofClub : "2627"
/// AHUContractualWork : "2829"
/// AHUCharges_S : "5555"
/// AHUCharges : "3132"
/// AgreementValue : null
/// AdvanceLeaseRent : "3031"
/// Address : "KRC ESTATE , SOUTH PUNE"
/// AdditionalSGST : "456"
/// AdditionalCGST : "756"

class Responselist {
  Responselist({
    String unitNo,
    String unitCostDiscount,
    String unitCost,
    String transferChargesS,
    String transferCharges,
    String tower,
    String swimmingPoolChgs,
    String stampDutyS,
    int sONumber,
    String societyFormaChgsS,
    String societyFormaChgs,
    String societyDepositsS,
    String shareMoneyS,
    String sgst,
    String salesDiscount,
    String registrationCharges,
    String recoFitoutSuppSer,
    String reDocCharges,
    String projectDescription,
    String project,
    String pipedGasConnChgs,
    String miscellaneousChgs,
    String legalCharges,
    String landCostS,
    String landAbatement,
    String interestUnitCostS,
    String interestUnitCost,
    String infrastUtilities,
    String gSTAntiProftDisc,
    String gardenCharges,
    String furnitureCharges,
    String forfeitureCharges,
    String extraWork,
    String extraAmenities,
    dynamic elecyMeterDepositS,
    String eleSubStnCharges,
    String corpusFundS,
    String condominiumDeposS,
    dynamic coOwner6,
    dynamic coOwner5,
    dynamic coOwner4,
    dynamic coOwner3,
    String coOwner2,
    String coOwner1,
    String clubHousMemChgs,
    String clubHouseDepositS,
    String cgst,
    String cableTVCharges,
    String cableLyingCharge,
    String budgetofCustomer,
    String brokerageZE,
    String brokerageZD,
    String brokerageZC,
    String brokerageZB,
    String bookingID,
    String bMCCorpDeposit,
    String apexBodyDeposits,
    String anualSubcofClub,
    String aHUContractualWork,
    String aHUChargesS,
    String aHUCharges,
    dynamic agreementValue,
    String advanceLeaseRent,
    String address,
    String additionalSGST,
    String additionalCGST,
  }) {
    _unitNo = unitNo;
    _unitCostDiscount = unitCostDiscount;
    _unitCost = unitCost;
    _transferChargesS = transferChargesS;
    _transferCharges = transferCharges;
    _tower = tower;
    _swimmingPoolChgs = swimmingPoolChgs;
    _stampDutyS = stampDutyS;
    _sONumber = sONumber;
    _societyFormaChgsS = societyFormaChgsS;
    _societyFormaChgs = societyFormaChgs;
    _societyDepositsS = societyDepositsS;
    _shareMoneyS = shareMoneyS;
    _sgst = sgst;
    _salesDiscount = salesDiscount;
    _registrationCharges = registrationCharges;
    _recoFitoutSuppSer = recoFitoutSuppSer;
    _reDocCharges = reDocCharges;
    _projectDescription = projectDescription;
    _project = project;
    _pipedGasConnChgs = pipedGasConnChgs;
    _miscellaneousChgs = miscellaneousChgs;
    _legalCharges = legalCharges;
    _landCostS = landCostS;
    _landAbatement = landAbatement;
    _interestUnitCostS = interestUnitCostS;
    _interestUnitCost = interestUnitCost;
    _infrastUtilities = infrastUtilities;
    _gSTAntiProftDisc = gSTAntiProftDisc;
    _gardenCharges = gardenCharges;
    _furnitureCharges = furnitureCharges;
    _forfeitureCharges = forfeitureCharges;
    _extraWork = extraWork;
    _extraAmenities = extraAmenities;
    _elecyMeterDepositS = elecyMeterDepositS;
    _eleSubStnCharges = eleSubStnCharges;
    _corpusFundS = corpusFundS;
    _condominiumDeposS = condominiumDeposS;
    _coOwner6 = coOwner6;
    _coOwner5 = coOwner5;
    _coOwner4 = coOwner4;
    _coOwner3 = coOwner3;
    _coOwner2 = coOwner2;
    _coOwner1 = coOwner1;
    _clubHousMemChgs = clubHousMemChgs;
    _clubHouseDepositS = clubHouseDepositS;
    _cgst = cgst;
    _cableTVCharges = cableTVCharges;
    _cableLyingCharge = cableLyingCharge;
    _budgetofCustomer = budgetofCustomer;
    _brokerageZE = brokerageZE;
    _brokerageZD = brokerageZD;
    _brokerageZC = brokerageZC;
    _brokerageZB = brokerageZB;
    _bookingID = bookingID;
    _bMCCorpDeposit = bMCCorpDeposit;
    _apexBodyDeposits = apexBodyDeposits;
    _anualSubcofClub = anualSubcofClub;
    _aHUContractualWork = aHUContractualWork;
    _aHUChargesS = aHUChargesS;
    _aHUCharges = aHUCharges;
    _agreementValue = agreementValue;
    _advanceLeaseRent = advanceLeaseRent;
    _address = address;
    _additionalSGST = additionalSGST;
    _additionalCGST = additionalCGST;
  }

  Responselist.fromJson(dynamic json) {
    _unitNo = json['UnitNo'];
    _unitCostDiscount = json['UnitCost_Discount'];
    _unitCost = json['UnitCost'];
    _transferChargesS = json['TransferCharges_S'];
    _transferCharges = json['TransferCharges'];
    _tower = json['Tower'];
    _swimmingPoolChgs = json['SwimmingPoolChgs'];
    _stampDutyS = json['StampDuty_S'];
    _sONumber = json['SONumber'];
    _societyFormaChgsS = json['SocietyFormaChgs_S'];
    _societyFormaChgs = json['SocietyFormaChgs'];
    _societyDepositsS = json['SocietyDeposits_S'];
    _shareMoneyS = json['ShareMoney_S'];
    _sgst = json['SGST'];
    _salesDiscount = json['SalesDiscount'];
    _registrationCharges = json['RegistrationCharges'];
    _recoFitoutSuppSer = json['Reco_FitoutSuppSer'];
    _reDocCharges = json['Re_DocCharges'];
    _projectDescription = json['ProjectDescription'];
    _project = json['Project'];
    _pipedGasConnChgs = json['PipedGasConnChgs'];
    _miscellaneousChgs = json['MiscellaneousChgs'];
    _legalCharges = json['LegalCharges'];
    _landCostS = json['LandCost_S'];
    _landAbatement = json['LandAbatement'];
    _interestUnitCostS = json['InterestUnitCost_S'];
    _interestUnitCost = json['Interest_UnitCost'];
    _infrastUtilities = json['Infrast_Utilities'];
    _gSTAntiProftDisc = json['GSTAntiProft_Disc'];
    _gardenCharges = json['GardenCharges'];
    _furnitureCharges = json['FurnitureCharges'];
    _forfeitureCharges = json['ForfeitureCharges'];
    _extraWork = json['ExtraWork'];
    _extraAmenities = json['ExtraAmenities'];
    _elecyMeterDepositS = json['ElecyMeterDeposit_S'];
    _eleSubStnCharges = json['Ele_SubStnCharges'];
    _corpusFundS = json['CorpusFund_S'];
    _condominiumDeposS = json['CondominiumDepos_S'];
    _coOwner6 = json['Co_Owner_6'];
    _coOwner5 = json['Co_Owner_5'];
    _coOwner4 = json['Co_Owner_4'];
    _coOwner3 = json['Co_Owner_3'];
    _coOwner2 = json['Co_Owner_2'];
    _coOwner1 = json['Co_Owner_1'];
    _clubHousMemChgs = json['ClubHousMemChgs'];
    _clubHouseDepositS = json['ClubHouseDeposit_S'];
    _cgst = json['CGST'];
    _cableTVCharges = json['CableTVCharges'];
    _cableLyingCharge = json['CableLyingCharge'];
    _budgetofCustomer = json['BudgetofCustomer'];
    _brokerageZE = json['Brokerage_ZE'];
    _brokerageZD = json['Brokerage_ZD'];
    _brokerageZC = json['Brokerage_ZC'];
    _brokerageZB = json['Brokerage_ZB'];
    _bookingID = json['bookingID'];
    _bMCCorpDeposit = json['BMC_CorpDeposit'];
    _apexBodyDeposits = json['ApexBodyDeposits'];
    _anualSubcofClub = json['AnualSubcofClub'];
    _aHUContractualWork = json['AHUContractualWork'];
    _aHUChargesS = json['AHUCharges_S'];
    _aHUCharges = json['AHUCharges'];
    _agreementValue = json['AgreementValue'];
    _advanceLeaseRent = json['AdvanceLeaseRent'];
    _address = json['Address'];
    _additionalSGST = json['AdditionalSGST'];
    _additionalCGST = json['AdditionalCGST'];
  }

  String _unitNo;
  String _unitCostDiscount;
  String _unitCost;
  String _transferChargesS;
  String _transferCharges;
  String _tower;
  String _swimmingPoolChgs;
  String _stampDutyS;
  int _sONumber;
  String _societyFormaChgsS;
  String _societyFormaChgs;
  String _societyDepositsS;
  String _shareMoneyS;
  String _sgst;
  String _salesDiscount;
  String _registrationCharges;
  String _recoFitoutSuppSer;
  String _reDocCharges;
  String _projectDescription;
  String _project;
  String _pipedGasConnChgs;
  String _miscellaneousChgs;
  String _legalCharges;
  String _landCostS;
  String _landAbatement;
  String _interestUnitCostS;
  String _interestUnitCost;
  String _infrastUtilities;
  String _gSTAntiProftDisc;
  String _gardenCharges;
  String _furnitureCharges;
  String _forfeitureCharges;
  String _extraWork;
  String _extraAmenities;
  dynamic _elecyMeterDepositS;
  String _eleSubStnCharges;
  String _corpusFundS;
  String _condominiumDeposS;
  dynamic _coOwner6;
  dynamic _coOwner5;
  dynamic _coOwner4;
  dynamic _coOwner3;
  String _coOwner2;
  String _coOwner1;
  String _clubHousMemChgs;
  String _clubHouseDepositS;
  String _cgst;
  String _cableTVCharges;
  String _cableLyingCharge;
  String _budgetofCustomer;
  String _brokerageZE;
  String _brokerageZD;
  String _brokerageZC;
  String _brokerageZB;
  String _bookingID;
  String _bMCCorpDeposit;
  String _apexBodyDeposits;
  String _anualSubcofClub;
  String _aHUContractualWork;
  String _aHUChargesS;
  String _aHUCharges;
  dynamic _agreementValue;
  String _advanceLeaseRent;
  String _address;
  String _additionalSGST;
  String _additionalCGST;

  String get unitNo => _unitNo;

  String get unitCostDiscount => _unitCostDiscount;

  String get unitCost => _unitCost;

  String get transferChargesS => _transferChargesS;

  String get transferCharges => _transferCharges;

  String get tower => _tower;

  String get swimmingPoolChgs => _swimmingPoolChgs;

  String get stampDutyS => _stampDutyS;

  int get sONumber => _sONumber;

  String get societyFormaChgsS => _societyFormaChgsS;

  String get societyFormaChgs => _societyFormaChgs;

  String get societyDepositsS => _societyDepositsS;

  String get shareMoneyS => _shareMoneyS;

  String get sgst => _sgst;

  String get salesDiscount => _salesDiscount;

  String get registrationCharges => _registrationCharges;

  String get recoFitoutSuppSer => _recoFitoutSuppSer;

  String get reDocCharges => _reDocCharges;

  String get projectDescription => _projectDescription;

  String get project => _project;

  String get pipedGasConnChgs => _pipedGasConnChgs;

  String get miscellaneousChgs => _miscellaneousChgs;

  String get legalCharges => _legalCharges;

  String get landCostS => _landCostS;

  String get landAbatement => _landAbatement;

  String get interestUnitCostS => _interestUnitCostS;

  String get interestUnitCost => _interestUnitCost;

  String get infrastUtilities => _infrastUtilities;

  String get gSTAntiProftDisc => _gSTAntiProftDisc;

  String get gardenCharges => _gardenCharges;

  String get furnitureCharges => _furnitureCharges;

  String get forfeitureCharges => _forfeitureCharges;

  String get extraWork => _extraWork;

  String get extraAmenities => _extraAmenities;

  dynamic get elecyMeterDepositS => _elecyMeterDepositS;

  String get eleSubStnCharges => _eleSubStnCharges;

  String get corpusFundS => _corpusFundS;

  String get condominiumDeposS => _condominiumDeposS;

  dynamic get coOwner6 => _coOwner6;

  dynamic get coOwner5 => _coOwner5;

  dynamic get coOwner4 => _coOwner4;

  dynamic get coOwner3 => _coOwner3;

  String get coOwner2 => _coOwner2;

  String get coOwner1 => _coOwner1;

  String get clubHousMemChgs => _clubHousMemChgs;

  String get clubHouseDepositS => _clubHouseDepositS;

  String get cgst => _cgst;

  String get cableTVCharges => _cableTVCharges;

  String get cableLyingCharge => _cableLyingCharge;

  String get budgetofCustomer => _budgetofCustomer;

  String get brokerageZE => _brokerageZE;

  String get brokerageZD => _brokerageZD;

  String get brokerageZC => _brokerageZC;

  String get brokerageZB => _brokerageZB;

  String get bookingID => _bookingID;

  String get bMCCorpDeposit => _bMCCorpDeposit;

  String get apexBodyDeposits => _apexBodyDeposits;

  String get anualSubcofClub => _anualSubcofClub;

  String get aHUContractualWork => _aHUContractualWork;

  String get aHUChargesS => _aHUChargesS;

  String get aHUCharges => _aHUCharges;

  dynamic get agreementValue => _agreementValue;

  String get advanceLeaseRent => _advanceLeaseRent;

  String get address => _address;

  String get additionalSGST => _additionalSGST;

  String get additionalCGST => _additionalCGST;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UnitNo'] = _unitNo;
    map['UnitCost_Discount'] = _unitCostDiscount;
    map['UnitCost'] = _unitCost;
    map['TransferCharges_S'] = _transferChargesS;
    map['TransferCharges'] = _transferCharges;
    map['Tower'] = _tower;
    map['SwimmingPoolChgs'] = _swimmingPoolChgs;
    map['StampDuty_S'] = _stampDutyS;
    map['SONumber'] = _sONumber;
    map['SocietyFormaChgs_S'] = _societyFormaChgsS;
    map['SocietyFormaChgs'] = _societyFormaChgs;
    map['SocietyDeposits_S'] = _societyDepositsS;
    map['ShareMoney_S'] = _shareMoneyS;
    map['SGST'] = _sgst;
    map['SalesDiscount'] = _salesDiscount;
    map['RegistrationCharges'] = _registrationCharges;
    map['Reco_FitoutSuppSer'] = _recoFitoutSuppSer;
    map['Re_DocCharges'] = _reDocCharges;
    map['ProjectDescription'] = _projectDescription;
    map['Project'] = _project;
    map['PipedGasConnChgs'] = _pipedGasConnChgs;
    map['MiscellaneousChgs'] = _miscellaneousChgs;
    map['LegalCharges'] = _legalCharges;
    map['LandCost_S'] = _landCostS;
    map['LandAbatement'] = _landAbatement;
    map['InterestUnitCost_S'] = _interestUnitCostS;
    map['Interest_UnitCost'] = _interestUnitCost;
    map['Infrast_Utilities'] = _infrastUtilities;
    map['GSTAntiProft_Disc'] = _gSTAntiProftDisc;
    map['GardenCharges'] = _gardenCharges;
    map['FurnitureCharges'] = _furnitureCharges;
    map['ForfeitureCharges'] = _forfeitureCharges;
    map['ExtraWork'] = _extraWork;
    map['ExtraAmenities'] = _extraAmenities;
    map['ElecyMeterDeposit_S'] = _elecyMeterDepositS;
    map['Ele_SubStnCharges'] = _eleSubStnCharges;
    map['CorpusFund_S'] = _corpusFundS;
    map['CondominiumDepos_S'] = _condominiumDeposS;
    map['Co_Owner_6'] = _coOwner6;
    map['Co_Owner_5'] = _coOwner5;
    map['Co_Owner_4'] = _coOwner4;
    map['Co_Owner_3'] = _coOwner3;
    map['Co_Owner_2'] = _coOwner2;
    map['Co_Owner_1'] = _coOwner1;
    map['ClubHousMemChgs'] = _clubHousMemChgs;
    map['ClubHouseDeposit_S'] = _clubHouseDepositS;
    map['CGST'] = _cgst;
    map['CableTVCharges'] = _cableTVCharges;
    map['CableLyingCharge'] = _cableLyingCharge;
    map['BudgetofCustomer'] = _budgetofCustomer;
    map['Brokerage_ZE'] = _brokerageZE;
    map['Brokerage_ZD'] = _brokerageZD;
    map['Brokerage_ZC'] = _brokerageZC;
    map['Brokerage_ZB'] = _brokerageZB;
    map['bookingID'] = _bookingID;
    map['BMC_CorpDeposit'] = _bMCCorpDeposit;
    map['ApexBodyDeposits'] = _apexBodyDeposits;
    map['AnualSubcofClub'] = _anualSubcofClub;
    map['AHUContractualWork'] = _aHUContractualWork;
    map['AHUCharges_S'] = _aHUChargesS;
    map['AHUCharges'] = _aHUCharges;
    map['AgreementValue'] = _agreementValue;
    map['AdvanceLeaseRent'] = _advanceLeaseRent;
    map['Address'] = _address;
    map['AdditionalSGST'] = _additionalSGST;
    map['AdditionalCGST'] = _additionalCGST;
    return map;
  }

  // Project ,unit no, address ,tower booking id
  Map<String, dynamic> toJsonX() {
    final map = <String, dynamic>{};
    map['UnitCost_Discount'] = _unitCostDiscount;
    map['UnitCost'] = _unitCost;
    map['TransferCharges_S'] = _transferChargesS;
    map['TransferCharges'] = _transferCharges;
    map['SwimmingPoolChgs'] = _swimmingPoolChgs;
    map['StampDuty_S'] = _stampDutyS;
    map['SONumber'] = _sONumber;
    map['SocietyFormaChgs_S'] = _societyFormaChgsS;
    map['SocietyFormaChgs'] = _societyFormaChgs;
    map['SocietyDeposits_S'] = _societyDepositsS;
    map['ShareMoney_S'] = _shareMoneyS;
    map['SGST'] = _sgst;
    map['SalesDiscount'] = _salesDiscount;
    map['RegistrationCharges'] = _registrationCharges;
    map['Reco_FitoutSuppSer'] = _recoFitoutSuppSer;
    map['Re_DocCharges'] = _reDocCharges;
    map['PipedGasConnChgs'] = _pipedGasConnChgs;
    map['MiscellaneousChgs'] = _miscellaneousChgs;
    map['LegalCharges'] = _legalCharges;
    map['LandCost_S'] = _landCostS;
    map['LandAbatement'] = _landAbatement;
    map['InterestUnitCost_S'] = _interestUnitCostS;
    map['Interest_UnitCost'] = _interestUnitCost;
    map['Infrast_Utilities'] = _infrastUtilities;
    map['GSTAntiProft_Disc'] = _gSTAntiProftDisc;
    map['GardenCharges'] = _gardenCharges;
    map['FurnitureCharges'] = _furnitureCharges;
    map['ForfeitureCharges'] = _forfeitureCharges;
    map['ExtraWork'] = _extraWork;
    map['ExtraAmenities'] = _extraAmenities;
    map['ElecyMeterDeposit_S'] = _elecyMeterDepositS;
    map['Ele_SubStnCharges'] = _eleSubStnCharges;
    map['CorpusFund_S'] = _corpusFundS;
    map['CondominiumDepos_S'] = _condominiumDeposS;
    map['Co_Owner_6'] = _coOwner6;
    map['Co_Owner_5'] = _coOwner5;
    map['Co_Owner_4'] = _coOwner4;
    map['Co_Owner_3'] = _coOwner3;
    map['Co_Owner_2'] = _coOwner2;
    map['Co_Owner_1'] = _coOwner1;
    map['ClubHousMemChgs'] = _clubHousMemChgs;
    map['ClubHouseDeposit_S'] = _clubHouseDepositS;
    map['CGST'] = _cgst;
    map['CableTVCharges'] = _cableTVCharges;
    map['CableLyingCharge'] = _cableLyingCharge;
    map['BudgetofCustomer'] = _budgetofCustomer;
    map['Brokerage_ZE'] = _brokerageZE;
    map['Brokerage_ZD'] = _brokerageZD;
    map['Brokerage_ZC'] = _brokerageZC;
    map['Brokerage_ZB'] = _brokerageZB;
    map['BMC_CorpDeposit'] = _bMCCorpDeposit;
    map['ApexBodyDeposits'] = _apexBodyDeposits;
    map['AnualSubcofClub'] = _anualSubcofClub;
    map['AHUContractualWork'] = _aHUContractualWork;
    map['AHUCharges_S'] = _aHUChargesS;
    map['AHUCharges'] = _aHUCharges;
    map['AgreementValue'] = _agreementValue;
    map['AdvanceLeaseRent'] = _advanceLeaseRent;
    map['AdditionalSGST'] = _additionalSGST;
    map['AdditionalCGST'] = _additionalCGST;
    return map;
  }
}
