import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';

class AddReviewStateUi extends StatelessWidget {
  const AddReviewStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) async {
        if (state is SetReviewLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => PopScope(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
            ),
          );
        }
        // Handle LoginSuccess state
        else if (state is SetReviewSuccessState) {
          context.pop();
          context.pop();
          if (Navigator.canPop(context)) {
            //context.pushNamedAndRemoveUntil(Routes.navigationBar,predicate:  (route) => false);
            _showErrorBottomSheet(context);
            // context.pushReplacementNamed(Routes.trackOrderScreen,
            //     arguments: state.orderResponseModel);
            //context.pushNamedAndRemoveUntil(Routes.navigationBar,predicate:  (route) => false);
          }
        }

        // Handle LoginError and show the dialog here
        if (state is SetReviewFailureState) {
          context.pop();
          ShowDialogError.showErrorDialog(
              context,
              S.of(context).error, // Pass the "attention" title here
              S.of(context).youAleadyRevwiesthisProduct);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [


              Container(
                padding: EdgeInsetsDirectional.only(top: 12.h,bottom: 25.h,end: 18.w),
                height: 250.h,
               // width: 357.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage(

                      'assets/login-succes.png',
                    )),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Align(
                      alignment:AlignmentDirectional.topEnd,
                      child: GestureDetector(
                        onTap: (){context.pop();},
                        child: Image.asset(
                          AssetsData.squareClose,
                          height: 36.h,
                          width: 36.w,
                        ),
                      ),
                    ),
                    Image.asset("assets/logo.png",height: 48.h,width: 150.w,)
                  ],
                ),
              ),verticalSpace(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 47.w),
                child: Text(
                  S.of(context).Yourproductreviewhasbeensubmitted,
                  textAlign: TextAlign.center,
                  style: TextStyles.font22WhiteMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  S.of(context).Thankyouforyourreview,
                  textAlign: TextAlign.center,
                  style: TextStyles.font18WhiteMedium
                      .copyWith(color: Colors.black),
                ),
              ),
              verticalSpace(49),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: AppTextButton(
                  buttonText: S.of(context).Done,
                  onPressed: () {
                    context.pop();
                  },
                  textStyle:
                      TextStyles.font16BoldWhite.copyWith(color: Colors.white),
                  backgroundColor: ColorsManager.kPrimaryColor,
                  buttonHeight: 50,
                ),
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: ColorsManager.kPrimaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     onPressed: () => context.pop(),
              //     child: Text(S.of(context).tryagain),
              //   ),
              // ),
              verticalSpace(26)
            ],
          ),
        );
      },
    );
  }
}
