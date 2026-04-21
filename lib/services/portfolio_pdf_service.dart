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
import '../domain/repositories/project_repository.dart';

class PortfolioPdfService {
  // ── Colors ───────────────────────────────────────────────────
  static final _accent = PdfColor.fromHex('2563EB');
  static final _dark = PdfColor.fromHex('0F172A');
  static final _body = PdfColor.fromHex('334155');
  static final _muted = PdfColor.fromHex('64748B');
  static final _border = PdfColor.fromHex('E2E8F0');
  static final _tagBg = PdfColor.fromHex('EFF6FF');
  static final _sectionBg = PdfColor.fromHex('F8FAFC');

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

    final projects = await ProjectRepository().getProjects();

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: font, bold: font),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 40),
        footer: (ctx) => _footer(font, ctx),
        build: (ctx) => [
          _buildHeader(font),
          pw.SizedBox(height: 16),
          _buildBio(font),
          pw.SizedBox(height: 18),
          _section('SKILLS', font, _buildSkills(font)),
          pw.SizedBox(height: 16),
          _section('EXPERIENCE', font, _buildExperience(font)),
          pw.SizedBox(height: 16),
          _section('AWARDS', font, _buildAwards(font)),
          pw.NewPage(),
          _section('PROJECTS', font, pw.SizedBox()),
          pw.SizedBox(height: 10),
          ...projects.take(5).expand((p) => [
                _buildProject(p, font),
                pw.SizedBox(height: 14),
              ]),
        ],
      ),
    );

    return pdf.save();
  }

  // ── Footer ───────────────────────────────────────────────────
  static pw.Widget _footer(pw.Font font, pw.Context ctx) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'devpark435.github.io/portfolio_flutter_web',
          style: pw.TextStyle(font: font, fontSize: 7.5, color: _muted),
        ),
        pw.Text(
          '${ctx.pageNumber} / ${ctx.pagesCount}',
          style: pw.TextStyle(font: font, fontSize: 7.5, color: _muted),
        ),
      ],
    );
  }

  // ── Header ───────────────────────────────────────────────────
  static pw.Widget _buildHeader(pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(22),
      decoration: pw.BoxDecoration(
        color: _dark,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                '박현렬',
                style: pw.TextStyle(font: font, fontSize: 26, color: PdfColors.white),
              ),
              pw.SizedBox(width: 12),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 3),
                child: pw.Text(
                  'Flutter & iOS Developer',
                  style: pw.TextStyle(font: font, fontSize: 12, color: _accent),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              _contactChip(font, 'devpark435@gmail.com'),
              pw.SizedBox(width: 12),
              _contactChip(font, 'github.com/devpark435'),
              pw.SizedBox(width: 12),
              _contactChip(font, '포트폴리오 사이트'),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _contactChip(pw.Font font, String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('1E3A6E'),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: 8, color: PdfColor.fromHex('FFFFFFAA')),
      ),
    );
  }

  // ── Bio ──────────────────────────────────────────────────────
  static pw.Widget _buildBio(pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: _accent, width: 3)),
        color: _sectionBg,
      ),
      child: pw.Text(
        profileBio.replaceAll('\n', ' '),
        style: pw.TextStyle(font: font, fontSize: 9.5, color: _body, lineSpacing: 3),
      ),
    );
  }

  // ── Section wrapper ──────────────────────────────────────────
  static pw.Widget _section(String title, pw.Font font, pw.Widget content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(
                font: font,
                fontSize: 8.5,
                color: _accent,
                letterSpacing: 1.8,
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(child: pw.Divider(color: _border, thickness: 0.7)),
          ],
        ),
        pw.SizedBox(height: 10),
        content,
      ],
    );
  }

  // ── Skills ───────────────────────────────────────────────────
  static pw.Widget _buildSkills(pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: skills.map((skill) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 7),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 88,
                child: pw.Text(
                  skill.title,
                  style: pw.TextStyle(font: font, fontSize: 8.5, color: _muted),
                ),
              ),
              pw.Expanded(
                child: pw.Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: skill.skills
                      .map((s) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: pw.BoxDecoration(
                              color: _tagBg,
                              borderRadius:
                                  const pw.BorderRadius.all(pw.Radius.circular(4)),
                              border: pw.Border.all(
                                color: PdfColor.fromHex('BFDBFE'),
                              ),
                            ),
                            child: pw.Text(
                              s,
                              style: pw.TextStyle(
                                  font: font, fontSize: 8, color: _accent),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ── Experience ───────────────────────────────────────────────
  static pw.Widget _buildExperience(pw.Font font) {
    final work = experiences
        .where((e) => e.type == 'work' || e.type == 'freelance')
        .toList();
    final activity =
        experiences.where((e) => e.type == 'activity').toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        ...work.map((e) => _expItem(e, font, isWork: true)),
        if (work.isNotEmpty && activity.isNotEmpty) pw.SizedBox(height: 6),
        ...activity.map((e) => _expItem(e, font, isWork: false)),
      ],
    );
  }

  static pw.Widget _expItem(Experience exp, pw.Font font,
      {required bool isWork}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 5,
            height: 5,
            margin: const pw.EdgeInsets.only(top: 3, right: 10),
            decoration: pw.BoxDecoration(
              color: isWork ? _accent : _muted,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      exp.title,
                      style: pw.TextStyle(
                          font: font, fontSize: 9.5, color: _dark),
                    ),
                    pw.SizedBox(width: 6),
                    pw.Text(
                      '· ${exp.role}',
                      style:
                          pw.TextStyle(font: font, fontSize: 8.5, color: _muted),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      exp.period,
                      style:
                          pw.TextStyle(font: font, fontSize: 7.5, color: _muted),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),
                ...exp.description.map(
                  (d) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 2),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('• ',
                            style: pw.TextStyle(
                                font: font, fontSize: 8, color: _muted)),
                        pw.Expanded(
                          child: pw.Text(
                            d,
                            style: pw.TextStyle(
                                font: font, fontSize: 8.5, color: _body,
                                lineSpacing: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Awards ───────────────────────────────────────────────────
  static pw.Widget _buildAwards(pw.Font font) {
    return pw.Row(
      children: awards
          .map(
            (a) => pw.Expanded(
              child: pw.Container(
                margin: const pw.EdgeInsets.only(right: 6),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: _border),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(a.award,
                        style: pw.TextStyle(
                            font: font, fontSize: 9.5, color: _accent)),
                    pw.SizedBox(height: 3),
                    pw.Text(a.title,
                        style: pw.TextStyle(
                            font: font, fontSize: 7.5, color: _dark)),
                    pw.SizedBox(height: 2),
                    pw.Text(a.date,
                        style: pw.TextStyle(
                            font: font, fontSize: 7, color: _muted)),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ── Project card ─────────────────────────────────────────────
  static pw.Widget _buildProject(dynamic project, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _border),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Title + meta
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Text(
                  project.title,
                  style: pw.TextStyle(font: font, fontSize: 11, color: _dark),
                ),
              ),
              pw.Text(
                '${project.period}  |  ${project.teamSize}',
                style: pw.TextStyle(font: font, fontSize: 7.5, color: _muted),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            project.summary,
            style:
                pw.TextStyle(font: font, fontSize: 8.5, color: _muted, lineSpacing: 1.5),
          ),
          pw.SizedBox(height: 8),
          // Tech stack pills
          pw.Wrap(
            spacing: 4,
            runSpacing: 3,
            children: (project.technologies as List<String>)
                .map(
                  (t) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: pw.BoxDecoration(
                      color: _tagBg,
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(3)),
                      border: pw.Border.all(color: PdfColor.fromHex('BFDBFE')),
                    ),
                    child: pw.Text(t,
                        style: pw.TextStyle(
                            font: font, fontSize: 7.5, color: _accent)),
                  ),
                )
                .toList(),
          ),
          pw.SizedBox(height: 10),
          // Responsibilities
          pw.Text('담당 업무',
              style: pw.TextStyle(font: font, fontSize: 8.5, color: _dark)),
          pw.SizedBox(height: 4),
          ...(project.responsibilities as List<String>).map(
            (r) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('• ',
                      style: pw.TextStyle(
                          font: font, fontSize: 8, color: _muted)),
                  pw.Expanded(
                    child: pw.Text(r,
                        style: pw.TextStyle(
                            font: font, fontSize: 8.5, color: _body,
                            lineSpacing: 1.5)),
                  ),
                ],
              ),
            ),
          ),
          // Troubleshooting highlight (1건)
          if ((project.troubleshooting as List).isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: _sectionBg,
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(5)),
                border: pw.Border.all(color: _border),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('DBEAFE'),
                          borderRadius:
                              const pw.BorderRadius.all(pw.Radius.circular(3)),
                        ),
                        child: pw.Text('문제 해결',
                            style: pw.TextStyle(
                                font: font, fontSize: 7.5, color: _accent)),
                      ),
                      pw.SizedBox(width: 8),
                      pw.Expanded(
                        child: pw.Text(
                          project.troubleshooting[0].issue,
                          style: pw.TextStyle(
                              font: font, fontSize: 8.5, color: _dark),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    project.troubleshooting[0].solution,
                    style: pw.TextStyle(
                        font: font,
                        fontSize: 8,
                        color: _body,
                        lineSpacing: 2),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
