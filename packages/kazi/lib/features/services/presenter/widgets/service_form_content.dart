import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/core/constants/form_keys.dart';
import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_state.dart';
import 'package:kazi/features/services/presenter/widgets/add_catalog_item_sheet.dart';
import 'package:kazi/features/services/presenter/widgets/add_client_sheet.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The register-a-service form. Four fields, two of them already answered by
/// the catalog. See README.md.
class ServiceFormContent extends ConsumerStatefulWidget {
  const ServiceFormContent({
    super.key,
    required this.service,
    required this.formKey,
    this.isCreating = true,
  });

  final Service? service;

  /// Owned by the page, which holds the footer button that submits it.
  final GlobalKey<FormState> formKey;

  final bool isCreating;

  @override
  ConsumerState<ServiceFormContent> createState() => _ServiceFormContentState();
}

class _ServiceFormContentState extends ConsumerState<ServiceFormContent> {
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _valueKey = GlobalKey<FormFieldState>();
  final _quantityKey = GlobalKey<FormFieldState>();
  final _commissionKey = GlobalKey<FormFieldState>();

  TextEditingController? _quantityController;
  MoneyMaskedTextController? _valueController;
  MoneyMaskedTextController? _commissionController;

  SupportedCurrency _valueCurrency = SupportedCurrency.usd;

  bool _didInitControllers = false;

  void _initControllers(ServiceFormState state) {
    _quantityController = TextEditingController(
      text: state.quantity.toString(),
    );
    _valueCurrency = SupportedCurrency.fromCode(
      state.service.currency,
      fallback: ref.read(kaziDefaultCurrencyProvider),
    );
    _valueController = _buildValueController(
      _valueCurrency,
      state.service.value,
    );
    _commissionController = MoneyMaskedTextController(
      // Effective, not raw: a legacy service shows the share it always paid
      // out, and one with nothing configured shows the full 100%.
      initialValue: state.service.effectiveCommissionPercent,
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
  }

  MoneyMaskedTextController _buildValueController(
    SupportedCurrency currency,
    double initialValue,
  ) {
    return MoneyMaskedTextController(
      initialValue: initialValue,
      leftSymbol: '${currency.symbol} ',
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      precision: currency.decimalDigits,
    );
  }

  List<DropdownItem> get _currencyItems => SupportedCurrency.values
      .map(
        (c) => DropdownItem(
          value: c.isoCode,
          label: '${c.isoCode} (${c.symbol})',
          searchTerms: c.localizedName,
        ),
      )
      .toList();

  Future<void> _onChangeCurrency(DropdownItem? item) async {
    if (item == null) return;
    final currency = SupportedCurrency.fromCode(item.value);
    if (currency == _valueCurrency) return;

    final fromCurrency = _valueCurrency;
    final provider = serviceFormControllerProvider(service: widget.service);
    final current = ref.read(provider).asData?.value;
    if (current == null) return;

    final catalogItem = current.catalogItems
        .where((item) => item.id == current.service.catalogItemId)
        .firstOrNull;
    final originalCurrency = SupportedCurrency.fromCode(
      catalogItem?.currency ?? '',
      fallback: ref.read(kaziDefaultCurrencyProvider),
    );

    final double? newValue;
    if (currency == originalCurrency && catalogItem?.defaultValue != null) {
      // Back to the item's own currency: restore its saved value exactly,
      // sidestepping the drift a round-trip conversion would introduce.
      newValue = catalogItem!.defaultValue!;
    } else {
      newValue = await _convertValue(
        _valueController?.numberValue ?? 0,
        from: fromCurrency,
        to: currency,
      );
    }

    if (!mounted) return;

    if (newValue == null) {
      // Without a rate this would relabel the typed amount as another
      // currency, so the switch is refused. Reported because it is the only
      // user-visible failure in the exchange-rate path — see README.md.
      unawaited(
        ref
            .read(analyticsServiceProvider)
            .log(
              AnalyticsEvent.formCurrencySwitchRefused,
              parameters: {'from': fromCurrency.name, 'to': currency.name},
            ),
      );
      KaziSnackbar.show(context, KaziLocalizations.current.ratesUnavailable);
      return;
    }

    final convertedValue = newValue;
    ref.read(provider.notifier).onChangeServiceCurrency(currency);
    ref.read(provider.notifier).onChangeServiceValue(convertedValue);

    _valueController?.dispose();
    if (!mounted) return;
    setState(() {
      _valueCurrency = currency;
      _valueController = _buildValueController(currency, convertedValue);
    });
  }

  /// Null when no rate is available, so the caller can refuse to relabel the
  /// amount instead of showing it under the wrong currency.
  Future<double?> _convertValue(
    double value, {
    required SupportedCurrency from,
    required SupportedCurrency to,
  }) async {
    try {
      final rates = await ref.read(exchangeRatesProvider.future);
      if (rates == null) return null;

      return CurrencyConverter.convert(
        value: value,
        from: from,
        to: to,
        rates: rates,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _quantityController?.dispose();
    _valueController?.dispose();
    _commissionController?.dispose();
    super.dispose();
  }

  void _onChangedDropdownItem(DropdownItem? data) {
    final provider = serviceFormControllerProvider(service: widget.service);
    final controller = ref.read(provider.notifier);
    if (data != null) {
      controller.onChangeCatalogItem(data);
      final current = ref.read(provider).asData?.value;
      if (current != null) {
        final currency = SupportedCurrency.fromCode(
          current.service.currency,
          fallback: ref.read(kaziDefaultCurrencyProvider),
        );
        _commissionController?.updateValue(
          current.service.effectiveCommissionPercent,
        );
        if (currency != _valueCurrency) {
          _valueController?.dispose();
          setState(() {
            _valueCurrency = currency;
            _valueController = _buildValueController(
              currency,
              current.service.value,
            );
          });
        } else {
          _valueController?.updateValue(current.service.value);
        }
      }
    }
  }

  Future<void> _onAddCatalogItem() async {
    await KaziNavigator.showBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => AddCatalogItemSheet(service: widget.service),
    );
    if (!mounted) return;
    // Quick-add auto-selects the new item, so mirror its value and commission
    // into the money controllers, as _onChangedDropdownItem does.
    final provider = serviceFormControllerProvider(service: widget.service);
    final current = ref.read(provider).asData?.value;
    if (current != null) {
      _valueController?.updateValue(current.service.value);
      _commissionController?.updateValue(
        current.service.effectiveCommissionPercent,
      );
    }
  }

  void _onAddClient() {
    KaziNavigator.showBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => AddClientSheet(service: widget.service),
    );
  }

  /// Midnight [days] ago, which is the shape a date-only service is stored
  /// in — the chips must not stamp the current time onto it.
  DateTime _dayAgo(int days) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - days);
  }

  void _onChangeDate(DateTime date) {
    final provider = serviceFormControllerProvider(service: widget.service);
    ref.read(provider.notifier).onChangeServiceDate(date);
  }

  Future<void> _onPickDate(DateTime selected) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: FormKeys.formStartDate,
      lastDate: FormKeys.formEndDate,
    );
    if (picked != null) _onChangeDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final provider = serviceFormControllerProvider(service: widget.service);
    final asyncState = ref.watch(provider);
    final state = asyncState.asData?.value;

    if (state != null && !_didInitControllers) {
      _didInitControllers = true;
      _initControllers(state);
    }

    if (state == null ||
        _quantityController == null ||
        _valueController == null ||
        _commissionController == null) {
      return const KaziLoading();
    }

    final controller = ref.read(provider.notifier);
    final isSaving = state.status == BaseStateStatus.loading;
    final hasCatalogItem = state.service.catalogItemId.isNotEmpty;

    return Form(
      key: widget.formKey,
      // Read-only and still visible: no dark veil over the screen, because the
      // person has to keep seeing what they typed while it saves.
      child: AbsorbPointer(
        absorbing: isSaving,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KaziFieldPicker(
              label: l10n.catalogItem,
              placeholder: l10n.whatWasDone,
              searchLabel: l10n.search,
              noResultsLabel: l10n.noResults,
              showSearch: true,
              items: state.dropdownItems,
              selectedItem: state.selectedDropdownItem,
              onChanged: _onChangedDropdownItem,
              trailing: KaziFieldAction(
                label: KaziLocalizations.current.newShort,
                onTap: _onAddCatalogItem,
              ),
              validator: (value) =>
                  FormValidator.validateDropdownField(value, l10n.catalogItem),
            ),
            KaziFieldHint(l10n.catalogItemFormHint),
            KaziSpacings.verticalSm,
            KaziFieldPicker(
              label: l10n.client,
              placeholder: l10n.whoWasServed,
              searchLabel: l10n.search,
              noResultsLabel: l10n.noResults,
              showSearch: true,
              items: state.clientDropdownItems,
              selectedItem: state.selectedClientDropdownItem,
              onChanged: controller.onChangeClient,
              onClear: () => controller.onChangeClient(null),
              trailing: KaziFieldAction(
                label: KaziLocalizations.current.newShort,
                onTap: _onAddClient,
              ),
            ),
            KaziFieldHint(l10n.clientFormHint),
            KaziSpacings.verticalSm,
            if (hasCatalogItem) ...[
              KaziFieldPicker(
                label: l10n.currency,
                placeholder: l10n.selectCurrency,
                searchLabel: l10n.search,
                noResultsLabel: l10n.noResults,
                showSearch: true,
                items: _currencyItems,
                selectedItem: DropdownItem(
                  value: _valueCurrency.isoCode,
                  label: '${_valueCurrency.isoCode} (${_valueCurrency.symbol})',
                ),
                onChanged: _onChangeCurrency,
              ),
              KaziFieldHint(l10n.serviceCurrencyHint),
              KaziSpacings.verticalSm,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: KaziFieldInput(
                      fieldKey: _valueKey,
                      label: l10n.amount,
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.onChangeServiceValue(
                        _valueController!.numberValue,
                      ),
                      validator: (value) => FormValidator.validateNumberField(
                        _valueController!.numberValue.toString(),
                        l10n.amount,
                      ),
                    ),
                  ),
                  KaziSpacings.horizontalXs,
                  Expanded(
                    child: KaziFieldInput(
                      fieldKey: _commissionKey,
                      label: l10n.commission,
                      controller: _commissionController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          controller.onChangeServiceCommission(
                            _commissionController!.numberValue,
                          ),
                      validator: (value) => FormValidator.validateNumberField(
                        _commissionController!.numberValue.toString(),
                        l10n.commission,
                      ),
                    ),
                  ),
                ],
              ),
              KaziFieldHint.emphasis(
                l10n.yoursFromThis(
                  NumberFormatUtils.formatCurrencyIn(
                    state.service.commissionValue,
                    _valueCurrency,
                  ),
                ),
              ),
            ],
            KaziSpacings.verticalMd,
            _DateChips(
              selected: state.service.date,
              onToday: () => _onChangeDate(_dayAgo(0)),
              onYesterday: () => _onChangeDate(_dayAgo(1)),
              onPick: () => _onPickDate(state.service.date),
            ),
            KaziSpacings.verticalMd,
            if (widget.isCreating && hasCatalogItem) ...[
              KaziFieldInput(
                fieldKey: _quantityKey,
                label: l10n.quantity,
                controller: _quantityController,
                keyboardType: TextInputType.number,
                onChanged: controller.onChangeServicesQuantity,
                validator: (value) =>
                    FormValidator.validateNumberField(value, l10n.quantity),
              ),
              KaziFieldHint(l10n.quantityHint),
              KaziSpacings.verticalSm,
            ],
            KaziFieldInput(
              fieldKey: _descriptionKey,
              label: l10n.observation,
              placeholder: l10n.observationHint,
              initialValue: state.service.description,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              onChanged: controller.onChangeServiceDescription,
            ),
            KaziSpacings.verticalLg,
          ],
        ),
      ),
    );
  }
}

/// The two dates that cover almost every registration, one tap each, and the
/// calendar behind the third. Once a day is picked from it the chip stops
/// saying "Escolher" and says the day — a chip that keeps its own name after
/// answering leaves the date invisible.
class _DateChips extends StatelessWidget {
  const _DateChips({
    required this.selected,
    required this.onToday,
    required this.onYesterday,
    required this.onPick,
  });

  final DateTime selected;
  final VoidCallback onToday;
  final VoidCallback onYesterday;
  final VoidCallback onPick;

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _pickLabel(
    BuildContext context,
    DateTime now, {
    required bool isPicked,
  }) {
    if (!isPicked) return KaziLocalizations.current.pickDate;

    return DateFormatUtils.day(
      selected,
      locale: Localizations.localeOf(context).toString(),
      now: now,
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = _isSameDay(selected, now);
    final isYesterday = _isSameDay(
      selected,
      now.subtract(const Duration(days: 1)),
    );
    final isPicked = !isToday && !isYesterday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: KaziInsets.xxs,
            bottom: KaziInsets.xs,
          ),
          child: KaziFieldCaption(KaziLocalizations.current.date),
        ),
        Row(
          spacing: KaziInsets.xs,
          children: [
            KaziChip(
              label: KaziLocalizations.current.today,
              isSelected: isToday,
              onTap: onToday,
            ),
            KaziChip(
              label: KaziLocalizations.current.yesterday,
              isSelected: isYesterday,
              onTap: onYesterday,
            ),
            KaziChip(
              label: _pickLabel(context, now, isPicked: isPicked),
              isSelected: isPicked,
              onTap: onPick,
            ),
          ],
        ),
      ],
    );
  }
}
