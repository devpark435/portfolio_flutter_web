import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import '../../domain/models/project.dart';
import '../screens/project_detail/project_detail_screen.dart';

class ProjectCard extends ConsumerStatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  Offset _glowPos = Offset.zero;
  Size _cardSize = Size.zero;

  late AnimationController _returnCtrl;
  late Tween<double> _xTween;
  late Tween<double> _yTween;
  late Animation<double> _xAnim;
  late Animation<double> _yAnim;

  @override
  void initState() {
    super.initState();
    _xTween = Tween<double>(begin: 0, end: 0);
    _yTween = Tween<double>(begin: 0, end: 0);
    _returnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    final curve = CurvedAnimation(parent: _returnCtrl, curve: Curves.easeOut);
    _xAnim = _xTween.animate(curve);
    _yAnim = _yTween.animate(curve);
  }

  @override
  void dispose() {
    _returnCtrl.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(event.position);
    final size = box.size;
    _cardSize = size;
    final nx = (local.dx / size.width - 0.5) * 2;
    final ny = (local.dy / size.height - 0.5) * 2;
    setState(() {
      _rotateY = nx * 0.12;
      _rotateX = -ny * 0.08;
      _glowPos = local;
    });
  }

  void _onEnter(PointerEvent event) {
    _returnCtrl.stop();
    setState(() => _isHovered = true);
    ref.read(cursorProvider.notifier).setHoverLabel('VIEW');
  }

  void _onExit(PointerEvent event) {
    _xTween.begin = _rotateX;
    _yTween.begin = _rotateY;
    _returnCtrl
      ..reset()
      ..forward();
    setState(() {
      _isHovered = false;
      _rotateX = 0;
      _rotateY = 0;
    });
    ref.read(cursorProvider.notifier).setHoverLabel(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projectColor = _getProjectColor();
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      onHover: _onHover,
      cursor: SystemMouseCursors.none,
      child: GestureDetector(
        onTap: () => _showProjectDetailDialog(context, theme, projectColor),
        child: AnimatedBuilder(
          animation: _returnCtrl,
          builder: (context, child) {
            final rx = _isHovered ? _rotateX : _xAnim.value;
            final ry = _isHovered ? _rotateY : _yAnim.value;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(rx)
                ..rotateY(ry),
              alignment: FractionalOffset.center,
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? projectColor.withOpacity(0.6)
                    : Colors.white.withOpacity(isDark ? 0.07 : 0.3),
                width: 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: projectColor.withOpacity(0.25),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Glassmorphism background
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.04)
                            : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  // Card content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(projectColor),
                      _buildInfoSection(theme, projectColor),
                    ],
                  ),
                  // Specular highlight (mouse position glow)
                  if (_isHovered && _cardSize != Size.zero)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment(
                                (_glowPos.dx / _cardSize.width - 0.5) * 2,
                                (_glowPos.dy / _cardSize.height - 0.5) * 2,
                              ),
                              radius: 0.7,
                              colors: [
                                Colors.white.withOpacity(0.07),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getProjectColor() {
    switch (widget.project.id) {
      case '1':
        return const Color(0xFF2196F3);
      case '2':
        return const Color(0xFF4CAF50);
      case '3':
        return const Color(0xFFFF9800);
      case '4':
        return const Color(0xFF9C27B0);
      case '5':
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF54C5F8);
    }
  }

  Widget _buildImageSection(Color projectColor) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.project.imageUrl != null)
              AnimatedScale(
                duration: const Duration(milliseconds: 350),
                scale: _isHovered ? 1.06 : 1.0,
                child: Image.asset(
                  'assets/${widget.project.imageUrl!}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholderImage(projectColor),
                ),
              )
            else
              _buildPlaceholderImage(projectColor),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isHovered ? 1.0 : 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.45),
                child: Center(
                  child: Icon(Icons.open_in_new,
                      color: Colors.white.withOpacity(0.9), size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(ThemeData theme, Color projectColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: projectColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.project.period}  |  ${widget.project.teamSize}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.project.summary,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.technologies
                .take(4)
                .map((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: projectColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: projectColor.withOpacity(0.25), width: 1),
                      ),
                      child: Text(
                        tech,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: projectColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(Color projectColor) {
    return Container(
      color: projectColor.withOpacity(0.1),
      child: Center(
        child: Icon(Icons.image_not_supported_outlined,
            size: 48, color: projectColor.withOpacity(0.4)),
      ),
    );
  }

  void _showProjectDetailDialog(
      BuildContext context, ThemeData theme, Color projectColor) {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Animate(
          effects: [
            FadeEffect(duration: 400.ms, curve: Curves.easeOut),
            ScaleEffect(
              begin: const Offset(0.96, 0.96),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
          ],
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: isMobile
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
                : const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ProjectDetailScreen(projectId: widget.project.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
