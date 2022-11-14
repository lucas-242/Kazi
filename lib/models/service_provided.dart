import 'service_type.dart';

class ServiceProvided {
  String id;
  String description;
  double value;
  ServiceType? type;
  String typeId;
  DateTime date;
  String userId;

  ServiceProvided({
    required this.id,
    required this.description,
    required this.value,
    this.type,
    required this.typeId,
    required this.date,
    required this.userId,
  });
}
