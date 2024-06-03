import 'package:flutter/material.dart';

class SlashPainter extends CustomPainter {
  final TextPainter textPainter;
  final TextStyle textStyle;

  SlashPainter(this.textPainter, this.textStyle);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Garis miring berwarna merah
      ..strokeWidth = 2;

    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;

    textPainter.paint(canvas, Offset.zero);

    canvas.drawLine(
      Offset(0, textHeight / 2),
      Offset(textWidth, textHeight / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SlashedText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const SlashedText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextSpan span = TextSpan(text: text, style: style);
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    return CustomPaint(
      size: Size(tp.width, tp.height),
      painter: SlashPainter(tp, style),
    );
  }
}
