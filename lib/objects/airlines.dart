import 'package:flutter/material.dart';
import 'dart:math';

enum sortObj {latestUpdate}

class Airlines{
  /// Global to store all Airlines in the App.
  static var all = [
    Airline(name: 'Air Asia', iata: 'AK', location: 'Malaysia'),
    Airline(name: 'Hong Kong Express', iata: 'UO', location: 'Hong Kong'), 
    Airline(name: 'Viva Aerobus', iata: 'VB', location: 'Mexico'),
    Airline(name: 'Flyr', iata: 'FS', location: 'Norway'),
    Airline(name: 'Corendon', iata: 'XC', location: 'Turkey'),
    Airline(name: 'Jet Smart', iata: 'JA', location: 'Chile'),
    Airline(name: 'Ural', iata: 'U6', location: 'Russia'),
    Airline(name: 'Kambr', iata: 'AI', location: 'Portugal'),
    Airline(name: 'Sky', iata: 'H2', location: 'Chile'),
    Airline(name: 'Lynx', iata: 'Y9', location: 'Canada'),
    Airline(name: 'Sun Country', iata: 'SY', location: 'US'),
    Airline(name: 'Air Premia', iata: 'YP', location: 'Korea'),
  ];

  /* static sortBy(sortObj sort, List<Airline> list){
    list.sort(((a, b) => a.services.firstWhere((element) => element.name == '').latestCapture)
  } */
  static filterBy(String toFilter){
    // Get all Airlines whose name property contain the toFilter text
    var result = all.where((element) => element.name.toLowerCase().replaceAll(' ', '').contains(toFilter.toLowerCase().replaceAll(' ', ''))).toList();
    var resultIATA = all.where((element) => element.iata.toLowerCase().replaceAll(' ', '').contains(toFilter.toLowerCase().replaceAll(' ', ''))).toList();
    var resultLocation = all.where((element) => element.location.toLowerCase().replaceAll(' ', '').contains(toFilter.toLowerCase().replaceAll(' ', ''))).toList();
    
    result.addAll(resultIATA.where((element) => !result.contains(element)));
    result.addAll(resultLocation.where((element) => !result.contains(element)));

    /* if (result.isEmpty){ // If no Airlines contain toFilter in their name property
      result = all.where((element) => element.iata.toLowerCase().replaceAll(' ', '').contains(toFilter.toLowerCase().replaceAll(' ', ''))).toList(); // Check for IATA instead
    }
    if (result.isEmpty){  // If no Airlines contain toFilter in their IATA property
      result = all.where((element) => element.location.toLowerCase().replaceAll(' ', '').contains(toFilter.toLowerCase().replaceAll(' ', ''))).toList(); // Check for Location instead
    } */
    return result;
  }
}

class Airline {
  Airline({this.name = '', this.iata = '', this.location = ''});
  final String name;
  final String iata;
  final String location;

  final services = <Service>[];
}

enum ServiceStatus{innactive, active, delayed, running}

class Service {
  Service({required this.name, this.latestTransmission, this.frequency, this.icon = Icons.miscellaneous_services_sharp});
  String name;
  ServiceStatus status = ServiceStatus.innactive;
  IconData icon;
  DateTime? latestTransmission;
  DateTime? latestCapture;
  Duration? frequency;
  
  Color getStatusColor(){
    status = updateStatus();
    switch (status) {
      case ServiceStatus.active :
        return Colors.green;
      case ServiceStatus.innactive :
        return Colors.red;
      case ServiceStatus.delayed :
        return Colors.orange;
      case ServiceStatus.running :
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  ServiceStatus updateStatus(){
    if (latestTransmission == null){
      return ServiceStatus.innactive;
    }

    if (Random.secure().nextBool()) {
      //return ServiceStatus.running;
    }

    if (DateTime.now().difference(latestTransmission!).inHours > 25){
      return ServiceStatus.delayed;
    }

    
    return ServiceStatus.active;
  }

  String sinceString() {
    if (latestTransmission == null){
      return 'No data Found!';
    }
    return latestTransmission!.sameDayOfYear(DateTime.now())?'Captured today.':'Captured on ' + 
    latestTransmission!.day.toString().padLeft(2, '0') + '/' + 
    latestTransmission!.month.toString().padLeft(2, '0');
  }

  String atString(){
    if (latestTransmission == null){
      return '';
    }
    return '@ ' + 
    latestTransmission!.day.toString().padLeft(2, '0') + '/' + 
    latestTransmission!.month.toString().padLeft(2, '0') + ' ' + 
    latestTransmission!.hour.toString().padLeft(2, '0') + ':' + 
    latestTransmission!.minute.toString().padLeft(2, '0');
  }
  //bool get isLate => lastTransmission!.add(frequency!);
}

extension on DateTime{
  bool sameDayOfYear(DateTime toCompare){
    return toCompare.year == year && toCompare.month == month && toCompare.day == day;
  }
}