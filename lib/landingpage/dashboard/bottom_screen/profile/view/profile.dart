// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/auth/views/welcomeScreen.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/payout.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/profileview.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../services/shared_preferance.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool? _toggleValue;

  File? imageFile;
  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callFutureFunction();
  }

  callFutureFunction() async {
    final value = await SharedPreferanceClass.getNotifiationSound();
    setState(() {
       _toggleValue = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferanceClass.getUserDetails(),
      builder: (context,snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                snapshot.data?['username'],
                style: AppTextStyles.kBody17SemiboldTextStyle
                    .copyWith(color: AppColors.neutralDark),
              ),
            ),
            body: Column(
              children: [
                Center(
                  child:GestureDetector(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.primary700,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : const AssetImage(Deliveryboy) as ImageProvider,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ConstantListTile("Profile Details",profile,() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileDetails()));
                },),
                ConstantListTile("Contact Us Details",contact,() {

                },),
                ConstantListTile("Sound Setting",sound,() {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Sound'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('On/Off'),
                                Transform.scale(
                                  scale: .9,
                                  child: CupertinoSwitch(
                                    activeColor: Colors.green,
                                    value: _toggleValue??false,
                                    onChanged: (bool newValue) {
                                      SharedPreferanceClass.setNotifiationSound(isSoundEnabled: newValue);
                                      setState(() {
                                        _toggleValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );

                },),
                ConstantListTile("Payout",payout,() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const WalletPageScreen()));
                },),
                ConstantListTile("Stop Reminder",stop,() {

                },),
                ConstantListTile("Logout",logout,() {
                  show(AlertDialog(
                    content: const Text('Do you really want to logout ?'),
                    actions: [
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          SharedPreferanceClass.saveUserLoggedInSharedPreferace(false);
                          SharedPreferanceClass.remove();
                          Get.offAll(const WelcomeScreen());
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
                },),
              ],
            ),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }

      }
    );
  }

  ConstantListTile(
    final String title,
    final String leading,
    final VoidCallback ontap,
  ) {
    return FutureBuilder(
      future:  SharedPreferanceClass.getUserDetails(),
      builder: (context,snapshot) {
        return Column(
          children: [
            InkWell(
              onTap: ontap,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: AppColors.neutral20,
                    child: Image.asset(
                      leading,
                    )),
                title: Text(
                  title,
                  style: AppTextStyles.kCaption12RegularTextStyle
                      .copyWith(color: AppColors.neutralDark),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.neutral50,
                  size: 20,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(25, 0, 8, 0),
            //   child: ConstantContainer(height: 0.0008, width: MediaQuery.of(context).size.width*0.9, radiusBorder: 0, borderWidth: 0, widget: Text("data"), borderColor: AppColors.neutralBackground,color: AppColors.neutralBorder,),
            // )

          ],
        );
      }
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  _selectImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  _selectImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }



 void show(
     Widget widgets
     ){
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return widgets;
     },
   );
 }



}
