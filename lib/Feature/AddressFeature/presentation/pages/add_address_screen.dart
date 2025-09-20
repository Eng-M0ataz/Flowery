import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_view_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/add_address_screen_body.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressEntity? addressToEdit;
  const AddAddressScreen({super.key, this.addressToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final viewModel = getIt<AddressViewModel>()
          ..doIntent(GetGovernoratesEvent());

        if (addressToEdit != null) {
          Future.delayed(Duration(milliseconds: 500), () {
            viewModel
                .doIntent(InitializeEditAddressEvent(address: addressToEdit!));
          });
        }

        return viewModel;
      },
      child: AddAddressScreenBody(),
    );
  }
}
