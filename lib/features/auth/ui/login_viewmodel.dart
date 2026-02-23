import 'package:mobx/mobx.dart';
import '../domain/auth_repository.dart';
import '../domain/entities/auth_user.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final AuthRepository repository;

  _LoginViewModelBase(this.repository);

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @action
  void setUsername(String value) => username = value;

  @action
  void setPassword(String value) => password = value;


  @action
  Future<AuthUser> login() async {
    loading = true;
    errorMessage = null;

    try {
      final authUser = await repository.login(username, password);

      print('Token: ${authUser.token}');
      return authUser;
    } catch (e) {
      errorMessage = 'Usuário ou senha inválidos';
      rethrow;
    }
  }
}
