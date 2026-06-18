class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? mobile;
  final String? userClass;
  final String? school;
  final String? city;
  final String? photoUrl;
  final String role;

  UserModel({required this.id, required this.name, this.email, this.mobile,
    this.userClass, this.school, this.city, this.photoUrl, this.role = 'student'});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    name: map['name'] ?? '',
    email: map['email'],
    mobile: map['mobile'],
    userClass: map['class'],
    school: map['school'],
    city: map['city'],
    photoUrl: map['photo_url'],
    role: map['role'] ?? 'student',
  );
}
