import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropValue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropValue.value == '' ? null : dropValue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populatedSubCategory(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ),
    )
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
