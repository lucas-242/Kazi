import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/views/settings/settings.dart';

import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class AddServiceTypeForm extends StatefulWidget {
  final String labelButton;
  final Function() onConfirm;
  const AddServiceTypeForm(
      {super.key, required this.labelButton, required this.onConfirm});

  @override
  State<AddServiceTypeForm> createState() => _AddServiceTypeFormState();
}

class _AddServiceTypeFormState extends State<AddServiceTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _defaultKey = GlobalKey<FormFieldState>();
  final _discountPercentKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _NameField(fieldKey: _nameKey),
            const SizedBox(height: 10),
            _DefaultValueField(fieldKey: _defaultKey),
            const SizedBox(height: 10),
            _DiscountPercentField(fieldKey: _discountPercentKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => widget.onConfirm(),
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
    final cubit = context.read<SettingsCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: 'Nome',
      initialValue: cubit.state.serviceType.name,
      onChanged: (value) => cubit.changeServiceTypeName(value),
    );
  }
}

class _DefaultValueField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _DefaultValueField({Key? key, required this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: 'Valor padrão',
      keyboardType: TextInputType.number,
      initialValue: cubit.state.serviceType.defaultValue?.toString(),
      onChanged: (value) => cubit.changeServiceTypeDefaultValue(value),
    );
  }
}

class _DiscountPercentField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _DiscountPercentField({Key? key, required this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: 'Porcentagem do desconto',
      keyboardType: TextInputType.number,
      initialValue: cubit.state.serviceType.discountPercent?.toString(),
      onChanged: (value) => cubit.changeServiceTypeDiscountPercent(value),
    );
  }
}
