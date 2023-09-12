// Flutter imports:

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../const/constString.dart';
import '../../../../../services/shared_preferance.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.neutralDark,)),
        title: Text("Profile Details",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.neutralDark),),
        actions: [
          IconButton(onPressed: ()async{
            await openWhatsapp();
          }, icon: const Icon(Icons.message,color: Colors.black,))
        ],

        centerTitle: true,
      ),
      body: FutureBuilder(
          future: SharedPreferanceClass.getUserDetails(),
          builder: (context,snapshot) {
          return Column(
            children: [
              ConstTextField(label: 'Full Name', name: snapshot.data?['username'],),
              ConstTextField(label: 'Email', name: snapshot.data?['email1'],),
              ConstTextField(label: 'Phone Number', name: snapshot.data?['phone1'],),

            ],
          );
        }
      ),
    );
  }

  Future<void> openWhatsapp() async {
    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl),mode: LaunchMode.externalApplication);
      }
    } on Exception{
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }
 }

 class ConstTextField extends StatefulWidget {
  final String label;
  final String name ;
   const ConstTextField({Key? key, required this.label, required this.name}) : super(key: key);

   @override
   State<ConstTextField> createState() => _ConstTextFieldState();
 }

 class _ConstTextFieldState extends State<ConstTextField> {
  TextEditingController controller = TextEditingController();
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: TextFormField(
         readOnly: true,
         controller: controller..text=widget.name,
         decoration: InputDecoration(
           border: const UnderlineInputBorder(),
           focusedBorder: const UnderlineInputBorder(),
           enabledBorder: const UnderlineInputBorder(),
           labelText: widget.label,
           labelStyle: AppTextStyles.kBody15RegularTextStyle
         ),
       ),
     );
   }
 }
