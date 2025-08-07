class Experience {
  final String title;
  final String role;
  final String period;
  final List<String> description;
  final String type; // 'work', 'freelance', 'activity'

  const Experience({
    required this.title,
    required this.role,
    required this.period,
    required this.description,
    required this.type,
  });
}
