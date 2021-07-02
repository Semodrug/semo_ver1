import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'phil_info.dart';

class HomePage extends StatefulWidget {
  HomePage() {}

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CATEGORY", //카테고리에서 가져오기
            style: TextStyle(
              fontWeight: FontWeight.bold, //bold체
              color: Colors.white,
              fontSize: 15,
            )),
        actions: [
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: _search //누르면 search page
              )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("category").snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                //container부분에 if문으로 item 개수 처리
                //[index]안에 있는 수를 category별로 다르게 지정해주어야 한다.
                Container(
                  //한칸당 3개의 버튼 가질 수 있음
                  width: double.infinity, // match_parent,
                  height: 45,
                  color: Colors.white,
                  child: Row(children: [
                    FlatButton(
                      onPressed: () {},
                      //0부분을 i로 바꿔서 해주면 반복문 돌릴 수 있찌 않을
                      child: Text(snapshot.data.documents[1]['small1']),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Text(snapshot.data.documents[1]['small2']),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Text(snapshot.data.documents[1]['small3']),
                    )
                  ]),
                ),
                Container(
                  width: double.infinity, // match_parent,
                  height: 45,
                  color: Colors.white,
                  child: Row(children: [
                    FlatButton(
                      onPressed: () {},
                      child: Text(snapshot.data.documents[1]['small4']),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Text(snapshot.data.documents[1]['small5']),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Text(snapshot.data.documents[1]['small6']),
                    )
                  ]),
                ),
                Container(
                    width: double.infinity,
                    height: 5.0,
                    color: Colors.grey[200]),
                Container(
                  width: double.infinity, // match_parent,
                  height: 45,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Row(children: [
                    //category안에 num를 나타내는
                    Text("총 # of Drug", style: TextStyle(fontSize: 11)),
                    Spacer(),
                    FlatButton(
                      //이부분이 밑에 expansion tile로 내려와야 하는건
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "높은 평점 순",
                            style: TextStyle(fontSize: 11),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    )
                  ]),
                ),
                Expanded(
                  child: ListPage(),
                )
              ],
            );
          }),
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

//}

///////////////////////새로운 시도/////////////

}

//약 리스트 페이지
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot drug = await firestore.collection('drug').get();

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
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PhilInfoPage(snapshot.data[index].data))),
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        child: Material(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    child: Image(
                                        width: 120,
                                        height: 70,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        image: NetworkImage(snapshot
                                            .data[index].data['image'])),
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
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index]
                                                  .data['ENTP_NAME'],
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Row(children: [
                                          Text(
                                            snapshot
                                                .data[index].data['ITEM_NAME'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                        Row(
                                            //mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '별점 모양 /',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                '총 별점의 평균 /',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                '(${snapshot.data[index].data['review']}개)',
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            _categoryButton((snapshot
                                                .data[index].data['category']))
                                            //_categoryButton('hi')
                                          ],
                                        ))
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
}

////////////////////////////////////////////////
/*
  getHomePageBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('drug').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
        //return _getItemUI(context, snapshot.map(da);


      },
    );
  }
*/
//원래 코드 연동 되기 전 drug data가져오는 코드
/*getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allDrugs.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
    );
  }*/
/*
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _getItemUI(context, data)).toList(),
    );
  }

  Widget _getItemUI(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return new Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
        child: new Column(
          children: [
            new ListTile(
              /*leading: new Image.asset(
                "images/" + record.small1,
                //fit: BoxFit.cover,
                width: 100.0,
                height: 150.0,
              ),*/
              title: new Text(
                record.itemName,
                style: new TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(record.company,
                        style: new TextStyle(
                            fontSize: 9.0, fontWeight: FontWeight.bold)),
                    /*Container(
                      //별점 아이콘
                      //height: 30,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            //별점 받아오기 별점이 4.0이면 4개 yellow 한개 grey //아이콘 위젯을 불러오는건 어떤가
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Icon(
                            //별점 받아오기 별점이 4.0이면 4개 yellow 한개 grey //아이콘 위젯을 불러오는건 어떤가
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Icon(
                            //별점 받아오기 별점이 4.0이면 4개 yellow 한개 grey //아이콘 위젯을 불러오는건 어떤가
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Icon(
                            //별점 받아오기 별점이 4.0이면 4개 yellow 한개 grey //아이콘 위젯을 불러오는건 어떤가
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Icon(
                            //별점 받아오기 별점이 4.0이면 4개 yellow 한개 grey //아이콘 위젯을 불러오는건 어떤가
                            Icons.star,
                            color: Colors.grey[100],
                            size: 15,
                          ),
                          new Text(' ${_allDrugs[index].evaluation}  ',
                              style: new TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold)),
                          // if(_allDrugs[index].num > 0){
                          new Text('($review개)',
                              style: new TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal))
                          //}
                        ],
                      ),
                    ),*/
                    /*Container(
                      //hashtag button 누르면 그 카테고리로 넘어가기
                      child: Row(
                        children: <Widget>[
                          new MaterialButton(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 3),
                            height: 25.0,
                            minWidth: 50.0,
                            color: Colors.white,
                            textColor: Colors.tealAccent,
                            child: new Text('#${_allDrugs[index].hashtag}',
                                style: new TextStyle(
                                    color: Colors.teal[400],
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal)),
                            onPressed: () => {},
                            splashColor: Colors.tealAccent,
                          ),
                        ],
                      ),
                    )*/
                  ]),
              onTap: () {
                //() => 함,
                print("Container clicked");
              },
            )
          ],
        ),
      ),
    );
  }
}
*/

/*
class Record {
  final String itemName;
  final String company;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['ITEM_NAME'] != null),
        assert(map['ENTP_NAME'] != null),
        itemName = map['ITEM_NAME'],
        company = map['ENTP_NAME'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

//@override
//String toString() => "Record<$name:$votes>";
}

*/
