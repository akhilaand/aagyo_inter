// Flutter imports:
import 'package:aagyo/services/core.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../colors/colors_const.dart';
import '../../../../../const/constContainer.dart';
import '../../../../../const/constString.dart';
import '../../../../../modal/list_order_modal.dart';
import '../../../../../styles/textstyle_const.dart';

class VaccinatedConstant extends StatelessWidget {
  final Color callColor;
  final DelievryMan? deliveryPartnerDetails;
  const VaccinatedConstant({Key? key, required this.callColor, this.deliveryPartnerDetails, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstantContainer(
      // color: Colors.red,
        height: .07,
        width: .9,
        radiusBorder: 5,
        borderWidth: 0,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network((deliveryPartnerDetails?.user?.imageUrl).toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*.52,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Delivery partner",
                      style: AppTextStyles.kSmall8RegularTextStyle
                          .copyWith(color: AppColors.neutralLightFonts),
                    ),
                    Text(
                      "${deliveryPartnerDetails?.user?.fName} ${deliveryPartnerDetails?.user?.lName}",
                      style: AppTextStyles.kCaption12SemiboldTextStyle
                          .copyWith(color: AppColors.neutralDark),
                    ),
                    ConstantContainer(
                        height: 0.02,
                        width: 0.2,
                        radiusBorder: 2,
                        borderWidth: 0.5,
                        color: AppColors.primary400,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(vaccine),
                            Text(
                              "Vaccinated",
                              style: AppTextStyles.kCaption12RegularTextStyle
                                  .copyWith(color: AppColors.neutralDark),
                            )
                          ],
                        ),
                        borderColor: AppColors.primary400)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                // saving in variable to avoid use of null aware operator
                String? deliveryBoyPhoneNumber = deliveryPartnerDetails?.user?.phone.toString();
                if(deliveryBoyPhoneNumber!=null){
                  launchCaller(phoneNumber: deliveryBoyPhoneNumber);
                }
              },
              child: ConstantContainer(

                  height: 0.05,
                  width: 0.1,
                  radiusBorder: 5,
                  borderWidth: 0.5,
                  color: callColor,
                  widget: const Icon(
                    Icons.call,
                    size: 30,
                    color: AppColors.white,
                  ),
                  borderColor: AppColors.primary700),
            )
          ],
        ),
        borderColor: Colors.white10);
  }
}
