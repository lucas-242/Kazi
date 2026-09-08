import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class CatalogItemForm extends ConsumerStatefulWidget {
  const CatalogItemForm({super.key, required this.formKey});

  /// Owned by the page, which holds the footer button that submits it.
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<CatalogItemForm> createState() =>
      _CatalogItemFormContentState();
}

class _CatalogItemFormContentState extends ConsumerState<CatalogItemForm> {
  final _nameKey = GlobalKey<FormFieldState>();
  final _serviceValueKey = GlobalKey<FormFieldState>();
  final _commissionKey = GlobalKey<FormFieldState>();
  late MoneyMaskedTextController _serviceValueController;
  late final MoneyMaskedTextController _commissionController;
  late SupportedCurrency _currency;

  @override
  void initState() {
    final catalogItem = ref.read(catalogControllerProvider).catalogItem;
    _currency = SupportedCurrency.fromCode(
      catalogItem.currency,
      fallback: ref.read(kaziDefaultCurrencyProvider),
    );
    _serviceValueController = _buildValueController(
      _currency,
      catalogItem.defaultValue ?? 0,
    );
    _commissionController = MoneyMaskedTextController(
      initialValue: catalogItem.effectiveCommissionPercent ?? 100,
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
    super.initState();
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

  void _onChangeCurrency(DropdownItem? item) {
    if (item == null) return;
    final currency = SupportedCurrency.fromCode(item.value);
    if (currency == _currency) return;
    ref
        .read(catalogControllerProvider.notifier)
        .changeCatalogItemCurrency(currency);
    final number = _serviceValueController.numberValue;
    _serviceValueController.dispose();
    setState(() {
      _currency = currency;
      _serviceValueController = _buildValueController(currency, number);
    });
  }

  /// The name is refused, not merely warned about: the summary by type sums by
  /// item, and two items with one name would split that number in two.
  String? _validateName(String? value) {
    final required = FormValidator.validateTextField(
      value,
      KaziLocalizations.current.name,
    );
    if (required != null) return required;

    return ref.read(catalogControllerProvider).nameCollision == null
        ? null
        : KaziLocalizations.current.catalogItemDuplicateName;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(catalogControllerProvider.notifier);
    final catalogItem = ref.watch(catalogControllerProvider).catalogItem;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KaziFieldInput(
            fieldKey: _nameKey,
            label: KaziLocalizations.current.name,
            initialValue: catalogItem.name,
            onChanged: controller.changeCatalogItemName,
            validator: _validateName,
          ),
          KaziSpacings.verticalXs,
          KaziFieldPicker(
            label: KaziLocalizations.current.currency,
            placeholder: KaziLocalizations.current.selectCurrency,
            searchLabel: KaziLocalizations.current.search,
            noResultsLabel: KaziLocalizations.current.noResults,
            showSearch: true,
            items: _currencyItems,
            selectedItem: DropdownItem(
              value: _currency.isoCode,
              label: '${_currency.isoCode} (${_currency.symbol})',
            ),
            onChanged: _onChangeCurrency,
          ),
          KaziSpacings.verticalXs,
          // Side by side, because they are one decision: the two numbers only
          // mean anything against each other, and the line under them is their
          // answer.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: KaziFieldInput(
                  fieldKey: _serviceValueKey,
                  label: KaziLocalizations.current.defaultPrice,
                  controller: _serviceValueController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      controller.changeCatalogItemDefaultValue(
                        _serviceValueController.numberValue,
                      ),
                  validator: (value) => FormValidator.validateNumberField(
                    _serviceValueController.numberValue.toString(),
                    KaziLocalizations.current.defaultPrice,
                  ),
                ),
              ),
              KaziSpacings.horizontalXs,
              Expanded(
                child: KaziFieldInput(
                  fieldKey: _commissionKey,
                  label: KaziLocalizations.current.commission,
                  controller: _commissionController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) =>
                      controller.changeCatalogItemCommissionPercent(
                        _commissionController.numberValue,
                      ),
                  validator: (value) => FormValidator.validateNumberField(
                    _commissionController.numberValue.toString(),
                    KaziLocalizations.current.commission,
                  ),
                ),
              ),
            ],
          ),
          KaziFieldHint.emphasis(
            KaziLocalizations.current.yoursFromThis(
              NumberFormatUtils.formatCurrencyIn(
                (catalogItem.defaultValue ?? 0) *
                    (catalogItem.effectiveCommissionPercent ?? 100) /
                    100,
                SupportedCurrency.fromCode(
                  catalogItem.currency,
                  fallback: ref.watch(kaziDefaultCurrencyProvider),
                ),
              ),
            ),
          ),
          KaziSpacings.verticalMd,
          KaziFieldCaption(
            '${KaziLocalizations.current.color} · '
            '${KaziLocalizations.current.optional}',
          ),
          KaziSpacings.verticalXs,
          KaziColorSwatchPicker(
            selected: catalogItem.colorAs,
            isScrollable: true,
            onChanged: controller.changeCatalogItemColor,
          ),
          KaziSpacings.verticalLg,
        ],
      ),
    );
  }
}
