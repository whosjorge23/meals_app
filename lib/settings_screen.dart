import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";
  final Function? saveFilters;
  final Map<String, bool>? currentFilters;
  const SettingsScreen({
    Key? key,
    Map<String, bool>? this.currentFilters,
    Function? this.saveFilters,
    Map<String, bool>? filters,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  initBuild() {
    _glutenFree = widget.currentFilters!['gluten']!;
    _lactoseFree = widget.currentFilters!['lactose']!;
    _vegan = widget.currentFilters!['vegan']!;
    _vegetarian = widget.currentFilters!['vegetarian']!;
  }

  @override
  Widget build(BuildContext context) {
    initBuild();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adjust your meal selection",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters!(selectedFilter);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile.adaptive(
                activeColor: Colors.amber,
                title: const Text("Gluten-Free"),
                subtitle: const Text("Only include gluten-free meals."),
                value: _glutenFree,
                onChanged: (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                activeColor: Colors.amber,
                title: const Text("Lactose-Free"),
                subtitle: const Text("Only include lactose-free meals."),
                value: _lactoseFree,
                onChanged: (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                activeColor: Colors.amber,
                title: const Text("Vegan"),
                subtitle: const Text("Only include vegan meals."),
                value: _vegan,
                onChanged: (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                activeColor: Colors.amber,
                title: const Text("Vegetarian"),
                subtitle: const Text("Only include vegetarian meals."),
                value: _vegetarian,
                onChanged: (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
            ],
          )),
          TextButton.icon(
              onPressed: () {
                final selectedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters!(selectedFilter);
              },
              icon: Icon(Icons.save),
              label: Text("Save"))
        ],
      ),
    );
  }
}
