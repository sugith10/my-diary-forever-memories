import 'package:flutter/material.dart';

class EmojiPicker extends StatefulWidget {
  final Function(IconData) onEmojiSelected;

  EmojiPicker({required this.onEmojiSelected});

  @override
  _EmojiPickerState createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> {
  IconData? selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 25,),
          Text(
            'How are you feeling?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(
                8,
                (index) {
                  IconData emojiIcon = getEmojiIconForIndex(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmoji = emojiIcon;
                      });
                      widget.onEmojiSelected(emojiIcon);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: emojiIcon == selectedEmoji
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        emojiIcon,
                        size: 40,
                        color: emojiIcon == selectedEmoji
                            ? Colors.white
                            : Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  IconData getEmojiIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.sentiment_very_satisfied;
      case 1:
        return Icons.sentiment_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}
