import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:category_list/Review/MyHomePage.dart';
import 'package:category_list/page/see_more.dart';

/* data 얻는 샘플 코드 - 참고용*/
//  void getData() {
//    fireInstance.collection("user").getDocs().then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });
//  }

class PhilInfoPage extends StatefulWidget {
  @override
  _PhilInfoPageState createState() => _PhilInfoPageState();
}

class _PhilInfoPageState extends State<PhilInfoPage> {
  final fireInstance = Firestore.instance;

  //var favoriteList;
  //List<String> favoriteList = [];

/* 약 이름, 회사 등 위쪽에 위치한 정보들 */
  Widget _topInfo(context) {
    Stream drugStream = fireInstance.collection('drug').snapshots();
    Stream savedListStream = fireInstance
        .collection('user')
        .document('1')
        .collection('savedList')
        .snapshots();

    return StreamBuilder(
        stream: drugStream,
        builder: (context, snapshot) {
          return Stack(children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  padding: EdgeInsets.all(2.0),
                  icon: Icon(
                    Icons.announcement,
                    color: Colors.amber[700],
                  ),
                  onPressed: () => _showWarning(context)),
            ),

            Positioned(
                bottom: 70,
                right: 0,
                child: IconButton(
                  padding: EdgeInsets.all(2.0),
                  icon: Icon(
                    Icons.favorite_border,
                    //alreadySaved ? Icons.favorite : Icons.favorite_border,
                    //              //color: alreadySaved ? Colors.redAccent : null,
                  ),
                  onPressed: () => print('보관함 추가!'),
                  // onPressed: () async => {
                  // ref.updateData({
                  //   favoriteList: FieldValue.arrayUnion(snapshot.data.documents[0]['ITEM_SEQ'])
                  // });

                  //}
                )),

            /*
                Firestore.instance.
                    .collection('friendships')
                    .document(caller.data["uid"])
                    .updateData({
                  friends: FieldValue.arrayUnion({
                    friendDisplayName: snapshot.data["friendDisplayName"],
                    friendUid: snapshot.ref
                  })
                });
                */

            // TO DO: press 했을 때 collection에 list를 만들어 seq_num 을 저장한다 !!

            // way 1)
            // 1. DB에서 favoritelist를 불러와서,
            // 2. 거기다가 원하는 약의 seq num을 add/delete 후
            // 3. list에 updata나 add를 통해서 넣는다
            // List<String> favoriteList = ;

            // void createRecode(Map<String, dynamic> data) async {
            // setState(() {
            // isPressed[index] = !isPressed[index];
            // isPressed[index]
            // ? disease_list.add(buttonName)
            //     : disease_list.remove(buttonName);
            // });

            // createRecode('disease_list': favoriteList)
            // })),

            // await fireInstance.collection('users').document('1').updateData(data);

            // way 2) 바로 document의 favoriteList에 접근해서 add/delete 해준다

            Positioned(
              bottom: 0,
              right: 0,
              child: ButtonTheme(
                minWidth: 20,
                height: 30,
                child: FlatButton(
                  color: Colors.teal[300],
                  child: Text(
                    '+ 담기',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => print('보관함 추가!'),
                ),
              ),
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
                    snapshot.data.documents[0]['ENTP_NAME'],
                    //'동아제약',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    snapshot.data.documents[0]['ITEM_NAME'],
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

/* warning */
  void _showWarning(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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

/* 카테고리전용 button*/
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

/* tab 구현 */
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
                /* 여기에 은영학우님 page 넣기! */
                children: [_specificInfo(), MyHomePage()],
              ),
            )
          ],
        ));
  }

/* 약의 자세한 정보들 */
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
}

/* CRUD 참고 코드
/// Firestore CRUD Logic

// 문서 생성 (Create)
void createDoc(String name, String description) {
  Firestore.instance.collection(colName).add({
    fnName: name,
    fnDescription: description,
    fnDatetime: Timestamp.now(),
  });
}

// 문서 조회 (Read)
void showDocument(String documentID) {
  Firestore.instance
      .collection(colName)
      .document(documentID)
      .get()
      .then((doc) {
    showReadDocSnackBar(doc);
  });
}

// 문서 갱신 (Update)
void updateDoc(String docID, String name, String description) {
  Firestore.instance.collection(colName).document(docID).updateData({
    fnName: name,
    fnDescription: description,
  });
}

// 문서 삭제 (Delete)
void deleteDoc(String docID) {
  Firestore.instance.collection(colName).document(docID).delete();
}

void showCreateDocDialog() {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Create New Document"),
        content: Container(
          height: 200,
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: "Name"),
                controller: _newNameCon,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                controller: _newDescCon,
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              _newNameCon.clear();
              _newDescCon.clear();
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Create"),
            onPressed: () {
              if (_newDescCon.text.isNotEmpty &&
                  _newNameCon.text.isNotEmpty) {
                createDoc(_newNameCon.text, _newDescCon.text);
              }
              _newNameCon.clear();
              _newDescCon.clear();
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

void showReadDocSnackBar(DocumentSnapshot doc) {
  _scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepOrangeAccent,
        duration: Duration(seconds: 5),
        content: Text(
            "$fnName: ${doc[fnName]}\n$fnDescription: ${doc[fnDescription]}"
                "\n$fnDatetime: ${timestampToStrDateTime(doc[fnDatetime])}"),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
}

void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
  _undNameCon.text = doc[fnName];
  _undDescCon.text = doc[fnDescription];
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Update/Delete Document"),
        content: Container(
          height: 200,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Name"),
                controller: _undNameCon,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                controller: _undDescCon,
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              _undNameCon.clear();
              _undDescCon.clear();
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Update"),
            onPressed: () {
              if (_undNameCon.text.isNotEmpty &&
                  _undDescCon.text.isNotEmpty) {
                updateDoc(doc.documentID, _undNameCon.text, _undDescCon.text);
              }
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Delete"),
            onPressed: () {
              deleteDoc(doc.documentID);
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

String timestampToStrDateTime(Timestamp ts) {
  return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
      .toString();
}
}

*/
