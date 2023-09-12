// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/controller/list_product_controller.dart';
import '../../../../../colors/colors_const.dart';

class ConstVarity extends StatefulWidget {
  final TextEditingController controler;
  final String hint;
  final String label;
  final bool isTextEnabled;
  final Function(String)? onChanged;
  final bool isAdditionalValidationRequired;
  final bool needValidation;
  const ConstVarity(
      {Key? key,
      required this.hint,
      required this.label,
      required this.controler,
      this.isTextEnabled = true,
        this.needValidation = true,
        this.isAdditionalValidationRequired = false,
      this.onChanged})
      : super(key: key);

  @override
  State<ConstVarity> createState() => _ConstVarityState();
}

class _ConstVarityState extends State<ConstVarity> {
  final productController = Get.put(ListProductController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * .4,
      child: TextFormField(

        enabled: widget.isTextEnabled,
        controller: widget.controler,
        keyboardType: const TextInputType.numberWithOptions(),
        validator: (value){

          if(value!=null&&value.isEmpty&&widget.needValidation){
            return '';
          }
          if(widget.isAdditionalValidationRequired){
            if(productController.salePrice.value>productController.mrp.value){
              Get.snackbar(
                "Warning",
                "Sale Price Can't be greater than MRP",
                colorText: Colors.white,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.warning_amber,color: Colors.white,),
              );
              return "";
            }
          }

          return null;
        },
        onChanged: widget.onChanged,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5,left: 10),
          errorStyle: const TextStyle(fontSize: 0.01),

          hintText: widget.hint,
          labelText: widget.label,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutralBorder, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutralBorder, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutralBorder, width: 1)),
          errorBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.red, width: 0.0),
          ),
        ),
      ),
    );
  }
}
