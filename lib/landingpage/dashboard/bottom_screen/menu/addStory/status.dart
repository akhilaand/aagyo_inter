// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/controller/add_story_controller.dart';
import 'package:aagyo/modal/add_story_modal.dart';
import 'package:aagyo/services/core.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../view/addcategory.dart';
import 'components/select_image_widget.dart';

// Package imports:


class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final addStoryController = Get.put(AddStoryController());
  final TextEditingController captionController = TextEditingController();
  final List<File> _selectedPhotos = [];
  File? thumbnailImage;
  File? videoImage;


  Map<String, dynamic>? userDetails;

  void _clearPhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callFutureFunctions();
  }

  void callFutureFunctions() async {
    final result = await getUserDetails();
    setState(() {
      userDetails = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  ModalProgressHUD(
        inAsyncCall: addStoryController.isLoading.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Create Story",
              style: AppTextStyles.kBody17SemiboldTextStyle
                  .copyWith(color: AppColors.neutralDark),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.neutralDark,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(Deliveryboy),
                  ),
                  title: Text(
                    "${userDetails?["username"] ?? ""}",
                    style: AppTextStyles.kBody15SemiboldTextStyle,
                  ),
                  subtitle: Text(
                    "${userDetails?["address"] ?? ""}",
                    style: AppTextStyles.kSmall10RegularTextStyle,
                  ),
                ),
                ConstTextField(
                  controller: captionController,
                  height: 5,
                  title: '',
                  maxLine: 5,
                  decoration: InputDecoration(
                    hintText: "Write Caption here!",
                    hintStyle: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: AppColors.neutral50),
                    border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.neutralBorder, width: 1)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.neutralBorder, width: 1)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.neutralBorder, width: 1)),
                    filled: true,
                    fillColor: AppColors.neutralBackground,
                  ),
                ),
                Text(
                  "Maximum 100 characters",
                  style: AppTextStyles.kSmall10RegularTextStyle
                      .copyWith(color: AppColors.neutralBodyFont),
                ),
                const SizedBox(
                  height: 15,
                ),
                SelectImageWidget(
                  thumbnailCallback: (File value){
                    thumbnailImage = value;
                  },
                  videoImageCallback: (File value){
                    videoImage = value;
                  },
                ),
                Row(
                  children: [
                    for (int i = _selectedPhotos.length - 1; i > 0; i--)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(_selectedPhotos[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 25,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: const Color(0xff554f51),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: 10,
                                ),
                                onPressed: () {
                                  _clearPhoto(i);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width * .99,
                    child: InkWell(
                      onTap: () async {
                        String storeId = await getStoreId();
                        AddStoryModal addStroyData = AddStoryModal(
                          thumbnail: thumbnailImage,
                          videoImage: videoImage,
                          storeId: storeId,
                          title: captionController.text,
                          type: "image_video", storyUrl: null,
                        );
                        bool isPosted = await addStoryController.addStory(addStoryModal: addStroyData);
                        if(isPosted){
                          if(!mounted) return;
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.058,
                        width: MediaQuery.of(context).size.width * 0.38,
                        decoration: BoxDecoration(
                          color: AppColors.primary700,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.neutralBorder),
                        ),
                        child: Center(
                            child: Text(
                              "Post",
                              style: AppTextStyles.kCaption12SemiboldTextStyle
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ),
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
