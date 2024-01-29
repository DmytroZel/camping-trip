import 'package:camp_trip/common/base/base_dialog.dart';
import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/feature/main/widet/trip_item.dart';
import 'package:camp_trip/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../routers/screen_names.dart';
import 'main_vm.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
  final pageController = PageController();

  @override
  void initState() {
    _subForGoInitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainVm>(context);
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            hasResizerToggle: false,
            hasResizer: false,
            mode: SideMenuMode.open,
            builder: (data) => SideMenuData(
              header: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    vm.userModel?.userName ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    vm.userModel?.email ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              items: [
                SideMenuItemDataDivider(divider: const Divider()),
                SideMenuItemDataTile(
                  //gradient background
                  highlightSelectedColor: ColorName.greyInput,
                  isSelected: vm.selectedPageIndex == 0,
                  onTap: () {
                    pageController.jumpToPage(0);
                  },
                  title: 'Мої походи',
                  icon: const Icon(Icons.backpack_outlined),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                SideMenuItemDataTile(
                  onTap: () {
                    pageController.jumpToPage(1);
                  },
                  title: 'Моє спорядження',
                  icon: const Icon(Icons.backpack_outlined),
                  isSelected: vm.selectedPageIndex == 1,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                SideMenuItemDataTile(
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                  title: 'Мої страви',
                  icon: const Icon(Icons.backpack_outlined),
                  isSelected: vm.selectedPageIndex == 2,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                SideMenuItemDataDivider(divider: const Divider()),
                SideMenuItemDataTile(
                  onTap: () {
                    showLogoutDialog();
                  },
                  title: 'Вихід',
                  titleStyle: const TextStyle(color: Colors.red),
                  icon: const Icon(Icons.logout),
                  isSelected: vm.selectedPageIndex == 2,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: vm.onSelectedPage,
              children: [
                tripsList(),
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return tripsList();
  }

  _subForGoInitial() {
    final vm = Provider.of<MainVm>(context, listen: false);
    vm.goToInitial.stream.listen((event) {
      _goToSplash();
    }).toBag(bag);
  }

  _goToSplash() {
    context.replace(ScreenNames.initial);
  }

  Widget tripsList() {
    final vm = Provider.of<MainVm>(context);
    return Scaffold(
      body: GridView.extent(
        maxCrossAxisExtent: 300,
        children: vm.trips
            .map((e) => TripItem(
                  tripModel: e,
                  isOwner: e.organizer == vm.userModel?.id,
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(ScreenNames.createTrip);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showLogoutDialog() {
    final vm = Provider.of<MainVm>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => BaseDialog(
          description: '',
          title: 'Ви бажаєте вийти?',
          positiveText: 'Так',
          negativeText: 'Ні',
          onPositiveTap: () {
            vm.onLogoutTap();
            Navigator.pop(context);
          },
          onNegativeTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
