// features/Auth/presentation/cubit/auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}
class SignupLoading extends AuthState {}
class SignupSuccess extends AuthState {}
class SignupError extends AuthState {
  final String message;
  SignupError(this.message);
}
class OtpLoading extends AuthState {}
class OtpSuccess extends AuthState {}
class OtpError extends AuthState {
  final String message;
  OtpError(this.message);
}