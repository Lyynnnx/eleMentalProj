class Patient{
  Patient({required this.imgurl, required this.name, required this.backstory, required this.gender, required this.coreSypmtoms, required this.diagnosis,
  required this.occupation, required this.communicationStyle, required this.personalityTraits, required this.age});
  String imgurl;
  String name;
  String backstory;
  String gender;
  List<String> coreSypmtoms;
  String diagnosis;
  String occupation;
  String communicationStyle;
  List<String> personalityTraits;
  int age;
}