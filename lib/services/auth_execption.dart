// login excesptopn
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register excesptopn
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// genneric excesptopn

class GennericAuthException implements Exception {}

class UserNotLoggedAuthException implements Exception {}
