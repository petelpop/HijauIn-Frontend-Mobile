import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_home_shimmer.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/aqi_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/item_home_widget.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/components/logout_confirmation_modal.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/cubit/aqi_home/aqi_widget_cubit.dart';
import 'package:hijauin_frontend_mobile/features/main/cubit/main_page_cubit.dart';
import 'package:hijauin_frontend_mobile/features/warta/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/components/item_warta.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/cubit/warta_list/warta_list_cubit.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/views/warta_page.dart';
import 'package:hijauin_frontend_mobile/utils/location_service.dart';
import 'package:hijauin_frontend_mobile/utils/shared_storage.dart';
import 'package:hijauin_frontend_mobile/utils/shimmer_card.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  String userName = "User";
  bool _showLogoutButton = false;

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
          // default location = FSM Undip ( -7.048506770073256, 110.44122458341415 )
          context
              .read<AqiWidgetCubit>()
              .fetchAqiData(-7.048506770073256, 110.44122458341415);
        }
      }
    } catch (e) {
      context
          .read<AqiWidgetCubit>()
          .fetchAqiData(-7.048506770073256, 110.44122458341415);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WartaListCubit(WartaServices())..fetchArticles(page: 1, limit: 4),
      child: Scaffold(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showLogoutButton =
                                              !_showLogoutButton;
                                        });
                                      },
                                      child: ClipOval(
                                        child: Image.asset(
                                          Constants.imgUserPlaceholder,
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PrimaryText(
                                            text: "Hi, $userName 👋",
                                            fontWeight: FontWeight.w600,
                                            color: colorTextDarkPrimary,
                                            fontSize: 18,
                                          ),
                                          SizedBox(height: 4),
                                          PrimaryText(
                                            text:
                                                "Langkah kecilmu bisa berarti besar untuk bumi.",
                                            color: colorTextDarkSecondary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (_showLogoutButton)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showLogoutButton = false;
                                        });
                                        showLogoutConfirmationModal(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x14000000),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              Constants.icLogout,
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(width: 8),
                                            PrimaryText(
                                              text: "Logout",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: colorTextDarkPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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
                                      description:
                                          "Klasifikasikan jenis sampah",
                                      onTap: () {
                                        context
                                            .read<MainPageCubit>()
                                            .setPage(1);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: ItemHomeWidget(
                                      iconPath: Constants.icWartaBlack,
                                      title: "Warta",
                                      description:
                                          "Baca berita terkini dari dunia lingkungan",
                                      onTap: () {
                                        context.pushNamed(WartaPage.routeName);
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
                        GestureDetector(
                          onTap: () {
                            context.read<MainPageCubit>().setPage(4);
                          },
                          child: PrimaryText(
                            text: "Lihat Semua",
                            color: colorTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            lineHeight: 1.43,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: BlocBuilder<WartaListCubit, WartaListState>(
                      builder: (context, state) {
                        if (state is WartaListLoading) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return ShimmerCard(
                                width: 187,
                                height: 250,
                                radius: 12,
                              );
                            },
                          );
                        }

                        if (state is WartaListLoaded) {
                          final articles = state.articles.take(4).toList();

                          if (articles.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: PrimaryText(
                                  text: 'Belum ada artikel',
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return ItemWartaHome(article: articles[index]);
                            },
                          );
                        }

                        if (state is WartaListError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                  SizedBox(height: 12),
                                  PrimaryText(
                                    text: 'Gagal memuat artikel',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111827),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<WartaListCubit>()
                                          .fetchArticles(page: 1, limit: 4);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2D746A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: PrimaryText(
                                      text: 'Coba Lagi',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
