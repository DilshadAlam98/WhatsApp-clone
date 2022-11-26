import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_cubit.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_state.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

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
    context.read<ChatCubitCubit>().toggleTab(
          _tabController,
          () {},
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubitCubit, ChatCubitState>(
      listener: (context, state) => true,
      builder: (context, state) {
        return DefaultTabController(
          length: state.tabController!.length,
          child: Scaffold(
            floatingActionButton: _floatingButton(state),
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
    );
  }

  FloatingActionButton _floatingButton(ChatCubitState state) {
    if (state.tabController!.index == 1) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      );
    }
    if (state.tabController!.index == 1) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.call),
      );
    }
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.chat),
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
            fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      actions: [
        _actionIconButton(icon: Icons.search),
        _actionIconButton(icon: Icons.more_vert),
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

  Tab _tabs(String text) {
    return Tab(
      text: text,
    );
  }

  Widget _actionIconButton({required IconData icon, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey),
      onPressed: onPressed,
    );
  }
}
