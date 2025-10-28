import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

String adress = '';
String value = 'SidiBishr';

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconSize: AppSizes.lgIcon_32,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Theme.of(context).colorScheme.primary,
      ),
      underline: const SizedBox(),
      hint: Text("Deliver to  $adress"),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
      items: [
        DropdownMenuItem(
          value: value,
          child: Text(
            value,
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          adress = value.toString();
        });
      },
    );
  }
}
