import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/constant/colours.dart';

class WaterMark extends StatelessWidget {

  const WaterMark({
    Key key,
    @required this.waterText,
    this.textFontSize=10.0,
    this.opacity=1,
    this.textWidth=80
  }): super(key: key);

  final double opacity; //透明度，0.0 到 1.0，0.0表示完全透明，1.0表示完全不透明
  final String waterText;
  final double textFontSize;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    //屏幕的尺寸
    Size size = MediaQuery.of(context).size;
    return new Opacity(
      opacity: opacity,
      child: CustomPaint(
        size: size,
        painter: CirclePainter(textWidth,waterText,textFontSize),
      ),
    );
  }
}

class CirclePainter extends CustomPainter{
  Paint _paint;
  String _waterText;
  double _textWidth;
  double _textFontSize;
  ui.Paragraph paragraph;
  CirclePainter(double textWidth,String waterText,double textFontSize){
    _paint = Paint();
    _textWidth=textWidth;
    _waterText=waterText;
    _textFontSize=textFontSize;
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: _textFontSize,
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '...',
      ),
    )
      ..pushStyle(
        ui.TextStyle(
            color: Colours.dark_text, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(_waterText);

    paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: textWidth));

  }

  @override
  void paint(Canvas canvas, Size size) {
    print("${size.width}  ${size.height}");
     //canvas.translate(0, 0);
    /*
    * 绘制文字有2种方式
    * 1.继承构造TextPainter，通过其的paint来绘制
    * */
    double width = size.width;
    double height = size.height;
    canvas.save();
    canvas.drawColor(Colours.bg_color, BlendMode.src);
    canvas.rotate((-5 * pi) / 180);
    int index = 0;
    for (double positionY = height / 10; positionY <= height; positionY += height / 18) {
      double fromX = -width + (index++ % 2) * _textWidth;
      for (double positionX = fromX; positionX < width; positionX += _textWidth * 2) {
        canvas.drawParagraph(paragraph, Offset(positionX,positionY));
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
