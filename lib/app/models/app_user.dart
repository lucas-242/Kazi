class AppUser {

  AppUser({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
  });
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  String get shortName => name.length > 18 ? name.split('').first : name;
}
