import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:emart_seller/views/messages_screen/chat_screen.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

import '../widget/normal_text.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: darkGrey),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
          stream: StoreService.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("H:mma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => const ChatScreen());
                        },
                        leading: const CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: white,
                            )),
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: fontGrey),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkGrey),
                        trailing: normalText(text: time, color: darkGrey),
                      );
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
