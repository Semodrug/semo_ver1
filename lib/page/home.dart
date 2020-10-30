import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'phil_info.dart';
import 'home_add_button_stack.dart';

var num = 0;

class HomeDrugPage extends StatefulWidget {
  HomeDrugPage() {}

  @override
  _HomeDrugPageState createState() => _HomeDrugPageState();
}

class _HomeDrugPageState extends State<HomeDrugPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("이약모약", //카테고리에서 가져오기
            style: TextStyle(
              fontWeight: FontWeight.bold, //bold체
              color: Colors.black,
              fontSize: 15,
            )),
        actions: [
          new IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              color: Colors.white,
              onPressed: _search //누르면 search page
              )
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("drug").snapshots(),
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  //container부분에 if문으로 item개수 처리
                  //[index]안에 있는 수를 category별로 다르게 지정해주어야 한다.
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, size: 30),
                        hintText: "어떤 약을 찾고 계세요?",
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
//                        filled: true,
//                        fillColor: Colors.white
                        //contentPadding: EdgeInsets.only(left: 5)
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "나의 상비약",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Text(num.toString()),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: null,
                              child: Text(
                                "편집",
                                style: TextStyle(
                                  color: Colors.teal[400],
                                ),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MyDrugListPage(),
                  ),

                  ButtonTheme(
                    //이게 왜 떠오르고 난리냐 거기 계속 고정하게끔 해두기!!
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
                    minWidth: 340.0,
                    height: 70.0,
                    buttonColor: Colors.grey[300],
                    child: RaisedButton.icon(
                      //color: Colors.transparent,
                      icon: Icon(Icons.add),
                      label: Text("상비약 추가하기"), //
                      onPressed: () {
                        //_dim(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OverlayWithHole()));
                      },
                    ),
                  )
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
              backgroundColor: Colors.teal[400]),
          BottomNavigationBarItem(
              icon: Icon(Icons.linked_camera),
              label: '약 검색', // 이걸 없애면 null이라고 에러가 뜸
              backgroundColor: Colors.teal[400]),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '카테고리',
              backgroundColor: Colors.teal[400]),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

//////////검색 페이지 만들면 이건 없애기///////////////
  _search() => Navigator.of(context).push(
        //검색 페이지로 임의로 이동
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(title: Text("검색어를 입력해 주세요")),
            );
          },
        ),
      );

  void _dim(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Demo'),
          content: Text("Select button you want"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );
  }
///////////////////////새로운 시도/////////////

}

//약 리스트 페이지
class MyDrugListPage extends StatefulWidget {
  @override
  _MyDrugListPageState createState() => _MyDrugListPageState();
}

class _MyDrugListPageState extends State<MyDrugListPage> {

  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot drug = await firestore.collection('drug').getDocuments();

    return drug.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              //return ListView.builder(
              return ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey[20]),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    num = index + 1;
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhilInfoPage(index))),
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        child: Material(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(num.toString())),
                                Container(
                                  child: ClipRRect(
                                    child: Image(
                                        width: 120,
                                        height: 70,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        // image: NetworkImage(snapshot
                                        //     .data[index].data['image'])),
                                        image: NetworkImage(
                                            snapshot.data[index].get('image'))),
                                  ),
                                ),
                                Container(
                                    //color: Colors.white,
                                    //alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(
                                            snapshot.data[index]
                                                .get('ITEM_NAME'),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            _categoryButton((snapshot
                                                .data[index]
                                                .get('category')))
                                            //_categoryButton('hi')
                                          ],
                                        )),
                                        Expanded(
                                          child: Text("2022.08.11"),
                                        )
                                      ],
                                    )),
                              ],
                            )),
                      ),
                    );
                  });
            }
          }),
    );
  }

  Widget _categoryButton(str) {
    return Container(
      width: 24 + str.length.toDouble() * 10,
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        minWidth: 10,
        height: 22,
        child: RaisedButton(
          child: Text(
            '#$str',
            style: TextStyle(color: Colors.teal[400], fontSize: 12.0),
          ),
          //padding: EdgeInsets.all(0),
          onPressed: () => print('$str!'),
          color: Colors.white,
        ),
      ),
    );
  }
}
