// class ContactsModel {
//   static const String collectionName = "calls";
//   String? id;
//   String? imgPathh;
//   String? nametext;
//   String? numbertext;
//   String? relation;
//
//   ContactsModel({
//     this.id = "",
//     required this.nametext,
//     required this.numbertext,
//     required this.relation,
//     required this.imgPathh,
//   });
//
//   ContactsModel.fromJson(Map<String, dynamic> json)
//       : this(
//     id: json["id"],
//     imgPath: json["imgPathh"],
//     name: json["name"],
//     number: json["number"],
//     relation: json["relation"],
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "imgPath": imgPathh,
//       "name": nametext,
//       "number": numbertext,
//       "relation": relation,
//     };
//   }
// }