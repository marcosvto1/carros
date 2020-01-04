import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_page.dart';

import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.index = await Prefs.getInt('tabIdx');

    _tabController.addListener(() {
      print("Tab controller ${_tabController.index}");

      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carros'),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            text: 'Clássicos',
          ),
          Tab(
            text: 'Esportivos',
          ),
          Tab(text: 'Luxos')
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo)
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
