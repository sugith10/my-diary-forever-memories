class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Write Down Your Journey',
    image: 'images/oval-one.png',
    discription: "Discover the power of "
    "documenting your thoughts, "
    "memories, and experiences in a"
    "private and secure digital diary."
  ),
  UnbordingContent(
    title: 'Craft your digital Journal',
    image: 'images/oval-two.png',
    discription: "Our app is here to help you"
    "unleash your inner storyteller and"
    "keep your life's precious moments"
    "at your fingertips."
  ),
  UnbordingContent(
    title: 'Stay Organized',
    image: 'images/oval-three.png',
    discription: "Effortlessly organize your entries,"
    "revisit the past, and gain insights"
    "into your life's journey."
  ),
];