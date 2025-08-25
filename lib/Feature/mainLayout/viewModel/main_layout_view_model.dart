import 'package:flower_e_commerce_app/Feature/mainLayout/viewModel/main_layout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'main_layout_intent.dart';

@injectable
class NavigationViewModel extends Cubit<NavigationState> {
  NavigationViewModel() : super(const NavigationState());

  void doIntent(NavigationIntent intent) {
    switch (intent) {
      case ChangeTabIntent(:final newIndex):
        emit(state.copyWith(selectedIndex: newIndex));
    }
  }

}

