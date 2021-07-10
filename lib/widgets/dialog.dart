import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class MiruDialog extends StatefulWidget {
  final Text content;

  MiruDialog({required this.content}) : super();

  @override
  State<StatefulWidget> createState() => MiruDialogState();
}

class MiruDialogState extends State<MiruDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: widget.content,
            ),
          ),
        ),
      ),
    );
  }
}