import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../interfaces/route-rules-interface.dart';
import '../widgets/main_drawer.dart';

class FiltersScreenWidget extends StatefulWidget
    implements RouteRulesInterface {
  Function setFilters;
  Map<String, bool> currentFilters;

  FiltersScreenWidget();

  FiltersScreenWidget.withFilters({this.currentFilters, this.setFilters});

  @override
  String get routeName => '/filters';

  @override
  _FiltersScreenWidgetState createState() => _FiltersScreenWidgetState();
}

class _FiltersScreenWidgetState extends State<FiltersScreenWidget> {
  var _glutenFree = false;
  var _vegeterian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegeterian = widget.currentFilters['vegeterian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];

    super.initState();
  }

  Widget _buildSwitchTile(
    String title,
    String subTitle,
    bool currentValue,
    Function valueUpdater,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: valueUpdater,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCtx = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your FIlters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> _selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegeterian': _vegeterian,
              };

              widget.setFilters(_selectedFilters);

              // new logic
              Toast.show(
                "FILTERs have been SAVED.",
                context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.CENTER,
                textColor: themeCtx.accentColor,
                backgroundColor: Colors.black54,
                border: Border.all(
                  color: themeCtx.primaryColorDark,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              );
            },
          ),
        ],
      ),
      drawer: MainDrawerWidget(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Update your meal selections here',
              style: themeCtx.textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Gluten-free',
                  'Only bring gluten free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose-free',
                  'Only bring lactose free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegeterian',
                  'Only bring veggie meals.',
                  _vegeterian,
                  (newValue) {
                    setState(() {
                      _vegeterian = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan only',
                  'Only bring vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
