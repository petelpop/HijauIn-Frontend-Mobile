import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_home_shimmer.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/item_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/item_warta_home.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/cubit/aqi_home/aqi_widget_cubit.dart';
import 'package:hijauin_frontend_mobile/features/main/cubit/main_page_cubit.dart';
import 'package:hijauin_frontend_mobile/utils/location_service.dart';
import 'package:hijauin_frontend_mobile/utils/shared_storage.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  String userName = "User";

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchAqiWithUserLocation();
  }

  Future<void> _loadUserData() async {
    final userData = await SharedStorage.getUserData();
    if (userData != null) {
      setState(() {
        userName = userData.namaPanggilan;
      });
    }
  }

  Future<void> _fetchAqiWithUserLocation() async {
    try {
      Position? position = await _locationService.getCurrentLocation();

      if (position != null) {
        context.read<AqiWidgetCubit>().fetchAqiData(
              position.latitude,
              position.longitude,
            );
      } else {
        Position? lastPosition = await _locationService.getLastKnownPosition();

        if (lastPosition != null) {
          context.read<AqiWidgetCubit>().fetchAqiData(
                lastPosition.latitude,
                lastPosition.longitude,
              );
        } else {
          // default location = Jakarta ( -6.194622285804888, 106.82294037022972 )
          context
              .read<AqiWidgetCubit>()
              .fetchAqiData(-6.194622285804888, 106.82294037022972);
        }
      }
    } catch (e) {
      context
          .read<AqiWidgetCubit>()
          .fetchAqiData(-6.194622285804888, 106.82294037022972);
    }
  }

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
                            text: "Hi, $userName 👋",
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
                          BlocBuilder<AqiWidgetCubit, AqiWidgetState>(
                            builder: (context, state) {
                              if (state is AqiWidgetLoading) {
                                return AqiHomeShimmer();
                              } else if (state is AqiWidgetLoaded) {
                                return AqiHomeWidget(
                                  city: state.aqiData.data.city.name,
                                  aqi: state.aqiData.data.aqi.toString(),
                                );
                              } else if (state is AqiWidgetError) {
                                return AqiHomeWidget(
                                  city: "Error",
                                  aqi: "0",
                                );
                              }
                              return AqiHomeShimmer();
                            },
                          ),
                          SizedBox(height: 20),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ItemHomeWidget(
                                    iconPath: Constants.icSortirBlack,
                                    title: "Sortir",
                                    description: "Klasifikasikan jenis sampah",
                                    onTap: () {
                                      context.read<MainPageCubit>().setPage(1);
                                    },
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: ItemHomeWidget(
                                    iconPath: Constants.icMapinBlack,
                                    title: "MapIn",
                                    description: "Cari tempat sampah",
                                    onTap: () {
                                      context.read<MainPageCubit>().setPage(2);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<MainPageCubit>().setPage(3);
                        },
                        child: Image.asset(Constants.imgBgChatbotBanner),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
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
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          PrimaryText(
                            text: "Warta",
                            color: colorTextDarkSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 1.33,
                          )
                        ],
                      ),
                      PrimaryText(
                        text: "Lihat Semua",
                        color: colorTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.43,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
