// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/home_page.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/addStory/status.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/addproduct.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/widgets/consttabbar.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/profile.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../colors/colors_const.dart';
import 'bottom_screen/menu/widgets/tabbar.dart';

class Bottom_Page extends StatefulWidget {
  const Bottom_Page({Key? key}) : super(key: key);

  @override
  State<Bottom_Page> createState() => _Bottom_PageState();
}

class _Bottom_PageState extends State<Bottom_Page> {
  int _currentindex = 0;
  final Screen = [
    const Home_Page(),
    const OrderScreen(),

    const Text("order"),

    const MenuTabbar(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Screen[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        // type: BottomNavigationBarType.shifting,
        fixedColor: AppColors.primary700,
        unselectedItemColor: AppColors.neutralLightFonts,
        showUnselectedLabels: true,
        enableFeedback: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.unfold_more,size: 20,),
              label: 'Order',
              // backgroundColor:ConstantColor.bottomnav
    ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Add',
              // backgroundColor:ConstantColor.bottomnav
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Menu',
              // backgroundColor:ConstantColor.bottomnav
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
              // backgroundColor:ConstantColor.bottomnav
          ),


        ],
        onTap: (index)=>{
          if(index==2){
            _showDialog()
        }else{
          setState(() {
    _currentindex = index;
    })
        }

        },
      ),

    );
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [

            Positioned(
              bottom: 40,
              child: Container(
                child: Dialog(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstRow(name: "Add Story",img:story, ontap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Status()));
                      },),
                      ConstRow(name: "Add Products",img:productStory, ontap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProduct()));
                      },),
                      // ConstRow(name: "Add Category",img:productStory, ontap: () {
                      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategory()));
                      // },),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

  }
}



class ConstRow extends StatelessWidget {
  final String? name;
  final String? img;
  final VoidCallback ontap;
  const ConstRow({Key? key, this.name, this.img, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: ontap,
          child: SizedBox(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*.12,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Image.asset(img.toString()),
                Text(name.toString(),style: AppTextStyles.kCaption12RegularTextStyle,),


              ],
            ),
          ),
        ),
      ],
    );
  }
}
