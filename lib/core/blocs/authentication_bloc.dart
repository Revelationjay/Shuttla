import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttla/core/data_models/app_user.dart';
import 'package:shuttla/core/services/auth_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late AuthService authService;
  AuthenticationBloc([AuthService? _auth])
      : authService = _auth ?? AuthService(), super(AuthIdleState()) {
    on<AuthPassengerLogin>((event, emit) async {
      emit(AuthAuthenticatingState());
      try {
        AppUser data = await authService.registerPassenger(
          event.nickName,
          event.email,
          event.password,
        );
        return emit(AuthAuthenticatedState(data));
      } catch (error) {
        return emit(AuthErrorState(error));
      }
    });

    on<AuthDriverLogin>((event, emit) async {
      emit(AuthAuthenticatingState());
      try {
        AppUser data = await authService.registerDriver(
          nickName: event.nickName,
          email: event.email,
          password: event.password,
          carColor: event.carColor,
          carModel: event.carModel,
          carManufacturer: event.carManufacturer,
          plateNumber: event.plateNumber,
        );
        return emit(AuthAuthenticatedState(data));
      } catch (error) {
        return emit(AuthErrorState(error));
      }
    });

    on<AuthUserLogout>((event, emit) async {
      authService.logOut();
      return emit(AuthIdleState());
    });
  }
}

///Authentication events
abstract class AuthenticationEvent {}
class AuthUserLogout extends AuthenticationEvent {}
class AuthPassengerLogin extends AuthenticationEvent {
  final String nickName, email, password;
  AuthPassengerLogin(this.nickName, this.email, this.password);
}
class AuthDriverLogin extends AuthenticationEvent {
  final String nickName, email, password;
  final String plateNumber, carManufacturer, carModel, carColor;
  AuthDriverLogin({
    required this.nickName,
    required this.email,
    required this.password,
    required this.plateNumber,
    required this.carManufacturer,
    required this.carModel,
    required this.carColor,
  });
}

///Authentication states
abstract class AuthenticationState {}
class AuthIdleState extends AuthenticationState {}
class AuthAuthenticatingState extends AuthenticationState {}
class AuthErrorState extends AuthenticationState {
  final dynamic error;
  AuthErrorState(this.error);
}
class AuthAuthenticatedState extends AuthenticationState {
  final AppUser user;
  AuthAuthenticatedState(this.user);
}
