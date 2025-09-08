import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconSize: AppSizes.lgIcon_32,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Theme.of(context).colorScheme.primary,
      ),
      underline: const SizedBox(),
      hint: const Text("Deliver to 2XVP+XC - Sheikh Zayed"),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        overflow: TextOverflow.ellipsis,
      ),
      items: const [
        DropdownMenuItem(
          value: "Deliver to 2XVP+XC - Sheikh Zayed ",
          child: Text(
            "Deliver to 2XVP+XC - Sheikh Zayed",
          ),
        ),
        DropdownMenuItem(
          value: "Deliver to 3XVP+XC - Sheikh Zayed",
          child: Text("Deliver to 3XVP+XC - Sheikh Zayed"),
        ),
      ],
      onChanged: (value) {},
    );
  }
}
