import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_cubit.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_state.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    context.read<ChatCubitCubit>().toggleTab(_tabController, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.watch<ChatCubitCubit>(),
      child: BlocBuilder<ChatCubitCubit, ChatCubitState>(
        builder: (context, state) {
          return DefaultTabController(
            length: state.tabController!.length,
            child: Scaffold(
              floatingActionButton: _floatingButtonType(state),
              appBar: _appBar(state),
              body: SafeArea(
                child: TabBarView(
                  controller: state.tabController!,
                  children: tabPage.map((e) => e).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _floatingButtonType(ChatCubitState state) {
    switch (state.tabController!.index) {
      case 0:
        return _floatingButton(
          icon: Icons.message,
          callback: () => Navigator.pushNamed(
            context,
            RouteConstant.contactListScreen,
          ),
        );
      case 1:
        return _floatingButton(
          icon: Icons.edit,
          callback: () => Navigator.pushNamed(
            context,
            RouteConstant.addStatusScreen,
          ),
        );
      case 2:
        return _floatingButton(
          icon: Icons.call,
          callback: () =>
              Navigator.pushNamed(context, RouteConstant.selectContactToCall),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  FloatingActionButton _floatingButton({
    required IconData icon,
    required VoidCallback callback,
  }) {
    return FloatingActionButton(
      backgroundColor: messageColor,
      onPressed: callback,
      child: Icon(
        icon,
        color: textColor,
      ),
    );
  }

  AppBar _appBar(ChatCubitState state) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: false,
      elevation: 0,
      title: const Text(
        "WhatsApp",
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        _searchButton(icon: Icons.search),
        _popUpMenu(),
      ],
      bottom: TabBar(
        indicatorColor: tabColor,
        indicatorWeight: 4,
        labelColor: tabColor,
        controller: state.tabController,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: tabs.map((e) => _tabs(e)).toList(),
      ),
    );
  }

  PopupMenuButton<String> _popUpMenu() {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
      color: appBarColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onSelected: _onMenuTapRoute,
      itemBuilder: (context) => menuItems
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  _onMenuTapRoute(String value) {
    switch (value) {
      case 'New group':
        return Navigator.pushNamed(context, RouteConstant.newGroup);
      case 'New broadcast':
        return Navigator.pushNamed(context, RouteConstant.newBroadcast);
      case 'Starred messages':
        return Navigator.pushNamed(context, RouteConstant.starredMessage);
      case 'Payments':
        return Navigator.pushNamed(context, RouteConstant.payments);
      case 'Settings':
        return Navigator.pushNamed(context, RouteConstant.settings);
    }
  }

  Tab _tabs(String text) {
    return Tab(
      text: text,
    );
  }

  Widget _searchButton({required IconData icon, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey),
      onPressed: onPressed,
    );
  }
}
