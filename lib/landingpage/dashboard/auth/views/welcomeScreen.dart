// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/auth/views/login_with_gmail.dart';
import 'package:aagyo/landingpage/dashboard/auth/views/sign_signup_button_widget.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../controllers/auth_controller.dart';
import 'otp_verification.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String verify = "";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController countrycode = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final AuthControllerNew authControllerNew = Get.put(AuthControllerNew());
  final TextEditingController phoneNumberController = TextEditingController();
  late String countryCode;
  late String? phoneNumber;
  var phone = "";
  late String? _textInput;
  bool _isChecked = true;

  // List<DropdownMenuItem<String>> countryCodesDropdown = [
  //   const DropdownMenuItem(
  //     value: '+1',
  //     child: Text('+1'),
  //   ),
  //   const DropdownMenuItem(
  //     value: '+44',
  //     child: Text('+44'),
  //   ),
  //   const DropdownMenuItem(
  //     value: '+91',
  //     child: Text('+91'),
  //   ),
  //   const DropdownMenuItem(
  //     value: '+234',
  //     child: Text('+234'),
  //   ),
  // ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   countryCode = '+91';
  //   //countrycode.text = "+234";
  // }


  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 72,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to AAGYO !',
                  style: AppTextStyles.kHeading1TextStyle.copyWith(
                    color: AppColors.primary700,
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(
                child: Image.asset(
                  welcome,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                'Login with Phone',
                style: AppTextStyles.kBody20SemiboldTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                'We will send you an One Time Password',
                style: AppTextStyles.kCaption12RegularTextStyle.copyWith(
                  color: const Color.fromRGBO(100, 116, 139, 1),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'on this mobile number',
                  style: AppTextStyles.kCaption12RegularTextStyle.copyWith(
                    color: const Color.fromRGBO(100, 116, 139, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        onChanged: (text) {
                          setState(() {
                            _textInput = text;
                            phone = text;
                          });
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Enter mobile number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(203, 212, 225, 1),
                            ),
                          ),
                          prefixText: '+91 ',
                          prefixStyle: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.cancel_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              phoneNumberController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SignInUpButtonWidget(
                text:  !_isloading?'Get Otp':'circular',
                onpressed: () async {
                  final String phone = phoneNumberController.text.trim();

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(text:phoneNumberController.text,phoneNumber: phone,)));
                  setState(() {
                    _isloading = true;
                  });
                  if (phone.isNotEmpty) {
                    phoneNumber = '+91$phone';
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber!,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {
                        //TODO:IMPLEMENT PHONE AUTH HERE
                          },
                      verificationFailed: (FirebaseAuthException e) {
                        setState(() {
                          _isloading = false;
                        });
                        Get.showSnackbar(const GetSnackBar(
                          titleText: Text(
                            "Login Failed",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                          messageText: Text(
                            "Not a SignedIn User",
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.grey,
                          icon: Icon(
                            Icons.add_alert,
                            color: Colors.white,
                          ),
                        ));
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        WelcomeScreen.verify = verificationId;
                        // print('OTP:' + verificationId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtpVerification(phoneNumber: _textInput!,),
                          ),
                        );
                        setState(() {
                          _isloading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    activeColor: Colors.transparent,
                    checkColor: AppColors.primary,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? true;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: const BorderSide(
                        width: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'I agree Terms and Conditions',
                    style: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: const Color.fromRGBO(100, 116, 139, 1)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 1.5,
                      width: size.width * 0.25,
                      color: const Color.fromRGBO(100, 116, 139, 1),
                    ),
                    Text(
                      'Or Connect With',
                      style: AppTextStyles.kSmall10RegularTextStyle
                          .copyWith(color: AppColors.neutralLight),
                    ),
                    Container(
                      height: 1.5,
                      width: size.width * 0.25,
                      color: const Color.fromRGBO(100, 116, 139, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LoginWithGmail(),
            ],
          ),
        ),
      ),
    );
  }
}
