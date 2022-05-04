import 'package:flutter/material.dart';
import '../objects/airlines.dart';
import '../widgets/sidemenu.dart';

class AirlineDetails extends StatelessWidget {
  const AirlineDetails({Key? key, required this.airline}) : super(key: key);
  final Airline airline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const SideMenu(currIndex: 0),
        Expanded(
          child: Scaffold(
            body: Column(children: [
              Padding(padding: const EdgeInsets.only(top: 50, bottom: 25), child: Center(child: 
                Text(airline.name, style: Theme.of(context).textTheme.headline4))),
            ])
          )
        )
      ]
    );
  }

}