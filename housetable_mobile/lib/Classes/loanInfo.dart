// relationship_seller: {
//         id: 1,
//        type:'represent',
//         text:'i represent the owner'
//     },
//     start_renovations: ASAP
//     estimate: $200,000
//     estimate_after_renovations: $250,000
//     debt: $100,000, 
//     streetNumber: 232
//     streetName: crown heights
//     municipalitySubdivision: brooklyn
//     municipality: new york
//     countrySubdivision: ny
//     postalCode: 4566
//     user_form_conditions: {
//         Kitchen: 1,
//         Bathroom: 2,
//         interior_paint: 3,
//         Roofing: 4,
//         Appliances: 5,
//         Floors: 1,
//     },
//     data_property: {
//         bedrooms: 3,
//         Bathrooms: 3,
//         square_footage: 123,
//         year_build: 1980,
//     },
class UserFormConditions{
  int kitchen;
  int bathroom;
  int interiorPaint; 
  int roofing;
  int appliances;
  int floors;

  UserFormConditions({this.kitchen, this.bathroom, this.interiorPaint, this.roofing, this.appliances, this.floors});

}

class DataProperty{
  int bedrooms;
  int bathrooms;
  int squareFootage; 
  int yearbuilt;

DataProperty({this.bedrooms,this.bathrooms, this.squareFootage,this.yearbuilt});
  
}

class LoanInfo {
  String startRenovation;
  int estPrice;
  int rio;
  int debt;
  String  countrySubdivision;
  String municipality;
  String municipalitySubdivision; 
  String streetName;
  int streetNumber;
  int postalCode;
  DataProperty dataProperty;
  UserFormConditions userFormConditions;

  LoanInfo({this.countrySubdivision, this.dataProperty, this.debt, this.estPrice, this.municipality, this.municipalitySubdivision, this.postalCode, this.rio, this.startRenovation, this.streetName, this.streetNumber, this.userFormConditions});

  String get_adress_line_1(){
    return countrySubdivision + ' ' + municipality + ' ' + municipalitySubdivision;
  }

  String get_adress_line_2(){
    return streetNumber.toString() + ' ' + streetName + ' St.';  
  }
}
