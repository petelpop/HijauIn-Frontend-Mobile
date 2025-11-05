import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/item_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/item_warta_home.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "home-page";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Constants.imgBgAuth))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(48),
                            bottomRight: Radius.circular(48))),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 70,
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                      )
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Constants.imgBgHome),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PrimaryText(
                            text: "Hi, Hani 👋",
                            fontWeight: FontWeight.w600,
                            color: colorTextDarkPrimary,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          PrimaryText(
                            text:
                                "Langkah kecilmu bisa berarti besar untuk bumi.",
                            color: colorTextDarkSecondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          SizedBox(height: 32),
                          AqiHomeWidget(),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(flex: 1, child: ItemHomeWidget()),
                              SizedBox(width: 20),
                              Expanded(flex: 1, child: ItemHomeWidget())
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        Constants.imgBgChatbotBanner
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            text: "Artikel Untukmu",
                            color: colorTextDarkPrimary,
                            fontSize: 14,
                            lineHeight: 1.43,
                            fontWeight: FontWeight.w600,),
                          SizedBox(height: 2,),
                          PrimaryText(
                            text: "Warta",
                            color: colorTextDarkSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 1.33,)
                        ],
                      ),

                      PrimaryText(
                        text: "Lihat Semua",
                        color: colorTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.43,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8), 
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ItemWartaHome();
                    }),
                ),
              ],
            ),
          ),
        ));
  }
}
