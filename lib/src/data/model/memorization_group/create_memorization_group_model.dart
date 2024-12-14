class CreateMemorizationGroupModel {
  final List<String> days;
  final String groupName;
  final String groupDescription;
  final String capacity;
  final String startTime;
  final String endTime;
  final String supervisorId;
  final String groupStatus;

  CreateMemorizationGroupModel({
    required this.days,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.supervisorId,
    required this.groupStatus,
  });

  factory CreateMemorizationGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateMemorizationGroupModel(
      days: List<String>.from(json['days']),
      groupName: json['groupName'],
      groupDescription: json['group_description'],
      capacity: json['capacity'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      supervisorId: json['supervisor_id'],
      groupStatus: json['group_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'groupName': groupName,
      'group_description': groupDescription,
      'capacity': capacity,
      'start_time': startTime,
      'end_time': endTime,
      'supervisor_id': supervisorId,
      'group_status': groupStatus,
    };
  }
}
