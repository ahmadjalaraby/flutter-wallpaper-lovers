import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class DetailInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  final VoidCallback onTap;

  const DetailInfoItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(7.0, 10.0, 7.0, 10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[700]
                            : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.white
                            : Colors.black,
                size: 21.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[150]
                            : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 10.0),
              Text(
                data,
                style: TextStyle(
                  fontSize: 18.0,
                  color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[150]
                            : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Raleway',
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
