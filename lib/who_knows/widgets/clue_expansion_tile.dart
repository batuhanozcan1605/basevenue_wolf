import 'package:basevenue_wolf/who_knows/consts.dart';
import 'package:flutter/material.dart';
import '../color_palette.dart';
import 'custom_button.dart';

class ClueExpansionTile extends StatelessWidget {
  final String title;
  final String clue;
  final String? hint;

  const ClueExpansionTile({
    super.key,
    required this.title,
    required this.clue,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2), // Orange border
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes default divider
          splashColor: Colors.transparent, // Removes splash effect
        ),
        child: ExpansionTile(
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ColorPalette.orange,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: EdgeInsets.all(16),
          iconColor: Colors.orange,
          collapsedIconColor: Colors.orange,
          children: [
            Text(
              clue,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            CustomButton(
              imagePath: yellowButtonPath,
              text: 'UNLOCK HINT',
              textColor: Colors.black,
            ),
            if (hint != null) ...[
              SizedBox(height: 12),
              Text(
                hint!,
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
