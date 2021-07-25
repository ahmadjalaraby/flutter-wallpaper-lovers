import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class DetailButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onTap;
  final bool isApply;

  const DetailButton({
    Key? key,
    required this.icon,
    required this.name,
    required this.onTap,
    this.isApply = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.fromLTRB(0.0, 80.0, 20.0, 0.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              color: isApply
                  ? Colors.blueAccent[700]
                  : DynamicTheme.of(context)!.themeId == 2
                      ? Colors.grey[700]
                      : Colors.white.withOpacity(0.517874),
              // Colors.white.withOpacity(0.517874)
            ),
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 15.0,
              color: DynamicTheme.of(context)!.themeId == 2
                  ? Colors.grey[400]
                  : Colors.white,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
