import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/views/askflo_page.dart';
import 'package:hijauin_frontend_mobile/features/home/presentation/views/home_page.dart';
import 'package:hijauin_frontend_mobile/features/main/cubit/main_page_cubit.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/components/navigation_bar.dart';
import 'package:hijauin_frontend_mobile/features/main/presentation/components/navigation_bar_item.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/views/mapin_page.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/views/sortir_page.dart';
import 'package:hijauin_frontend_mobile/features/warta/presentation/views/warta_page.dart';

class MainPage extends StatefulWidget {
  static const String routeName = 'main-page';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> listPage(int page) => [
        HomePage(),
        SortirPage(),
        MapinPage(),
        AskfloPage(),
        WartaPage()
      ];

  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().setPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        if (state is SetPage) {
          return Scaffold(
            extendBody: true,
            body: Stack(
              children: [
                IndexedStack(
                  index: state.index,
                  children: listPage(state.index),
                )
              ],
            ),
            bottomNavigationBar: BottomNavBar(
                items: [
                  BottomNavBarItem(
                      index: 0,
                      isSelected: state.index == 0,
                      title: "Home",
                      imageSelected: Constants.icHomeActive,
                      imageUnselect: Constants.icHomeInactive),
                  BottomNavBarItem(
                      index: 1,
                      isSelected: state.index == 1,
                      title: "Sortir",
                      imageSelected: Constants.icSortirActive,
                      imageUnselect: Constants.icSortirInactive),
                  BottomNavBarItem(
                      index: 2,
                      isSelected: state.index == 2,
                      title: "MapIn",
                      imageSelected: Constants.icMapinActive,
                      imageUnselect: Constants.icMapinInactive),
                  BottomNavBarItem(
                      index: 3,
                      isSelected: state.index == 3,
                      title: "Askflo",
                      imageSelected: Constants.icAskfloActive,
                      imageUnselect: Constants.icAskfloInactive),
                  BottomNavBarItem(
                      index: 4,
                      isSelected: state.index == 4,
                      title: "Warta",
                      imageSelected: Constants.icWartaActive,
                      imageUnselect: Constants.icWartaInactive),
                ],
                onTap: (int page) =>
                    context.read<MainPageCubit>().setPage(page),
                selectedIndex: state.index),
          );
        }
        return Container();
      },
    );
  }
}
