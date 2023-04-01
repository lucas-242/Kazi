import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/fields/fields.dart';
import '../service_types.dart';

class ServiceTypeFormContent extends StatefulWidget {
  final String labelButton;
  final Function() onConfirm;
  const ServiceTypeFormContent(
      {super.key, required this.labelButton, required this.onConfirm});

  @override
  State<ServiceTypeFormContent> createState() => _ServiceTypeFormContentState();
}

class _ServiceTypeFormContentState extends State<ServiceTypeFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _defaultKey = GlobalKey<FormFieldState>();
  final _discountPercentKey = GlobalKey<FormFieldState>();

  void onConfirm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            _NameField(fieldKey: _nameKey),
            const SizedBox(height: 30),
            _DefaultValueField(fieldKey: _defaultKey),
            const SizedBox(height: 30),
            _DiscountPercentField(fieldKey: _discountPercentKey),
            const SizedBox(height: 35),
            CustomElevatedButton(
              onTap: onConfirm,
              text: widget.labelButton,
            ),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _NameField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.current.name;
    final cubit = context.read<ServiceTypesCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      initialValue: cubit.state.serviceType.name,
      onChanged: (value) => cubit.changeServiceTypeName(value),
      validator: (value) => cubit.validateTextField(value, label),
    );
  }
}

class _DefaultValueField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _DefaultValueField({Key? key, required this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.current.defaultValue;
    final cubit = context.read<ServiceTypesCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      keyboardType: TextInputType.number,
      initialValue: cubit.state.serviceType.defaultValue?.toString(),
      onChanged: (value) => cubit.changeServiceTypeDefaultValue(value),
      validator: (value) => cubit.validateNumberField(value, label),
    );
  }
}

class _DiscountPercentField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _DiscountPercentField({Key? key, required this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.current.discountPercentage;
    final cubit = context.read<ServiceTypesCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: label,
      keyboardType: TextInputType.number,
      initialValue: cubit.state.serviceType.discountPercent?.toString(),
      onChanged: (value) => cubit.changeServiceTypeDiscountPercent(value),
      validator: (value) => cubit.validateNumberField(value, label),
    );
  }
}
