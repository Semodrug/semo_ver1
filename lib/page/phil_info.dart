import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:category_list/Review/MyHomePage.dart';
import 'package:category_list/page/see_more.dart';
import 'package:category_list/page/expiration.dart';

// 타이레놀 seq_num: 199303108
// 이지엔 seq_num: 200400463

class PhilInfoPage extends StatefulWidget {
  int idx;
  PhilInfoPage(this.idx);
  // Stream data; //dan
  // PhilInfoPage(data); // 이거만들었

  @override
  _PhilInfoPageState createState() => _PhilInfoPageState(idx);
}

class _PhilInfoPageState extends State<PhilInfoPage> {
  final fireInstance = FirebaseFirestore.instance;

  int idx;
  _PhilInfoPageState(this.idx); //dan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '약정보',
            style: TextStyle(
                color: Colors.black, letterSpacing: 2.0, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1.0,
//          leading: Icon(
//            Icons.arrow_back,
//            color: Colors.teal[400],
//          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {},
              color: Colors.teal[400],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: _topInfo(context),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: 10.0,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
            ),
            /* FROM HERE: TAB */
            SliverToBoxAdapter(
              child: _myTab(),
            )
          ],
        ));
  }

  /* 약 이름, 회사 등 위쪽에 위치한 정보들 */
  Widget _topInfo(context) {
    Stream drugStream = fireInstance.collection('drug').snapshots();

    return StreamBuilder(
        stream: drugStream,
        builder: (context, snapshot) {
          int itemSeq = snapshot.data.documents[0]['ITEM_SEQ'];

          return Stack(children: [
            Positioned(
              top: 0,
              right: 0,
              child: _warningButton(context),
            ),
            Positioned(
              bottom: 70,
              right: 0,
              child: _favoriteButton(context, itemSeq),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _addButton(context, itemSeq),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: SizedBox(
                      child: Image.asset('images/01.png'),
                      width: 200.0,
                      height: 100.0,
                    ),
                  ),
                  Text(
                    snapshot.data.documents[idx]['ENTP_NAME'],
                    //'동아제약',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    snapshot.data.documents[idx]['ITEM_NAME'],
//                  '타이레놀',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(children: <Widget>[
                    Text(
                      '4.5',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' (305개)',
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ]),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    _categoryButton('두통'),
                    _categoryButton('치통'),
                    _categoryButton('생리통'),
                  ]),
                ]),
          ]);
        });
  }

  /* warning button */
  Widget _warningButton(context) {
    void _showWarning(context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: new Text(
              "질병주의",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal[400]),
            ),
            content: new Text("신장질환이 있는 환자는 반드시 의사와 상의할 것"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "닫기",
                  style: TextStyle(color: Colors.teal[200]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return IconButton(
      padding: EdgeInsets.all(2.0),
      icon: Icon(
        Icons.announcement,
        color: Colors.amber[700],
      ),
      onPressed: () => _showWarning(context),
    );
  }

  /* category button */
  Widget _categoryButton(str) {
    return Container(
      width: 24 + str.length.toDouble() * 10,
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        minWidth: 10,
        height: 22,
        child: FlatButton(
          child: Text(
            '#$str',
            style: TextStyle(color: Colors.teal[400], fontSize: 12.0),
          ),
          //padding: EdgeInsets.all(0),
          onPressed: () => print('$str!'),
          color: Colors.grey[200],
        ),
      ),
    );
  }

  /* add button - when pressed, toggle on favoriteList */
  /* ask? */
  Widget _addButton(context, itemSeq) {
    itemSeq = itemSeq.toString();

    CollectionReference savedList =
        fireInstance.collection('users/1/savedList');

    /* using query - needed when we use document named randomly */
    // Future<void> addToSaved(item_seq) {
    //   int expiration = 99991231; //for test
    //   return savedList
    //       .add({
    //         'ITEM_SEQ': item_seq,
    //         'expiration': expiration,
    //       })
    //       .then((value) => print("Saved list Added"))
    //       .catchError((error) => print("Failed to add saved list: $error"));
    // }

    // Future<int> isSaved(item_seq) async {
    //   return await savedList
    //       .where('ITEM_SEQ', isEqualTo: item_seq)
    //       .get()
    //       .then((QuerySnapshot) {
    //     if (QuerySnapshot.size == 0) {
    //       addToSaved(item_seq);
    //     }
    //   });
    // }

    Future<bool> isSaved() async {
      bool saved;
      await savedList.doc(itemSeq).get().then((docSnapshot) async {
        saved = docSnapshot.exists;
      });
      return saved;
    }

    void _notify(context, str1, str2, str3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Icon(
              Icons.check_circle_outline,
              color: Colors.teal[300],
              size: 40,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  str1,
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  str2,
                  // textAlign: TextAlign.center
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                  child: Text(
                    str3,
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    // TODO: 유통기한 입력하는 것 구현하기
    Future<void> addToSaved() {
      int expiration = 99991231; //for test
      return savedList.doc(itemSeq).set({
        'ITEM_SEQ': itemSeq,
        'expiration': expiration,
      }).then((value) {
        print("Succeed to add");
        _notify(context, '나의 상비약', '에 추가되었습니다.', '홈에서 확인하실 수 있습니다.');
      }).catchError((error) => print("Failed to add: $error"));
    }

    Future<void> deleteFromSaved() {
      return savedList.doc(itemSeq).delete().then((value) {
        print("Succeed to delete");
        _notify(context, '나의 상비약', '에서 삭제되었습니다.', '확인');
      }).catchError((error) => print("Failed to delete: $error"));
    }

    return ButtonTheme(
      minWidth: 20,
      height: 30,
      child: FlatButton(
          color: Colors.teal[300],
          child: Text(
            '+ 담기',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            print('보관함 추가!');
            print(await isSaved());
            await isSaved() ? deleteFromSaved() : addToSaved();
          }),
    );
  }

  /* favorite button - when pressed, toggle on favoriteList */
  Widget _favoriteButton(context, itemSeq) {
    itemSeq = itemSeq.toString();

    CollectionReference savedList =
        fireInstance.collection('users/1/favoriteList');

    void _notify(context, str1, str2, str3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Icon(
              Icons.check_circle_outline,
              color: Colors.teal[300],
              size: 40,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  str1,
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  str2,
                  // textAlign: TextAlign.center
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                  child: Text(
                    str3,
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    Future<bool> isFavorite() async {
      bool saved;
      await savedList.doc(itemSeq).get().then((docSnapshot) async {
        saved = docSnapshot.exists;
      });
      return saved;
    }

    Future<void> addToFavorite() {
      int expiration = 99991231; //for test
      return savedList.doc(itemSeq).set({
        'ITEM_SEQ': itemSeq,
      }).then((value) {
        print("Succeed to add");
        _notify(context, '찜 목록', '에 추가되었습니다.', '마이페이지에서 확인하실 수 있습니다.');
      }).catchError((error) => print("Failed to add: $error"));
    }

    Future<void> deleteFromFavorite() {
      return savedList.doc(itemSeq).delete().then((value) {
        print("Succeed to delete");
        _notify(context, '찜 목록', '에서 삭제되었습니다.', '확인');
      }).catchError((error) => print("Failed to delete: $error"));
    }

    return IconButton(
      padding: EdgeInsets.all(2.0),
      icon: Icon(
        Icons.favorite_border,
        color: null,
        // await isFavorite() ? Icons.favorite : Icons.favorite_border,
        // color: await isFavorite() ? Colors.redAccent : null,
      ),
      onPressed: () async {
        print(await isFavorite());
        await isFavorite() ? deleteFromFavorite() : addToFavorite();
      },
    );
  }

  /* tab bar */
  Widget _myTab() {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w100),
              tabs: [
                Tab(child: Text('약 정보', style: TextStyle(color: Colors.black))),
                Tab(child: Text('리뷰', style: TextStyle(color: Colors.black))),
              ],
              indicatorColor: Colors.teal[400],
            ),
            Container(
              padding: EdgeInsets.all(0.0),
              width: double.infinity,
              height: 500.0,
              child: TabBarView(
                // TODO: 여기에 은영학우님 review page 넣기
                children: [_specificInfo(), MyHomePage()],
              ),
            )
          ],
        ));
  }

  /* tab bar에 들어가는 자세한 정보들 */
  Widget _specificInfo() {
    return StreamBuilder(
        stream: fireInstance
            .collection('/drug/OYzMN1wz5WGmkmd1I8p2/DOCS')
            .snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "효능효과",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data.documents[0]['title'][0],
                  ),
                  Text(
                    snapshot.data.documents[0]['paragraph'][0],
                  ),
                  Text(
                    snapshot.data.documents[0]['title'][1],
                  ),
                  Text(
                    snapshot.data.documents[0]['paragraph'][1],
                  ),
                  SizedBox(
                    child: Divider(color: Colors.grey),
                  ),
                  Text(
                    "용법용량",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //for(i = 0; i < snapshot.data.documents[2]['paragraph'].toList().length; i++)

                  Text(
                    snapshot.data.documents[2]['paragraph'][0],
                  ),
                  Text(
                    snapshot.data.documents[2]['paragraph'][1],
                  ),
                  Text(
                    snapshot.data.documents[2]['paragraph'][2],
                  ),
                  Text(
                    snapshot.data.documents[2]['paragraph'][3],
                  ),
                  SizedBox(
                    child: Divider(color: Colors.grey),
                  ),
                  Text(
                    "복약정보",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "- 충분한 물과 함께 투여하세요.\n- 정기적으로 술을 마시는 사람은 이 약을 투여하기 전 반드시 전문가와 상의하세요",
                  ),
                  Text(
                    "- 황달 등 간기능 이상징후가 나타날 경우에는 전문가와 상의하세요.\n- 전문가와 상의없이 다른 소염진통제와 병용하지 마세요.",
                  ),
                  ButtonTheme(
                    minWidth: 20,
                    height: 30,
                    child: FlatButton(
                      color: Colors.teal[300],
                      child: Text(
                        '자세히보기',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeeMorePage()),
                      ),
                    ),
                  ),
                ]),
          );
        });
  }
}
