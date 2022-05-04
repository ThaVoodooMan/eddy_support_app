import 'package:eddy_support_app/statemanagement/states.dart';
import 'package:eddy_support_app/widgets/sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Issues extends StatelessWidget{
  const Issues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const SideMenu(currIndex: 2),
        Expanded(
          child: Scaffold(
            appBar: AppBar(),
            body: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 3 / 1,
              children: [
                const Text(
                  '',
                ),
                Center(child: Text(
                  'Issues!',
                  style: Theme.of(context).textTheme.headline4,
                )),
                const Text(
                  '',
                ),
                const Text(
                  '',
                ),
                Center(child: ElevatedButton( 
                  onPressed: () {Provider.of<SideMenuStateManager>(context, listen: false).swapTransitionStates();},
                  child: Text(Provider.of<SideMenuStateManager>(context, listen: true).transitionAnimation ? 'Menu Animations: ON':'Menu Animations: OFF'),
                )),
                const Text(
                  '',
                ),
                const Text(
                  '',
                ),
                Center(child: ElevatedButton( 
                  onPressed: () {GoRouter.of(context).pop();},
                  child: const Text('Go Back'),
                )),
              ],
            ),
            floatingActionButton: const ExtendMenuButton(tooltip: 'Open Side Menu',),
          ),
        ),
      ],
    );
  }
}