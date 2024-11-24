import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static const String registerUrl =
      'https://coursafer.innoeg.com/api/auth/register';

  void registerUser(String username, String email, String mobile,
      String password, String passwordConfirmation) async {
    emit(RegisterLoading());
    final Dio dio = Dio(
      BaseOptions(headers: {"Accept": "application/json"}),
    );
    final response = await dio.post(registerUrl, data: {
      'username': username,
      'email': email,
      'mobile': mobile,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(RegisterSuccess());
    } else if (response.statusCode == 302) {
      print("Redirect detected. Status Code: ${response.statusCode}");
      print("Redirect location: ${response.headers['location']}");
      emit(RegisterError('Redirected to another URL'));
    } else {
      emit(RegisterError('Failed with status: ${response.statusCode}'));
    }
  }
}
