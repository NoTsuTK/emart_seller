import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: appbarWidget(products),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      onTap: () {},
                      leading: Image.asset(imgProduct,
                          width: 100, height: 100, fit: BoxFit.cover),
                      title: boldText(text: "Product title", color: fontGrey),
                      subtitle: normalText(text: "\$40.0", color: darkGrey),
                    )),
          ),
        ),
      ),
    );
  }
}
