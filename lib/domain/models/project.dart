class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String metrics;
  final String? imageUrl;
  final String? demoUrl;
  final String? githubUrl;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.metrics,
    this.imageUrl,
    this.demoUrl,
    this.githubUrl,
  });
}
