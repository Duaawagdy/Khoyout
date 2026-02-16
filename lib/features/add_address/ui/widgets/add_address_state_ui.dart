import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';

class AddAddressStateUi extends StatelessWidget {
  const AddAddressStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit,AddressState>(
      listener: (context, state) {
        if (state is AddAddressLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is AddAddressSuccess) {
          //CashHelper.putBool(key: Keys.guestMode, value:false);
          context.pop();
       context.pop();
AddressCubit.get(context).getAddress();
        } else if (state is AddAddressError) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(context, S.of(context).error, S.of(context).somethingWentWrong);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
