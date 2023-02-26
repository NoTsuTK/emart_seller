import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/normal_text.dart';
import 'package:emart_seller/views/widget/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            30.heightBox,
            normalText(text: welcome, size: 18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .border(color: white)
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
                10.widthBox,
                boldText(text: appname, size: 18.0)
              ],
            ),
            40.heightBox,
            normalText(text: loginTo, size: 18.0, color: lightGrey),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint),
                  ),
                  10.heightBox,
                  TextFormField(
                    obscureText: true,
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint),
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: normalText(
                            text: forgotPassword, color: purpleColor)),
                  ),
                  30.heightBox,
                  SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isLoading.value
                          ? loadingIndicator()
                          : ourButton(
                              title: login,
                              onPress: () async {
                                controller.isLoading(true);

                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: "logged in");
                                    Get.offAll(() => const Home());
                                    controller.isLoading(false);
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              }))
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowMd
                  .padding(const EdgeInsets.all(8))
                  .make(),
            ),
            10.heightBox,
            Center(child: normalText(text: anyProblem, color: lightGrey)),
            const Spacer(),
            Center(child: boldText(text: credit)),
            20.heightBox
          ]),
        ),
      ),
    );
  }
}
