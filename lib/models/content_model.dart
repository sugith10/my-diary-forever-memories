class OnbordingContent {
  String title;
  String discription;
  OnbordingContent({required this.title, required this.discription});
}

class OnboardingContentList {
List<OnbordingContent> contents = [
  OnbordingContent(
      title: 'Write Down Your Journey',
      discription: "Discover the power of "
          "documenting your thoughts, "
          "memories, and experiences in a"
          "private and secure digital diary."),
  OnbordingContent(
      title: 'Craft Your Digital Journal',
      discription: "Our app is here to help you"
          "unleash your inner storyteller and"
          "keep your life's precious moments"
          "at your fingertips."),
  OnbordingContent(
      title: 'Stay Organized',
      discription: "Effortlessly organize your entries,"
          "revisit the past, and gain insights"
          "into your life's journey."),
];
}
