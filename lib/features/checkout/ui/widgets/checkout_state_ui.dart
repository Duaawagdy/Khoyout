import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/checkout/logic/checkout_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class CheckoutStateUi extends StatelessWidget {
  const CheckoutStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutLoading) {
          print('Checkout loading state');
           _showErrorBottomSheet(context);
        } else if (state is CheckoutSuccess) {
          context.pop();
          context.pushReplacementNamed(Routes.trackOrdertScreen,
              arguments: state.orderResponse);
          //_showErrorBottomSheet(context);
        } else if (state is CheckoutError) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(
              context, S.of(context).error, S.of(context).somethingWentWrong);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Future<void> _showErrorBottomSheet(
    BuildContext context,
  )async {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            verticalSpace(40),
            Image.asset('assets/Delivery-cuate.png'),
            verticalSpace(29),
            SizedBox(
              width: 275.w,
              child: Text(
                textAlign: TextAlign.center,
                'Processing your order...',
                style: TextStyles.font20BlackMedium
                    .copyWith(fontWeight: FontWeightHelper.bold),
              ),
            ),
            verticalSpace(8),
            SizedBox(
              width: 293.w,
              child: Text(
                textAlign: TextAlign.center,
                'Please wait a moment while we securely confirm your order.',
                style: TextStyles.font14BlackRegular,
              ),
            ),
            verticalSpace(54)
          ],
        );
      },
    );
  }
}
