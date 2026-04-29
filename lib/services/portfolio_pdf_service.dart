// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../data/awards.dart';
import '../data/experiences.dart';
import '../data/profile_info.dart';
import '../data/skills.dart';
import '../domain/models/experience.dart';
import '../domain/models/project.dart';
import '../domain/repositories/project_repository.dart';

class PortfolioPdfService {
  // ── Colors (Clean Minimalist) ──────────────────────────────
  static final _dark = PdfColor.fromHex('000000');
  static final _body = PdfColor.fromHex('111111');
  static final _muted = PdfColor.fromHex('555555');
  static final _border = PdfColor.fromHex('EEEEEE');

  static Future<void> download() async {
    final bytes = await _generate();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', 'portfolio_parkhyunryeol.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  static Future<Uint8List> _generate() async {
    final fontData =
        await rootBundle.load('assets/fonts/PretendardVariable.ttf');
    final font = pw.Font.ttf(fontData);

    // Profile Image
    pw.ImageProvider? profileImage;
    try {
      final profileData = await rootBundle.load('assets/images/profile.jpg');
      profileImage = pw.MemoryImage(profileData.buffer.asUint8List());
    } catch (e) {}

    final allProjects = await ProjectRepository().getProjects();
    // Key Projects: Swipe Gallery (1), Reactive Mind Map (2), DeepGuard AI (9), Pinlog (11)
    final keyProjectIds = ['1', '2', '9', '11'];
    final projects = allProjects.where((p) => keyProjectIds.contains(p.id)).toList();
    // Sort projects in the order of keyProjectIds
    projects.sort((a, b) => keyProjectIds.indexOf(a.id).compareTo(keyProjectIds.indexOf(b.id)));

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: font, bold: font),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(45),
        footer: (ctx) => _footer(font, ctx),
        build: (ctx) => [
          _buildHeader(font, profileImage),
          pw.SizedBox(height: 25),
          
          ..._buildSection(title: 'ABOUT', font: font, children: [
            _buildBio(font),
          ]),
          pw.SizedBox(height: 20),
          
          ..._buildSection(title: 'SKILLS', font: font, children: _buildSkills(font)),
          pw.SizedBox(height: 20),
          
          ..._buildSection(title: 'EXPERIENCE', font: font, children: _buildExperience(font)),
          pw.SizedBox(height: 20),
          
          ..._buildSection(title: 'AWARDS', font: font, children: _buildAwards(font)),
          pw.SizedBox(height: 25),
          
          ..._buildSection(title: 'KEY PROJECTS', font: font, children: [
             pw.SizedBox(height: 10),
             ...projects.asMap().entries.expand((entry) {
                final p = entry.value;
                final isLast = entry.key == projects.length - 1;
                return [
                  _buildProject(p, font),
                  if (!isLast) pw.SizedBox(height: 35),
                ];
              }),
          ]),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _footer(pw.Font font, pw.Context ctx) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        '${ctx.pageNumber} / ${ctx.pagesCount}',
        style: pw.TextStyle(font: font, fontSize: 8, color: _muted),
      ),
    );
  }

  static pw.Widget _buildHeader(pw.Font font, pw.ImageProvider? profileImage) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        if (profileImage != null)
          pw.Container(
            width: 70,
            height: 70,
            margin: const pw.EdgeInsets.only(right: 20),
            child: pw.ClipOval(
              child: pw.Image(profileImage, fit: pw.BoxFit.cover),
            ),
          ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '박현렬',
                style: pw.TextStyle(font: font, fontSize: 28, color: _dark, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'Flutter & iOS Developer',
                style: pw.TextStyle(font: font, fontSize: 12, color: _muted),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Text('devpark435@gmail.com', style: pw.TextStyle(font: font, fontSize: 8.5, color: _body)),
                  pw.SizedBox(width: 12),
                  pw.Text('github.com/devpark435', style: pw.TextStyle(font: font, fontSize: 8.5, color: _body)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildBio(pw.Font font) {
    return pw.Text(
      profileBio.replaceAll('\n', ' '),
      style: pw.TextStyle(font: font, fontSize: 9.5, color: _body, lineSpacing: 3),
    );
  }

  static List<pw.Widget> _buildSection({required String title, required pw.Font font, required List<pw.Widget> children}) {
    return [
      pw.Text(
        title,
        style: pw.TextStyle(font: font, fontSize: 10, color: _dark, fontWeight: pw.FontWeight.bold, letterSpacing: 1),
      ),
      pw.SizedBox(height: 4),
      pw.Divider(color: _dark, thickness: 1),
      pw.SizedBox(height: 8),
      ...children,
    ];
  }

  static List<pw.Widget> _buildSkills(pw.Font font) {
    return skills.map((skill) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 100,
              child: pw.Text(
                skill.title,
                style: pw.TextStyle(font: font, fontSize: 9, color: _dark, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                skill.skills.join(', '),
                style: pw.TextStyle(font: font, fontSize: 9, color: _body),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  static List<pw.Widget> _buildExperience(pw.Font font) {
    final sorted = [...experiences]..sort((a, b) => b.period.compareTo(a.period));
    return sorted.map((e) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('${e.title} - ${e.role}', style: pw.TextStyle(font: font, fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
              pw.Text(e.period, style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted)),
            ],
          ),
          pw.SizedBox(height: 3),
          ...e.description.map((d) => pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8, bottom: 1),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('• ', style: pw.TextStyle(font: font, fontSize: 8.5)),
                pw.Expanded(child: pw.Text(d, style: pw.TextStyle(font: font, fontSize: 8.5, color: _body, lineSpacing: 1.5))),
              ],
            ),
          )),
        ],
      ),
    )).toList();
  }

  static List<pw.Widget> _buildAwards(pw.Font font) {
    return awards.map((a) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        children: [
          pw.Text(a.award, style: pw.TextStyle(font: font, fontSize: 9, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 8),
          pw.Text(a.title, style: pw.TextStyle(font: font, fontSize: 9)),
          pw.Spacer(),
          pw.Text(a.date, style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted)),
        ],
      ),
    )).toList();
  }

  static pw.Widget _buildProject(Project project, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(project.title, style: pw.TextStyle(font: font, fontSize: 12.5, fontWeight: pw.FontWeight.bold, color: _dark)),
            pw.Text('${project.period}  |  ${project.teamSize}', style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted)),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Text(project.summary, style: pw.TextStyle(font: font, fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 3),
        pw.Text(project.description, style: pw.TextStyle(font: font, fontSize: 9, color: _body, lineSpacing: 1.8)),
        pw.SizedBox(height: 10),
        
        pw.Text('Technologies: ${project.technologies.join(", ")}', style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted)),
        pw.SizedBox(height: 10),
        
        pw.Text('Key Responsibilities', style: pw.TextStyle(font: font, fontSize: 9, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 3),
        ...project.responsibilities.map((r) => pw.Padding(
          padding: const pw.EdgeInsets.only(left: 8, bottom: 1),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('- ', style: pw.TextStyle(font: font, fontSize: 8.5)),
              pw.Expanded(child: pw.Text(r, style: pw.TextStyle(font: font, fontSize: 8.5, lineSpacing: 1.5))),
            ],
          ),
        )),
        
        if (project.troubleshooting.isNotEmpty) ...[
          pw.SizedBox(height: 10),
          pw.Text('Troubleshooting', style: pw.TextStyle(font: font, fontSize: 9, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 3),
          ...project.troubleshooting.take(2).map((t) => pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8, bottom: 6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('• Issue: ${t.issue}', style: pw.TextStyle(font: font, fontSize: 8.5, color: _dark)),
                pw.SizedBox(height: 1),
                pw.Text('• Solution: ${t.solution}', style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted, lineSpacing: 1.5)),
              ],
            ),
          )),
        ],
      ],
    );
  }
}


