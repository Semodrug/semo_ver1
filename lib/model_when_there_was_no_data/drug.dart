///DocumentSnapshot가 원래는 Drug

class Drug {
  //--- Name Of Drug
  final String name;
  //-- image
  final String image;
  //--- population
  final String evaluation;
  //--- country
  final String company;
  //--- review
  final String review;
  //--- menu
  final String hashtag; //여러개일수도 있는데 어떻게 처리해야할까

  final int num;

  Drug(
      {this.name,
        this.company,
        this.evaluation,
        this.review,
        this.image,
        this.hashtag,
        this.num});

  static List<Drug> allDrugs() {
    var lstOfDrug = new List<Drug>();
    lstOfDrug.add(new Drug(
        name: "타이레놀",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "01.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "이지엔",
        company: "대용제약",
        evaluation: "4.0 ",
        review: '360',
        image: "02.png",
        hashtag: "두통1",
        num: 1));
    lstOfDrug.add(new Drug(
        name: "탁센",
        company: "녹십자",
        evaluation: "4.0 ",
        review: '360',
        image: "03.png",
        hashtag: "치통11",
        num: 1));
    lstOfDrug.add(new Drug(
        name: "게보린",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "01.png",
        hashtag: "근육통12",
        num: 1));
    lstOfDrug.add(new Drug(
        name: "그날엔",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "02.png",
        hashtag: "생리통1",
        num: 1));
    lstOfDrug.add(new Drug(
        name: "허허허",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "03.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "타이레놀",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "01.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "이지엔",
        company: "대용제약",
        evaluation: "4.0 ",
        review: '360',
        image: "02.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "탁센",
        company: "녹십자",
        evaluation: "4.0 ",
        review: '360',
        image: "03.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "게보린",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "01.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "그날엔",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "02.png",
        hashtag: "생리통1",
        num: 300000));
    lstOfDrug.add(new Drug(
        name: "허허허",
        company: "동아제약",
        evaluation: "4.0 ",
        review: '360',
        image: "03.png",
        hashtag: "생리통1",
        num: 300000));

    return lstOfDrug;
  }
}
