import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';
import '../models/troubleshooting.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

class ProjectRepository {
  Future<List<Project>> getProjects() async {
    final jsonString = await rootBundle.loadString('assets/data/projects.json');
    final List<dynamic> data = jsonDecode(jsonString) as List<dynamic>;
    return data.map((e) => _fromJson(e as Map<String, dynamic>)).toList();
  }

  Project _fromJson(Map<String, dynamic> j) {
    return Project(
      id: j['id'] as String,
      title: j['title'] as String,
      summary: j['summary'] as String,
      keyFeatures: List<String>.from(j['keyFeatures'] as List),
      background: j['background'] as String,
      meaning: j['meaning'] as String,
      description: j['description'] as String,
      technologies: List<String>.from(j['technologies'] as List),
      challenges: List<String>.from(j['challenges'] as List),
      responsibilities: List<String>.from(j['responsibilities'] as List),
      improvements: List<String>.from(j['improvements'] as List),
      troubleshooting: (j['troubleshooting'] as List)
          .map((t) => Troubleshooting(
                issue: t['issue'] as String,
                context: t['context'] as String,
                solution: t['solution'] as String,
                learning: t['learning'] as String,
              ))
          .toList(),
      releaseLogs: j['releaseLogs'] == null
          ? null
          : (j['releaseLogs'] as List)
              .map((r) => ReleaseLog(
                    version: r['version'] as String,
                    date: r['date'] as String,
                    changes: List<String>.from(r['changes'] as List),
                  ))
              .toList(),
      period: j['period'] as String,
      teamSize: j['teamSize'] as String,
      imageUrl: j['imageUrl'] as String?,
      githubUrl: j['githubUrl'] as String?,
      deployUrl: j['deployUrl'] as String?,
      demoUrl: j['demoUrl'] as String?,
    );
  }
}
