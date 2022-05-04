import 'package:eddy_support_app/statemanagement/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// ignore: constant_identifier_names
enum MenuItems {Control_Tower, Logs, Issues}

class SideMenuButton extends NavigationRailDestination{
  SideMenuButton({required Widget icon, required Widget label}) : super(icon: icon, label: label);
  
}

class SideMenu extends StatelessWidget{
  const SideMenu({Key? key, required this.currIndex}) : super(key: key);
  final int currIndex;

  @override
  Widget build(BuildContext context) {
    return 
    NavigationRail(
      destinations: const <NavigationRailDestination>[        
        NavigationRailDestination(
          icon: Icon(Icons.cell_tower_sharp),
          selectedIcon: Icon(Icons.cell_tower_sharp),
          label: Text('Control Tower'),
        ),
        /* NavigationRailDestination(
          icon: Icon(Icons.insert_chart_outlined_sharp),
          selectedIcon: Icon(Icons.insert_chart_outlined_sharp),
          label: Text('Details'),
        ), */
        NavigationRailDestination(
          icon: Icon(Icons.insert_chart_outlined_sharp),
          selectedIcon: Icon(Icons.insert_chart_outlined_sharp),
          label: Text('Logs'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.report_problem_sharp),
          selectedIcon: Icon(Icons.report_problem_sharp),
          label: Text('Issues'),
        ),
      ],
      selectedIndex: currIndex,
      onDestinationSelected: (int index) => {context.goNamed(MenuItems.values[index].name.replaceAll('_', ' '))},
      extended: context.watch<ExtendMenuStateManager>().isRailOpen,
      minWidth: 50,
      labelType: NavigationRailLabelType.none,
      useIndicator: false,
      minExtendedWidth: 198,
    );
  }
}

class ExtendMenuButton extends StatelessWidget{
  const ExtendMenuButton({Key? key, this.tooltip}) : super(key: key);
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<ExtendMenuStateManager>().swapRailExtent(),
      tooltip: tooltip,
      child: const Icon(Icons.add),
    );
  }
}