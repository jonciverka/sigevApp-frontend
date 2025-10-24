abstract class AuthenticationRepository {
  Future<void> login({required String login, required String password});
}
