import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: textfieldGrey,
                      title:
                          boldText(text: "Product title", color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text: intl.DateFormat()
                                      .add_yMd()
                                      .format(DateTime.now()),
                                  color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(text: "\$40.00", color: fontGrey),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make()),
          ),
        ),
      ),
    );
  }
}
