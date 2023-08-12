class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Explore a store that contains everything you want",
    image: "assets/images/logo4.png",
    desc: "Remember everything you need with a click you can get it",
  ),
  OnboardingContents(
    title: "Clothes, food, pets, everything you need ",
    image: "assets/images/image2.png",
    desc:
        "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnboardingContents(
    title: "Discounts and prices you have not seen before ",
    image: "assets/images/image3.png",
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
