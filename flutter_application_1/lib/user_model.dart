class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // student, professional, mentor
  final List<String> skills;
  final List<String> interests;
  final List<String> projects;
  final String bio;
  final String profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.skills = const [],
    this.interests = const [],
    this.projects = const [],
    this.bio = '',
    this.profileImageUrl = '',
  });

  static final UserModel _instance = UserModel._default();

  factory UserModel.instance() => _instance;

  UserModel._default()
    : id = '',
      name = 'John Doe',
      email = 'john@example.com',
      role = 'Learner',
      skills = ['Flutter', 'UI/UX'],
      interests = [],
      projects = [],
      bio = 'Passionate about mobile development',
      profileImageUrl = '';

  // Create a copy of the user with updated fields
  UserModel copyWith({
    String? name,
    String? email,
    String? role,
    List<String>? skills,
    List<String>? interests,
    List<String>? projects,
    String? bio,
    String? profileImageUrl,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      projects: projects ?? this.projects,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
