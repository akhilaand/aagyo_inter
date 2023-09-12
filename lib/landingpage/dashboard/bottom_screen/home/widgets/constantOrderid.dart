// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../colors/colors_const.dart';
import '../../../../../const/constString.dart';
import '../../../../../styles/textstyle_const.dart';

class ConstantOrderId extends StatefulWidget {
final Datum item;
  final String status;
  final Widget widgets;
  final Color? color;
  final Color? colorBorder;
  final Color? dividerColor;

  const ConstantOrderId(
      {Key? key,
      required this.status,
      this.color,
      this.colorBorder,
      this.dividerColor,
      required this.widgets,
      required this.item
      })
      : super(key: key);
  @override
  State<ConstantOrderId> createState() => _ConstantOrderIdState();
}

class _ConstantOrderIdState extends State<ConstantOrderId> {

  List orderPlacedDateAndTime= [];
  @override
  void initState() {
    // TODO: implement initState
    getOrderPlacedDateAndTime(orderPlacedDateTime:widget.item.orderDate.toString());
    super.initState();
  }
  getOrderPlacedDateAndTime({required String orderPlacedDateTime}){
    String orderPlacedDate = "";
    String orderPlacedTime = "";
    String dateTimeString = orderPlacedDateTime;
    List<String> parts = dateTimeString.split(' ');
    orderPlacedDate = parts[0];
    orderPlacedTime = parts[1];
    orderPlacedDateAndTime.add(orderPlacedDate);
    orderPlacedDateAndTime.add(orderPlacedTime);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width * .88,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutralBorder),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Order ID: ${widget.item.id}",
                    style: AppTextStyles.kBody15SemiboldTextStyle,
                  ),
                  const Spacer(),
                  ConstantContainer(
                    height: 0.03,
                    width: 0.15,
                    radiusBorder: 5,
                    borderWidth: 0,
                    widget: Center(
                        child: Text(
                      widget.status,
                      style: AppTextStyles.kSmall8RegularTextStyle,
                    )),
                    borderColor: widget.colorBorder == null
                        ? AppColors.neutralBorder
                        : widget.colorBorder!,
                    color: widget.color ?? AppColors.neutralBorder,
                  ),
                  PopupMenuButton<String>(
                    // Define the items in the menu
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'option1',
                          child: Row(
                            children: [
                              Icon(Icons.call),
                              SizedBox(width: 5,),
                              Text('Call Customer'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'option2',
                          child:Row(
                            children: [
                              Icon(Icons.help_outline),
                              SizedBox(width: 5,),
                              Text('Help'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'option3',
                          child: Row(
                            children: [
                              Icon(Icons.print),
                              SizedBox(width: 5,),
                              Text('Print Bill'),
                            ],
                          ),
                        ),
                      ];
                    },
                    // Define the behavior when an item is selected
                    onSelected: (String value) {
                      // Perform the desired action based on the selected value
                      switch (value) {
                        case 'option1':
                        // Do something for Option 1
                          break;
                        case 'option2':
                        // Do something for Option 2
                          break;
                        case 'option3':
                        // Do something for Option 3
                          break;
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.item.userDetails?.fName}",
                    style: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: AppColors.primary700),
                  ),
                  Text(
                    "${orderPlacedDateAndTime[0]}  at ${orderPlacedDateAndTime[1]}",
                    style: AppTextStyles.kSmall10RegularTextStyle
                        .copyWith(color: AppColors.neutralLightFonts),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
                color: AppColors.neutralBorder,
              ),
              ListView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: widget.item.orderDetails?.length,
                  itemBuilder: (BuildContext context,int index){
                    OrderDetail? product = widget.item.orderDetails?[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(veg),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${product?.quantity} x ${product?.productName}",
                                style: AppTextStyles.kCaption12SemiboldTextStyle
                                    .copyWith(color: AppColors.neutralBodyFont),
                              ),
                              const Spacer(),
                              Text(
                                "Rs ${product?.price}",
                                style: AppTextStyles.kSmall10SemiboldTextStyle
                                    .copyWith(color: AppColors.neutralBodyFont),
                              ),
                            ],
                          ),
                        ),


                      ],
                    );

              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Bill",
                      style: AppTextStyles.kSmall10SemiboldTextStyle
                          .copyWith(color: AppColors.neutralDark),
                    ),
                    const Spacer(),
                    Text("Rs ${widget.item.totalAmount}",
                        style: AppTextStyles.kSmall10SemiboldTextStyle
                            .copyWith(color: AppColors.primary700)),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: widget.dividerColor ?? AppColors.neutralBorder,
              ),
              const SizedBox(
                height: 5,
              ),
              widget.widgets
            ],
          ),
        ),
      ),
    );
  }

  popmenu() {
    PopupMenuButton<String>(
      onSelected: (String result) {
        // Handle menu item selection
        switch (result) {
          case 'Item 1':
            // Perform action for Item 1
            break;
          case 'Item 2':
            // Perform action for Item 2
            break;
          case 'Item 3':
            // Perform action for Item 3
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Item 1',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Item 2',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Item 3',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
      ],
    );
  }
}
