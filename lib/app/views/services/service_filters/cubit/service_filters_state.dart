part of 'service_filters_cubit.dart';

class ServiceFiltersState with EquatableMixin {
  final DateTime startDate;
  final DateTime endDate;
  final FastSearch fastSearch;
  final bool didFiltersChange;

  ServiceFiltersState({
    required this.startDate,
    required this.endDate,
    required this.fastSearch,
    this.didFiltersChange = false,
  });

  @override
  List<Object?> get props => [startDate, endDate, fastSearch, didFiltersChange];
}
