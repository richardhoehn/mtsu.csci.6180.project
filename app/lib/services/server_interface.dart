import 'package:app/services/problem_type.dart';
import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio();
    // Set up Dio configurations here
    // For example, setting a base URL
    // _dio.options.baseUrl = 'https://api.example.com';
    // Add interceptors if needed
    // _dio.interceptors.add(...);
  }

  Dio get dio => _dio;


  Future<List<Ticket>> getAllTickets() async {
    List<Ticket> tickets = List.empty(growable: true);
    final response = await _dio.get(
      '${Config.domain.scheme}://${Config.domain.host}/tickets'
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      List<dynamic> responseData = response.data; // Assuming the response is a JSON array
      print(responseData);
      tickets = responseData.map((json) => Ticket.fromJson(json)).toList();
      print(tickets); // For debugging, to see the list of tickets
    } else {
      throw Exception(response.data);
    }

    return tickets;
  }

  Future<List<ProblemType>> getAllProblemTypes() async {
    List<ProblemType> problemTypes = List.empty(growable: true);
    final response = await _dio.get(
      '${Config.domain.scheme}://${Config.domain.host}/problemTypes'
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      List<dynamic> responseData = response.data; // Assuming the response is a JSON array
      print(responseData);
      problemTypes = responseData.map((json) => ProblemType.fromJson(json)).toList();
      print(problemTypes); // For debugging, to see the list of tickets
    } else {
      throw Exception(response.data);
    }

    return problemTypes;
  }
}