import 'package:kazi/app/models/enums/fast_search.dart';
import 'package:kazi/app/models/enums/order_by.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_group_by_date.dart';

abstract class ServicesService {
  DateTime get now;

  List<Service> orderServices(List<Service> services, OrderBy orderBy);

  ///Group [services] by date ordering by date desc.
  ///
  /// Brings isExpanded property as true if it is grouped by today or yesterday
  List<ServicesGroupByDate> groupServicesByDate(
      List<Service> services, OrderBy orderBy);

  Map<String, DateTime> getRangeDateByFastSearch(FastSearch fastSearch);
}
