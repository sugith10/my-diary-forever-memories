import 'package:flutter/material.dart';

class EmojiPicker extends StatefulWidget {
  final Function(IconData) onEmojiSelected;

  const EmojiPicker({super.key, required this.onEmojiSelected, required TextEditingController textEditingController});

  @override
  _EmojiPickerState createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> {
  IconData? selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return 
       Column(
        children: [
          const SizedBox(height: 25,),
          const Text(
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
                      padding: const EdgeInsets.all(10),
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
            child: const Text('Save'),
          ),
        ],
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
