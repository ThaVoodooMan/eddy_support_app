import 'package:eddy_support_app/statemanagement/states.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:eddy_support_app/objects/airlines.dart';
import 'package:flutter/material.dart';

class AirlineGrid extends StatelessWidget{
  const AirlineGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String toFilter = context.watch<CPTextBoxState>().textController.text;
    return Expanded(child: 
      GridView.extent(maxCrossAxisExtent: 300,
        children: toFilter == '' ? List<AirlineTile>.generate(Airlines.all.length, (index) => AirlineTile(airline: Airlines.all[index])):
        List<AirlineTile>.generate(Airlines.filterBy(toFilter).length, (index) => AirlineTile(airline: Airlines.filterBy(toFilter)[index])),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        childAspectRatio: 1.3,
      )
    );
  }
}

class AirlineTile extends StatelessWidget{
  const AirlineTile({Key? key, required this.airline}) : super(key: key);
  final Airline airline;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(60),
        onTap: () async {await Future.delayed(const Duration(milliseconds: 150)); context.goNamed('Details', params: {'airlineIATA': airline.iata});},
        child: 
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [ 
            Row(mainAxisAlignment: MainAxisAlignment.center, children:[ // Card's Header
              Padding(padding: const EdgeInsets.only(top: 15, bottom: 10), child:Text(airline.name))]),
            const Divider(),
            Expanded(child: ListView(clipBehavior: Clip.hardEdge, children: // Card's Body
              List<ServiceTile>.generate(airline.services.length, (index) => 
                ServiceTile(service: airline.services[index], airlineIATA: airline.iata))
            ))
          ])
        )
    );
  }
}

class ServiceTile extends StatelessWidget{
  const ServiceTile({Key? key, required this.service, required this.airlineIATA}) : super(key: key);
  final Service service;
  final String airlineIATA;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 8),
      isThreeLine: true,
      enabled: service.latestTransmission != null,
      leading: Icon(service.icon, color: service.getStatusColor()),
      title: Text(service.name + ': ' + (service.sinceString()), maxLines: 1), //rich(TextSpan(text: service.name, style: TextStyle(fontWeight: FontStyle.)) ,
      subtitle: Text(service.atString()),
      onTap: () async {await Future.delayed(const Duration(milliseconds: 150)); context.goNamed('Service', params: {'serviceNAME': service.name.replaceAll(' ', ''), 'airlineIATA': airlineIATA});},
    );
  }
}