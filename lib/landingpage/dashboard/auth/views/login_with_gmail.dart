// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/bottomnavbar.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../controller/login_controller.dart';

// import 'package:google_sign_in/google_sign_in.dart';





class LoginWithGmail extends StatefulWidget {
  const LoginWithGmail({Key? key}) : super(key: key);

  @override
  State<LoginWithGmail> createState() => _LoginWithGmailState();
}

class _LoginWithGmailState extends State<LoginWithGmail> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 44,
      width: size.width * 0.85,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: AppColors.white,
          ),
          onPressed: () async {
            // Sign in with Google and get the user credential
            final UserCredential userCredential = await _signInWithGoogle();

            // Access user data
            final User? user = userCredential.user;
            final String? gmail = user?.email;
             //TODO:CHECK ON WHY GOOGLE SIGN IN NOT WORKING @SURAJ
            if(gmail!=null){
              final result = await _loginController.loginUser(gmail);
              if(result?.status==1){
                if(!mounted)return;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const Bottom_Page()));
              }else{
                setState(() {
                  _isLoading = false;
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
              }
            }

            // print('Gmail: $gmail');
            // print('Name: $name');
            // register_user('email', gmail.toString(), name.toString());
            // setState(() {
            // _isLoading = true;
            // });
          },
          child: Center(
            child: !_isLoading?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(google,height: 35,width: 35,),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Google',
                  style: AppTextStyles.kBody15RegularTextStyle
                      .copyWith(color: AppColors.neutralLight),
                )
              ],
            ):const CircularProgressIndicator(color: AppColors.primary,),
          )),
    );
  }

  register_user(
    String type,
    String email,
    String? name,
  ) async {
    final response = await http.post(
      Uri.parse("https://bazarapp.cloud/api/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "login_type": type,
        "email_phone": email,
        "name": name!,
      }),
    );
    var data = jsonDecode(response.body);
 if (response.statusCode == 200) {
      var userid = data["data"]["id"];
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = userid.toString();
      prefs.setString(key, userId);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Bottom_Page()));
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select one gmail account'),
        ),
      );
    }
  }

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> _signInWithGoogle() async {
    setState(() {
      _isLoading = true; // Start the loading state
    });
    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential with the token
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in to Firebase with the Google credential
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    setState(() {
      _isLoading = false; // End the loading state
    });

    return userCredential;
  }
}
