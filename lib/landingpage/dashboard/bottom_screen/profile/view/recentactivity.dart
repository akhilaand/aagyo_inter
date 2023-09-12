// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../../../colors/colors_const.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final TextEditingController _controller = TextEditingController();
  // final ValueNotifier<PriceContainer?> _selectedContainer = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.white40.withOpacity(0.6),
                blurRadius: 100,
                spreadRadius: 2,
                offset: const Offset(0, 70))
          ]),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                 Text(
                      'Withdrawalable amount',
                      style: AppTextStyles.kBody15RegularTextStyle,
                    ),
                    Text(
                      'view details',
                      style: AppTextStyles.kSmall10RegularTextStyle,
                    ),

                  ],
                ),
                Spacer(),
                Text(
                  '₹500',
                  style: AppTextStyles.kBody15SemiboldTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: AppColors.white30,
                  filled: true,
                  hintStyle: TextStyle(color: AppColors.neutralLightFonts),
                  hintText: "1000",

                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white10)),
                ),
              ),
            ),


            SizedBox(
              height: 40,
              width: size.width * 0.85,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary700),
                  onPressed: () {},
                  child: Text(
                    'Withdraw',
                    style: AppTextStyles.kBody15SemiboldTextStyle
                        .copyWith(color: AppColors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
// class PriceContainer extends StatelessWidget {
//   final String price;
//   final TextEditingController controller;
//   final ValueNotifier<PriceContainer?> selectedContainer;
//
//   PriceContainer({
//     super.key,
//     required this.price,
//     required this.controller,
//     required this.selectedContainer,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: selectedContainer,
//       builder: (context, value, _) {
//         return GestureDetector(
//           onTap: () {
//             controller.text = price;
//
//             if (value != null) {
//               value.isSelected = false;
//             }
//
//             isSelected = true;
//             selectedContainer.value = this;
//           },
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.primary700 : Colors.grey[300],
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: Text(
//               '₹$price',
//               style: TextStyle(
//                 color: isSelected ? AppColors.white : Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   bool _isSelected = false;
//   bool get isSelected => _isSelected;
//   set isSelected(bool value) {
//     _isSelected = value;
//   }
// }
