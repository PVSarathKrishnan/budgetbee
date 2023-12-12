// import 'dart:js_util';

// class Solution {
//   List<int> twoOutOfThree(List<int> nums1, List<int> nums2, List<int> nums3) {
//     Set<int> result = {};
//     for (var i in nums1) {
//       if (nums2.contains(i)) {
//         result.add(i);
//       } else if (nums3.contains(i)) {
//         result.add(i);
//       }
//     }
//     for (var j in nums2) {
//       if (nums3.contains(j)) {
//         result.add(j);
//       }
//     }
//     return result.toList();
//   }
// }



// // Future<void> addAppointmentButton()async{

// //   final String title=selectedTitle ?? "";
// //   final String name=_nameController.text.trim();
// //   final String gender = selectedGender ?? ""; 
// //   final String dob=_dobController.text.trim();
// //   final String marital=selectedMarital ?? ""; 
// //   final String email=_emailController.text.trim();
// //   final String mobile=_mobileController.text.trim();
// //   final String address=_addressController.text.trim();
// //   final DateTime date=DateTime.now();
// //   final String user=currentUser!.fullname;
  


// //   if(_formKey.currentState!.validate()){
// //     //print("validated");
// //     final appointment=AppointmentModel(name: name, gender: gender, dob: dob, marital: marital, email: email, mobile: mobile, address: address,title:title,date: date,user: user) ;
// //     addAppointment(appointment);
// //     showSnackBarSuccess(context, 'We will contact you soon');
// //     Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
// //   }
// //   else{
// //     setState(() {
// //       //showError = true;
// //     });


// //     showSnackBarFailed(context, "Enquiry couldn't be placed. Try again ");
// //   }
// // }


// // import 'package:hive/hive.dart';
// // part 'appointment_model.g.dart';

// // @HiveType(typeId: 6)
// // class AppointmentModel extends HiveObject{

// //   @HiveField(0)
// //    int? id;

// //   @HiveField(1)
// //    String name;

// //    @HiveField(2)
// //    String gender;

// //    @HiveField(3)
// //    String dob;

// //    @HiveField(4)
// //    String marital;

// //    @HiveField(5)
// //    String email;

// //    @HiveField(6)
// //    String mobile;

// //    @HiveField(7)
// //    String address;

// //    @HiveField(8)
// //    String title;

// //    @HiveField(9)
// //    final DateTime date;

// //    @HiveField(10)
// //    final String user;

// //    AppointmentModel({required this.name,required this.gender,required this.dob,required this.marital,required this.email,required this.mobile,required this.address,required this.title,required this.date,required this.user, this.id});
  
// // }