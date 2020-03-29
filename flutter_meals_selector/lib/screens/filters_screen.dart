import 'package:flutter/material.dart';

import '../interfaces/route-rules-interface.dart';
import '../widgets/main_drawer.dart';

class FiltersScreenWidget extends StatelessWidget
    implements RouteRulesInterface {
  const FiltersScreenWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your FIlters'),
      ),
      drawer: MainDrawerWidget(),
      body: Center(
        child: Text('filters filters!!!!'),
      ),
    );
  }

  @override
  String get routeName => '/filters';
}
