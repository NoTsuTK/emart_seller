import 'package:emart_seller/const/const.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .roundedSM
      .size(70, 70)
      .make();
}
