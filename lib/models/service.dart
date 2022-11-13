import 'service_type.dart';

class Service {
  String id;
  String name;
  double value;
  ServiceType type;
  DateTime date;

  Service({
    required this.id,
    required this.name,
    required this.value,
    required this.type,
    required this.date,
  });
}
