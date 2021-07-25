
import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class InformationTile extends StatelessWidget {
  final String content;
  final String name;

  const InformationTile({Key? key, required this.content, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.20;
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              width: tileSize,
              height: tileSize,
              padding: EdgeInsets.all(8.0),
              child: Text(
                content,
                style: themeData.textTheme.headline3,
              )),
          SizedBox(height: 15),
          Text(
            name,
            style: themeData.textTheme.headline6,
          )
        ],
      ),
    );
  }
}