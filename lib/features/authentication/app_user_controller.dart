import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_inventory/features/authentication/app_user_state.dart';

final appUserControllerProvider = StateNotifierProvider<AppUserController, AppUserState>((ref) {
  return AppUserController(
    const AppUserState(token: "")
  );
});

class AppUserController extends StateNotifier<AppUserState> {
  AppUserController(AppUserState state) : super(state);

  void loginUser(String token) {
    state = state.copyWith(token: token);
  }
}