
import 'package:budgetbee/presentation/screens/add_transaction_screen/page/add_transaction.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 8,
      decoration: InputDecoration(
          hintText: "0",
          hintStyle: text_theme_hyper(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
              horizontal:
                  8.0), // Optional: Adjust content padding
          counterText: ""),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.number,
      style: text_theme_hyper(),
      textAlign: TextAlign.center,
      onChanged: (value) {
        try {
          amount = int.parse(value);
        } catch (e) {}
      },
    );
  }
}
