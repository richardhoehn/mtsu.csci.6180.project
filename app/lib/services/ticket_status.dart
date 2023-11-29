class TicketStatus {
  int id;
  String name;

  TicketStatus({required this.id, required this.name});

  factory TicketStatus.fromJson(Map<String, dynamic> json) {
    return TicketStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}