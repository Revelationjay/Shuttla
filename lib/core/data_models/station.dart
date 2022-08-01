// To parse this JSON data, do
//
//     final station = stationFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  Station({
    required this.stationName,
    required this.coordinates,
    required this.createdDate,
    this.stationId,
    this.reference,
    this.driverId,
    this.description,
    this.driverName,
    this.plateNumber,
  });

  String? stationId;
  DocumentReference? reference;
  String stationName;
  String? description;
  ///format: LatLng
  List<double> coordinates;
  String createdDate;
  String? driverId;
  String? driverName;
  String? plateNumber;

  Station copyWith({
    String? stationName,
    String? description,
    List<double>? coordinates,
    String? createdDate,
    String? driverId,
    String? driverName,
    String? plateNumber,
  }) =>
      Station(
        stationName: stationName ?? this.stationName,
        description: description ?? this.description,
        coordinates: coordinates ?? this.coordinates,
        createdDate: createdDate ?? this.createdDate,
        driverId: driverId ?? this.driverId,
        driverName: driverName ?? this.driverName,
        plateNumber: plateNumber ?? this.plateNumber,
        reference: this.reference,
        stationId: this.stationId,
      );

  factory Station.fromJson(String str) => Station.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Station.fromMap(Map<String, dynamic> json) => Station(
    stationName: json["station_name"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    createdDate: json["created_date"],
    driverId: json["driver_id"],
    driverName: json["driver_name"],
    plateNumber: json["plate_number"],
    description: json["description"],
  );

  factory Station.fromFirebaseSnapshot(DocumentSnapshot doc) => Station(
    stationId: doc.id,
    reference: doc.reference,
    stationName: doc.data()?["station_name"],
    coordinates: List<double>.from(doc.data()?["coordinates"].map((x) => x.toDouble())),
    createdDate: doc.data()?["created_date"],
    driverId: doc.data()?["driver_id"],
    driverName: doc.data()?["driver_name"],
    plateNumber: doc.data()?["plate_number"],
    description: doc.data()?["description"],
  );

  Map<String, dynamic> toMap() => {
    "station_name": stationName,
    "description" : description,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "created_date": createdDate,
    "driver_id": driverId,
    "driver_name": driverName,
    "plate_number": plateNumber,
  };
}

///{
//     "station_name" : "hey",
//     "coordinates" : [6.943, 8.126],
//     "created_date" : "hdk",
//     "driver_id" : "",
//     "driver_name" : "",
//     "plate_number" : "driver_plate_number"
// }