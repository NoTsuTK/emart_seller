import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/normal_text.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: normalText(text: title, size: 16.0),
  );
}
