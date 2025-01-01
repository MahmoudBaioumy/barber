class AuthStates {}

//**********  Login  *********//////////////////////////////////////////
class AuthInitState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final String role;

  LoginSuccessState({required this.role});
}

class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState({required this.error});
}
class AuthErrorState extends AuthStates {
  final String error;
  AuthErrorState(this.error);
}

///******** singup as client */////////////////

class signupLoadingStates extends AuthStates {}

class signupSuccessStates extends AuthStates {}

class signupErorrStates extends AuthStates {
  final String Erorr;

  signupErorrStates({required this.Erorr});
}
//upload Data  of Onwer
class UploaddataLoadingStates extends AuthStates {}

class UploaddataSuccessStates extends AuthStates {}

class UploaddataErorrStates extends AuthStates {
  final String Erorr;

  UploaddataErorrStates({required this.Erorr});
}