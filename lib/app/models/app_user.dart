class AppUser {
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  AppUser({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
  });
}
