import 'package:flutter/material.dart';

class CardRotulo extends StatelessWidget {
  final String leading;
  final String? trailing;

  const CardRotulo({
    Key? key,
    required this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          color: Theme.of(context).colorScheme.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            leading,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          trailing != null
              ? Text(
                  trailing!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
