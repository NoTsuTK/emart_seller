import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widget/custom_textfield.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';

import '../widget/normal_text.dart';

class EditProfilescreen extends StatefulWidget {
  final String? username;
  const EditProfilescreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imgUrl'];
                      }

                      if (controller.snapshotData['password'] ==
                          controller.oldpasswordController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpasswordController.text,
                            newpassword: controller.newpasswordController.text);

                        await controller.updateProfile(
                            imageUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newpasswordController.text);
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpasswordController.text.isEmptyOrNull &&
                          controller.newpasswordController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imageUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Some error occured");
                        controller.isLoading(false);
                      }
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              controller.snapshotData['imgUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  : controller.snapshotData['imgUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imgUrl'],
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              // Image.asset(imgProduct, width: 150)
              //     .box
              //     .roundedFull
              //     .clip(Clip.antiAlias)
              //     .make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(color: white),
              customTextField(
                  label: name,
                  hint: "eg. Baaba Devs",
                  controller: controller.nameController),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Changed your pasword")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpasswordController),
              10.heightBox,
              customTextField(
                  label: confirmPass,
                  hint: passwordHint,
                  controller: controller.newpasswordController),
            ],
          ),
        ),
      ),
    );
  }
}
