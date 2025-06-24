import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';

class OrderButton extends StatelessWidget {
  final OrderCubit cubit;
  final OrderState state;

  const OrderButton({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final isLoading = state is OrderLoading;
    final isBalanceError = state is OrderBalanceError;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final hasCartItems =
            cartState is CartLoaded && cartState.cartModel.items.isNotEmpty;
        final isFormValid = cubit.isFormValid;
        final hasAddresses = cubit.availableAddresses.isNotEmpty;
        final paymentSelected = cubit.isPaymentMethodSelected;
        final canOrder =
            isFormValid && hasCartItems && hasAddresses && !isLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                !canOrder
                    ? null
                    : () {
                      if (!paymentSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a payment method'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      cubit.makeOrder();
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isBalanceError
                      ? Colors.orange
                      : (canOrder ? Colors.green : Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(
                      isBalanceError
                          ? 'Insufficient Balance'
                          : !hasCartItems
                          ? 'No Items in Cart'
                          : !hasAddresses
                          ? 'No Addresses Available'
                          : !isFormValid
                          ? 'Complete Order Info'
                          : 'Make Your Order',
                      style: TextStyle(
                        color: canOrder ? Colors.white : Colors.grey.shade600,
                        fontSize: 18,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
