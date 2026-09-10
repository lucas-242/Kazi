import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_controller.dart';
import 'package:kazi/features/services/presenter/widgets/quick_add_sheet.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Quick-add sheet to create a catalog item without leaving the service form.
/// On success the new item is appended to the form's dropdown (no refetch) and
/// auto-selected; validation/creation errors are shown as a snackbar.
///
/// Only what a registration needs — name, currency, price and commission —
/// because the sheet exists to unblock one rather than to be the catalog
/// screen: anything else about the item is edited there, later.
class AddCatalogItemSheet extends ConsumerStatefulWidget {
  const AddCatalogItemSheet({super.key, required this.service});

  /// The service that keys the [serviceFormControllerProvider] family.
  final Service? service;

  @override
  ConsumerState<AddCatalogItemSheet> createState() =>
      _AddCatalogItemSheetState();
}

class _AddCatalogItemSheetState extends ConsumerState<AddCatalogItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _valueKey = GlobalKey<FormFieldState>();
  final _commissionKey = GlobalKey<FormFieldState>();
  final _nameController = TextEditingController();
  late MoneyMaskedTextController _valueController;
  late final MoneyMaskedTextController _commissionController;
  late SupportedCurrency _currency;
  Color? _color;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _currency = ref.read(kaziDefaultCurrencyProvider);
    _valueController = _buildValueController(_currency, 0);
    _commissionController = MoneyMaskedTextController(
      // Full commission until told otherwise: an item left untouched must be
      // worth all of its value, which is what "no commission" means in money.
      initialValue: 100,
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
  }

  /// The mask shows the currency the item is saved in: any other symbol would
  /// label the amount with a currency it is not stored in.
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

  void _onChangeCurrency(DropdownItem? item) {
    if (item == null) return;
    final currency = SupportedCurrency.fromCode(item.value);
    if (currency == _currency) return;

    final previous = _valueController;
    setState(() {
      _currency = currency;
      _valueController = _buildValueController(currency, previous.numberValue);
    });
    // After the frame: the field keeps the old controller until it rebuilds.
    WidgetsBinding.instance.addPostFrameCallback((_) => previous.dispose());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _commissionController.dispose();
    super.dispose();
  }

  Future<void> _onConfirm() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final provider = serviceFormControllerProvider(service: widget.service);
    try {
      await ref
          .read(provider.notifier)
          .quickAddCatalogItem(
            name: _nameController.text,
            defaultValue: _valueController.numberValue,
            commissionPercent: _commissionController.numberValue,
            currency: _currency,
            color: _color,
          );
      if (mounted) KaziNavigator.pop();
    } on AppError catch (exception) {
      if (mounted) {
        setState(() => _saving = false);
        KaziSnackbar.show(context, exception.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        KaziSnackbar.show(context, KaziLocalizations.current.errorUnknowError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;

    return QuickAddSheet(
      title: l10n.newCatalogItem,
      formKey: _formKey,
      isSaving: _saving,
      onConfirm: _onConfirm,
      children: [
        KaziFieldInput(
          fieldKey: _nameKey,
          label: l10n.name,
          controller: _nameController,
          autofocus: true,
          validator: (value) =>
              FormValidator.validateTextField(value, l10n.name),
        ),
        KaziSpacings.verticalXs,
        KaziFieldPicker(
          label: l10n.currency,
          placeholder: l10n.selectCurrency,
          searchLabel: l10n.search,
          noResultsLabel: l10n.noResults,
          showSearch: true,
          items: _currencyItems,
          selectedItem: DropdownItem(
            value: _currency.isoCode,
            label: '${_currency.isoCode} (${_currency.symbol})',
          ),
          onChanged: _onChangeCurrency,
        ),
        KaziSpacings.verticalXs,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: KaziFieldInput(
                fieldKey: _valueKey,
                label: l10n.defaultPrice,
                controller: _valueController,
                keyboardType: TextInputType.number,
                validator: (value) => FormValidator.validateNumberField(
                  _valueController.numberValue.toString(),
                  l10n.defaultPrice,
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
                textInputAction: TextInputAction.done,
                validator: (value) => FormValidator.validateNumberField(
                  _commissionController.numberValue.toString(),
                  l10n.commission,
                ),
              ),
            ),
          ],
        ),
        KaziSpacings.verticalMd,
        KaziFieldCaption(l10n.colorSwipeAll),
        KaziSpacings.verticalXs,
        // One scrolling row rather than a grid: eighteen colours in a grid grow
        // the sheet by three rows and push the button off screen.
        KaziColorSwatchPicker(
          selected: _color,
          isScrollable: true,
          onChanged: (color) => setState(() => _color = color),
        ),
      ],
    );
  }
}
