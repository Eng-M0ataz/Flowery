import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_view_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/saved_address_screen_body.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<AddressViewModel>()..doIntent(GetAddressesEvent()),
        child: SavedAddressScreenBody());
  }
}
