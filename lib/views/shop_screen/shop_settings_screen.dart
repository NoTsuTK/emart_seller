import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widget/custom_textfield.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: ShopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopName: controller.shopNameController.text,
                        shopAddress: controller.shopAddressController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopWebsite: controller.shopWebsiteController.text,
                        shopDesc: controller.shopDescController.text,
                      );
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                label: shopname,
                hint: nameHint,
                controller: controller.shopNameController,
              ),
              10.heightBox,
              customTextField(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAddressController,
              ),
              10.heightBox,
              customTextField(
                label: mobile,
                hint: shopMobileHint,
                controller: controller.shopMobileController,
              ),
              10.heightBox,
              customTextField(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController,
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                label: description,
                hint: shopDescHint,
                controller: controller.shopDescController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
