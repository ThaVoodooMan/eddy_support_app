import 'package:flutter/material.dart';
import '../objects/airlines.dart';
import '../widgets/sidemenu.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const SideMenu(currIndex: 0),
        Expanded(
          child: Scaffold(
            body: Column(children: [
              Padding(padding: const EdgeInsets.only(top: 50, bottom: 25), child: Center(child: 
                Text(service.name, style: Theme.of(context).textTheme.headline4))),
            ])
          )
        )
      ]
    );
  }

}