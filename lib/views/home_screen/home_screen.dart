import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:emart_seller/views/products_screen/product_detail.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/dashboard_button.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
          stream: StoreService.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        dashboardButton(context,
                            title: orders, count: "60", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: rating, count: "60", icon: icStar),
                        dashboardButton(context,
                            title: totalSales, count: "60", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetail(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: normalText(
                                      text: "\$${data[index]['p_price']}",
                                      color: darkGrey),
                                )),
                    )
                  ]),
                ),
              );
            }
          },
        ));
  }
}
