import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup_login_demo/tabsPage/newsPage.dart';
import 'package:signup_login_demo/tabsPage/dashboardPage.dart';
import 'package:signup_login_demo/tabsPage/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2,
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.dashboard,
                      color: Colors.blue,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.pending_actions,
                      color: Colors.blue,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    )),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [DashboardPage(), NewsPage(), ProfilePage()],
          ),
        ),
      ),
    );
  }
}
