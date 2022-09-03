class LoginHandle {
  final String token;
  LoginHandle({required this.token});
  const LoginHandle.foobar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashcode => token.hashCode;

  @override
  String toString() => 'Login Handle (token = $token)';
}

enum LoginError { invalidHandle }
