// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/styles/textstyle_const.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title:  SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 58,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                fillColor: const Color.fromRGBO(203, 212, 225, 1),
                hintText: 'Search for items in shops',
                hintStyle: const TextStyle(fontSize: 12),
                suffixIcon: IconButton(onPressed: (){
                },  icon: const Icon(
                  Icons.tune,
                  size: 20,
                  color: AppColors.primary700,
                )),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: AppColors.primary700,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary700,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary700,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.white30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: 50,
        // color: Colors.red,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(width: 10,),
            SizedBox(
              height: 45,
              width: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.tune,
                    color: AppColors.primary700,
                    size: 20,
                  )),
            ),
            CategoryButtons(
              onpressed: () {},
              text: 'Pure Veg',
            ),
            CategoryButtons(
              onpressed: () {},
              text: 'Non Veg',
            ),

            CategoryButtons(
              onpressed: () {},
              text: 'Distance',
            ),

            CategoryButtons(
              onpressed: () {},
              text: 'New Arrivals',
            ),

          ],
        ),
      ),
    );
  }
}

class CategoryButtons extends StatefulWidget {
  final VoidCallback onpressed;
  final String text;
  const CategoryButtons(
      {super.key, required this.onpressed, required this.text});

  @override
  State<CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  bool _ispressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: 45,
        width: 130,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                _ispressed ? AppColors.primary600 : AppColors.white),
            onPressed: () {
              setState(() {
                _ispressed = !_ispressed;
              });
            },
            child: _ispressed
                ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                    style: AppTextStyles.kSmall10RegularTextStyle
                        .copyWith(color: Colors.black, fontSize: 13),
                  ),
                  const Icon(
                    Icons.close,
                    color: AppColors.primary700,
                  )
                ],
              ),
            )
                : Center(
              child: Text(
                widget.text,
                style: const TextStyle(color: Colors.black),
              ),
            )),
      ),
    );
  }
}
