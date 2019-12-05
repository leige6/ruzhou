import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/constant/colours.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}


class _MinePageState extends State<MinePage>  with AutomaticKeepAliveClientMixin{
  Rect _rect;
  @override
  Widget build(BuildContext context) {
    //屏幕的尺寸
    Size size = MediaQuery.of(context).size;
    return new Opacity(
      opacity: 0.3,
      child: CustomPaint(
        size: size,
        painter: CirclePainter(),
      ),
    );


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

class CirclePainter extends CustomPainter{
  Paint _paint;
  double textWidth = 80;
  double textFontSize = 10.0;
  ui.Paragraph paragraph;
  CirclePainter(){
    _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: textFontSize,
        textDirection: TextDirection.ltr,
        maxLines: 2,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
            color: Colours.dark_text, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("六芒星咒符66");

    paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: textWidth));

  }

  @override
  void paint(Canvas canvas, Size size) {
    print("${size.width}  ${size.height}");
   // canvas.translate(0, size.height/2);
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
      double fromX = -width + (index++ % 2) * textWidth;
      for (double positionX = fromX; positionX < width; positionX += textWidth * 2) {
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
