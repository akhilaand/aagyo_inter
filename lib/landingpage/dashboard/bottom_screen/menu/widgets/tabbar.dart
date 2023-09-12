// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:aagyo/modal/list_product_response_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/controller/list_category_controller.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/addproduct.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/edit_products.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/filter_page.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/widgets/switch.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../controller/list_product_controller.dart';
import '../../../../../modal/list_category_response_modal.dart'
    as categoryAlias;
import '../../../../../utils/common_components.dart';

final productController = Get.put(ListProductController());
final categoryController = Get.put(ListCategoryController());


class MenuTabbar extends StatefulWidget {
  const MenuTabbar({Key? key}) : super(key: key);

  @override
  State<MenuTabbar> createState() => _MenuTabbarState();
}

class _MenuTabbarState extends State<MenuTabbar> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 58,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value){
                    if(_currentPage==0){
                      productController.searchProducts(comparerValue: value.toLowerCase());
                    }else{
                      categoryController.searchCategories(comparerValue: value.toLowerCase());
                    }
                  },
                  controller: _searchController,

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    fillColor: const Color.fromRGBO(203, 212, 225, 1),
                    hintText: 'Search for items in shops',
                    hintStyle: const TextStyle(fontSize: 12),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FilterPage()));
                        },
                        icon: const Icon(
                          Icons.tune,
                          size: 20,
                          color: AppColors.primary700,
                        )),
                    prefixIcon: InkWell(
                      onTap: (){

                      },
                      child: const Icon(
                        Icons.search,
                        size: 20,
                        color: AppColors.primary700,
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: _currentPage == 0
                            ? AppColors.white40
                            : AppColors.white20),
                    child: Text(
                      'Products',
                      style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                          color: _currentPage == 0
                              ? AppColors.white80
                              : AppColors.white50),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      _currentPage = 1;
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: _currentPage == 1
                            ? AppColors.white40
                            : AppColors.white20,
                      ),
                      child: Text('Categories',
                          style: AppTextStyles.kBody15SemiboldTextStyle
                              .copyWith(
                                  color: _currentPage == 1
                                      ? AppColors.white80
                                      : AppColors.white50))),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  Products(),
                  Categories(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Product

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool status = false;

  @override
  void initState() {
    super.initState();

    productController.getProductViewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddProduct()));
          },
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 152,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary700),
            child: const Text(
              "+ Add Product",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Obx(() {
          final productList = productController.productViewList;
          if (productController.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (productList.isEmpty) {
              return noItemWidget();
            } else {
              return ListView.builder(
                  itemCount: productList.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    ProductDatum product = productList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        // height: MediaQuery.of(context).size.height * .142,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: AppColors.neutralBorder,
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //TODO:IMAGE COMMENTED
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    product.imageUrl.toString(),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    height:
                                        MediaQuery.of(context).size.width * .2),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .58,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(product.name ?? '',
                                                style: AppTextStyles
                                                    .kCaption12SemiboldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutralDark)),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(product.category?.name ?? '',
                                                style: AppTextStyles
                                                    .kSmall10RegularTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutralBodyFont)),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProduct(
                                                          categoryName: (product
                                                                  .category
                                                                  ?.name)
                                                              .toString(),
                                                          subCategoryName:
                                                              (product.subCategory
                                                                      ?.name)
                                                                  .toString(),
                                                          variantDetails: product
                                                              .variantDetails
                                                              .toString(),
                                                          startTime: product
                                                              .startTime
                                                              .toString(),
                                                          endTime: product
                                                              .endTime
                                                              .toString(),
                                                          productId: product.id
                                                              .toString(),
                                                          moduleId: product
                                                              .moduleId
                                                              .toString(),
                                                          productName: product
                                                              .name
                                                              .toString(),
                                                        )));
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        HeadingSub(
                                          key: UniqueKey(),
                                          Heading1: getPriceRange(product),
                                          // Price: getPriceRange(product),
                                          SubHeading: 'Price Range',
                                        ),
                                        HeadingSub(
                                          key: UniqueKey(),
                                          Heading1: getVariety(product),
                                          SubHeading: 'variety',
                                        ),
                                        HeadingSub(
                                          key: UniqueKey(),
                                          Heading1: product.stock ?? '0',
                                          SubHeading: 'Quantity',
                                        ),
                                        SwitchScreen(
                                            onTap: () {},
                                            isSwitched: product.status == "1"
                                                ? true
                                                : false,
                                            productUniqueId:
                                                product.id.toString()),
                                      ],
                                    ),
                                    int.parse(product.stock.toString()) < 5
                                        ? Text(
                                            "300 gm low inventry",
                                            style: AppTextStyles
                                                .kBody15RegularTextStyle
                                                .copyWith(
                                                    color: AppColors.error60),
                                          )
                                        : Container()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        }));
  }

  String getVariety(ProductDatum product) {
    List<dynamic> productList = jsonDecode(product.variantDetails.toString());
    return productList.length.toString();
  }

  String getPriceRange(ProductDatum product) {
    List<dynamic> productList = jsonDecode(product.variantDetails.toString());
    if (productList.isNotEmpty) {
      List<int> prices =
          productList.map((product) => int.parse(product['price'])).toList();

      // Find the minimum and maximum prices
      int minimumPrice = prices.reduce((a, b) => a < b ? a : b).abs();
      int maximumPrice = prices.reduce((a, b) => a > b ? a : b).abs();
      String? priceRange =
          "${minimumPrice.toString()} - ${maximumPrice.toString()}";
      return priceRange;
    }
    return "";
  }
}

class HeadingSub extends StatelessWidget {
  final String Heading1;
  final String SubHeading;
  final String? Price;

  const HeadingSub({
    Key? key,
    required this.Heading1,
    required this.SubHeading,
    this.Price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(Heading1, style: AppTextStyles.kCaption12SemiboldTextStyle),
        const SizedBox(
          height: 3,
        ),
        Text(SubHeading,
            style: AppTextStyles.kSmall10RegularTextStyle
                .copyWith(color: AppColors.neutralBodyFont)),
      ],
    );
  }
}

//Category

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool status = false;

  List<String> name = [
    "Rajma Chawal",
    "Amul Milk",
    "Desi Chawal",
    "Amul Chawal",
    "Amul Chawal",
  ];
  List<String> img = [
    grocery,
    grocery1,
    grocery2,
    mother,
    grocery1,
  ];
  @override
  void initState() {
    super.initState();
    categoryController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: InkWell(
        //   onTap: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => AddCategory()));
        //   },
        //   child: Container(
        //     alignment: Alignment.center,
        //     height: 45,
        //     width: 152,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: AppColors.primary700),
        //     child: Text(
        //       "+ Add Category",
        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        body: Obx(() {
      final categoryList = categoryController.categoryList;
      if (categoryController.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if(categoryController.categoryList.isEmpty){
          return noItemWidget();

        }else{
          return ListView.builder(
              itemCount: categoryList.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                categoryAlias.Datum category = categoryList[index];

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * .142,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.neutralBorder,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              category.imageUrl.toString(),
                              height: 70,
                              width: 70,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .63,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(category.name ?? "",
                                        style: AppTextStyles
                                            .kBody15SemiboldTextStyle
                                            .copyWith(
                                            color: AppColors.neutralDark)),
                                    //TODO:WHAT SHOULD BE THE BELOW VALUE
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        getSubCategory(category),
                                        style: AppTextStyles
                                            .kCaption12RegularTextStyle
                                            .copyWith(
                                            color: AppColors.neutralBodyFont),
                                      ),
                                    ),
                                  ],
                                ),
                                // SwitchScreen()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }

      }
    }));
  }

  String getSubCategory(categoryAlias.Datum product) {
    List<categoryAlias.SubCategory>? subCategories = product.subCategory;
    String? concatenatedNames;
    if (subCategories != null) {
      List<String> subCategoryNames = subCategories.map((subCategory) {
        return subCategory.name!;
      }).toList();
      concatenatedNames = subCategoryNames.join(', ');
    }

    return concatenatedNames ?? '';
  }
}
