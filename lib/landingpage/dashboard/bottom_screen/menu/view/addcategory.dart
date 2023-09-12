// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/addphotoselector.dart';
import 'package:aagyo/styles/textstyle_const.dart';

// Package imports:


class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<String> items = [];
final TextEditingController subCategoryTextController = TextEditingController();
  void addSubcategory() {
    setState(() {
      items.add('New Item'); // Add a new item to the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Add Category",
            style: AppTextStyles.kBody17SemiboldTextStyle
                .copyWith(color: AppColors.neutralDark),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.neutralDark,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PhotoSelectionWidget(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                  child: Text(
                    "Max 4 Photos",
                    style: AppTextStyles.kSmall8RegularTextStyle,
                  ),
                ),
                //commented by akhil as adding category not used
                // ConstDropDown(name: "Category Name", itemList: [],onChanged: (value){}),
                ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  SizedBox(
                        height: 220,
                        width: 500,
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const PhotoSelectionWidget(),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                              child: Text(
                                "Max 4 Photos",
                                style: AppTextStyles.kSmall8RegularTextStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ConstTextField(
                              controller: subCategoryTextController,
                              title: 'Sub Category',
                              hint: 'Add Sub Category name',
                            ),
                          ],
                        ),
                      );
                    }),
                InkWell(
                  onTap: () {
                    addSubcategory();
                  },
                  child: const Center(
                    child: ConstantContainer(
                        height: .06,
                        width: .4,
                        radiusBorder: 5,
                        borderWidth: .5,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.add,
                              color: AppColors.neutralLightFonts,
                              size: 20,
                            ),
                            Text(
                              "Add Another Varient",
                              style: AppTextStyles.kCaption12RegularTextStyle,
                            )
                          ],
                        ),
                        borderColor: AppColors.neutralBorder),
                  ),
                ),
                const SizedBox(height: 20,),
                ConstantContainer(
                    height: .06,
                    width: .9,
                    radiusBorder: 5,
                    borderWidth: .5,
                    color: AppColors.primary700,
                    borderColor: AppColors.primary700,
                    widget: Center(
                      child: Text(
                        "Next",
                        style: AppTextStyles.kCaption12SemiboldTextStyle
                            .copyWith(color: AppColors.white),
                      ),
                    ),),
              ],
            ),
          ),
        ));
  }
}

class ConstTextField extends StatefulWidget {
  final String? title;
  final String ?hint;
  final String? label;
  final int? maxLine;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final double? height;
  const ConstTextField(
      {Key? key,

      this.title,
       this.hint,
      this.decoration,
      this.maxLine,
      this.height,
      this.label,
        required this.controller,})
      : super(key: key);

  @override
  State<ConstTextField> createState() => _ConstTextFieldState();
}

class _ConstTextFieldState extends State<ConstTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: AppTextStyles.kSmall10RegularTextStyle
              .copyWith(color: AppColors.neutralBodyFont),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: TextFormField(
            controller: widget.controller,
            cursorHeight: 25,
            maxLines: widget.maxLine ?? 1,
            decoration: widget.decoration ?? InputDecoration(
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.neutralBorder,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.neutralBorder,
                      ),
                    ),
                    hintText: widget.hint,
                    labelText: widget.label,
                    // labelStyle: AppTextStyles.kSmall10RegularTextStyle,
                    hintStyle: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: AppColors.neutral50)),
          ),
        ),
        SizedBox(
          height: widget.height ?? 10,
        )
      ],
    );
  }
}
