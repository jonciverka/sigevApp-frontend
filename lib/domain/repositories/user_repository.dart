import 'package:sigev/domain/models/barra_fija.dart';
import 'package:sigev/domain/models/user.dart';

abstract class UserRepository {
  Future<void> getUser();
  Future<BarraFija> getBarraFija();
  Future<User> getClientePorCorreo({required String correo});
  Future<void> apiDeleteUser();
}
