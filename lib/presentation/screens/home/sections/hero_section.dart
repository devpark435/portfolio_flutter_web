import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../widgets/section_wrapper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textStyle = width > 800
        ? Theme.of(context).textTheme.displaySmall
        : Theme.of(context).textTheme.headlineMedium;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withAlpha(25),
            Theme.of(context).primaryColor.withAlpha(50),
          ],
        ),
      ),
      child: Stack(
        children: [
          // 기존 콘텐츠
          SectionWrapper(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '안녕하세요,',
                      style: textStyle,
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: width > 800 ? width * 0.8 : width * 0.9,
                      ),
                      child: DefaultTextStyle(
                        style: textStyle!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '문제 해결에 집중하는 개발자',
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '박현렬입니다',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 아래 화살표 추가 (클릭 불가능한 단순 표시)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    '더 알아보기',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _BouncingArrow(color: Theme.of(context).primaryColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 바운싱 애니메이션을 위한 별도 위젯
class _BouncingArrow extends StatefulWidget {
  final Color color;

  const _BouncingArrow({required this.color});

  @override
  _BouncingArrowState createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: widget.color,
            size: 36,
          ),
        );
      },
    );
  }
}
