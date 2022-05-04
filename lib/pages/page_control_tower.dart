import 'package:eddy_support_app/statemanagement/states.dart';
import 'package:eddy_support_app/widgets/airlinegrid.dart';
import 'package:eddy_support_app/widgets/sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ControlTower extends StatelessWidget {
  const ControlTower({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const SideMenu(currIndex: 0),
        Expanded(
          child: Scaffold(
            body: Column(children: [
              Padding(padding: const EdgeInsets.only(top: 25, bottom: 15), child: Center(child: 
                Text('Control Tower', style: Theme.of(context).textTheme.headline4))),
              Padding(padding: const EdgeInsets.only(bottom: 10), child: Center(child: SizedBox(width: 300, child:
                TextFormField(
                  controller: context.read<CPTextBoxState>().textController,
                  //onFieldSubmitted: (String value) async {context.read<CPTextBoxState>().notify();},
                  onChanged: (String value) async {context.read<CPTextBoxState>().notify();},
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixText: 'Global ',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: UnderlineInputBorder()
                  )
                )))),
              const Divider(indent: 0, endIndent: 0),
              const AirlineGrid()
            ]),
            floatingActionButton: const ExtendMenuButton(tooltip: 'Open Side Menu',),
            ),
          ),
      ],
    );
  }
}