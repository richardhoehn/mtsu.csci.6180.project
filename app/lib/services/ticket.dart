import 'package:app/services/geo_location.dart';
import 'package:app/services/problem_type.dart';
import 'package:app/services/ticket_status.dart';
import 'package:app/services/user.dart';
import 'package:app/util/config.dart';
import 'package:dio/dio.dart';

class Ticket {
  final dio = Dio();

  DateTime createAt;
  User createdBy;
  GeoLocation geoLocation;
  String id;
  String licencePlate;
  String name;
  ProblemType problemType;
  TicketStatus ticketStatus;
  DateTime updateAt;
  User updatedBy;

  Ticket({
    required this.createAt,
    required this.createdBy,
    required this.geoLocation,
    required this.id,
    required this.licencePlate,
    required this.name,
    required this.problemType,
    required this.ticketStatus,
    required this.updateAt,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'licencePlate': licencePlate,
      'ticketStatusId': ticketStatus.id,
      'problemTypeId': problemType.id,
      'geoLocation': geoLocation.toJson()
    };
  }

  Future<Ticket> updateProblemType(ProblemType problemType) async {
    print('Updating Problem Type');
    this.problemType = problemType;
    await dio.put(
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$id',
        data: toJson());
    return this;
  }

 Future<Ticket> updateTicketStatus(TicketStatus ticketStatus) async {
  print('Updating Ticket Status');
    this.ticketStatus = ticketStatus;
    await dio.put(
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$id',
        data: toJson());
    return this;
  }

  Future<Ticket> updateGeoLocation(GeoLocation geoLocation) async {
    print('Updating Geo Location');
    this.geoLocation = geoLocation;
    await dio.put(
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$id',
        data: toJson());
    return this;
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      createAt: DateTime.parse(json['create']['at']),
      createdBy: User.fromJson(json['create']['by']),
      geoLocation: GeoLocation.fromJson(json['geoLocation']),
      id: json['id'],
      licencePlate: json['licencePlate'],
      name: json['name'],
      problemType: ProblemType.fromJson(json['problemType']),
      ticketStatus: TicketStatus.fromJson(json['ticketStatus']),
      updateAt: DateTime.parse(json['update']['at']),
      updatedBy: User.fromJson(json['update']['by']),
    );
  }
}
