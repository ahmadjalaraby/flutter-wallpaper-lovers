import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class DescriptionInfo extends StatelessWidget {
  const DescriptionInfo({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            decoration: BoxDecoration(
              color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[700]
                            : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 3.0),
                    Expanded(
                      child: Text(
                        data,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        //softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
