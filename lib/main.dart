import 'package:eddy_support_app/objects/airlines.dart';
import 'package:eddy_support_app/pages/page_issues.dart';
import 'package:eddy_support_app/pages/page_control_tower.dart';
import 'package:eddy_support_app/pages/page_logs.dart';
import 'package:eddy_support_app/pages/page_airline_details.dart';
import 'package:eddy_support_app/pages/page_service_details.dart';
import 'package:eddy_support_app/statemanagement/states.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/manufacturers/v1.dart';
import 'package:googleapis/logging/v2.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn, GoogleSignInAccount;
import 'dart:math';

void main() => runApp(
  MultiProvider(providers: [
        ChangeNotifierProvider.value(value: SideMenuStateManager(),),
        ChangeNotifierProvider.value(value: ExtendMenuStateManager(),),
        ChangeNotifierProvider.value(value: CPTextBoxState(),),
        // Another Provider here;
      ],
    child: ESA()));

// [Eddy Support Application]
class ESA extends StatelessWidget {
  ESA({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    /// Randomly generated service data for testing purposes!!
    for (Airline airline in Airlines.all) {
      Random generator = Random();
      airline.services.add(Service(name: 'Daily Import', icon: Icons.import_export_sharp));
      if (generator.nextBool()) {
        airline.services[0].latestTransmission = DateTime.now().subtract(Duration(hours: generator.nextInt(48), minutes: generator.nextInt(60)));
      }
      if (Random.secure().nextBool()) {
        airline.services.add(Service(name: 'Data Science', icon: Icons.perm_data_setting_sharp, 
        latestTransmission: DateTime.now().subtract(Duration(hours: generator.nextInt(72), minutes: generator.nextInt(60)))));
      }

      if (Random.secure().nextBool()) {
        airline.services.add(Service(name: 'Live Fares', icon: Icons.rocket_launch_sharp, 
        latestTransmission: DateTime.now().subtract(Duration(hours: generator.nextInt(72), minutes: generator.nextInt(60)))));
      }
    }

    return MaterialApp.router(
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
    title: 'Eddy Support App',
    theme: ThemeData(primarySwatch: Colors.blue)
  );}

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/',
    errorPageBuilder: (context, state) => const MaterialPage(child: ControlTower()),
    routes: [
      GoRoute(
        name: 'Control Tower',
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(child: ControlTower())
      ),
      GoRoute(
        name: 'Details',
        path: '/details/:airlineIATA',
        pageBuilder: (context, state) {
            final airline = Airlines.all.firstWhere((airline) => airline.iata.toLowerCase() == state.params['airlineIATA']!.toLowerCase());
            return  MaterialPage(child: AirlineDetails(airline: airline));
          },
        routes: [
          GoRoute(
          name: 'Service',
          path: ':serviceNAME',
          pageBuilder: (context, state) {
            final airlineID = Airlines.all.indexWhere((airline) => airline.iata.toLowerCase() == state.params['airlineIATA']!.toLowerCase());
            final service = Airlines.all[airlineID].services.firstWhere((service) => 
              service.name.toLowerCase().replaceAll(' ', '') == state.params['serviceNAME']!.toLowerCase());
            return  MaterialPage(child: ServiceDetails(service: service));
          })
        ],
      ),
      GoRoute(
        name: 'Logs',
        path: '/logs',
        pageBuilder: (context, state) =>  const MaterialPage(child: Logs()),
      ),
      GoRoute(
        name: 'Issues',
        path: '/issues',
        pageBuilder: (context, state) => const MaterialPage(child: Issues()),
      ),
    ],
  );
}