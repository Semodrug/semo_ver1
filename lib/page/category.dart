//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:category_list/page/drugListPage.dart';

class CategoryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "카테고리", //카테고리
          style: TextStyle(
            fontWeight: FontWeight.bold, //bold체
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.teal[400],
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () {}
              //onPressed: _search //누르면 search page
              ),
          new IconButton(
              icon: Icon(
                Icons.category,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
              //onPressed: _search //누르면 search page
              )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) =>
            CategoryList(data[index]),
      ),
    );
  }
}

class Category {
  //--- Name Of Drug
  final String name;
  final List<Category> children;

  Category(this.name, [this.children = const <Category>[]]);
}


final List<Category> data = <Category>[
  Category('감기', <Category>[Category('감기약')]),
  Category('소화기계약', <Category>[
    Category('전체'),
    Category('배탈1'),
    Category('소화2'),
    Category('속쓰림3')
  ]),
  Category('해열 진통 소염', <Category>[
    Category('전체'),
    Category('해열제'),
    Category('두통약'),
    Category('관절염약'),
    Category('근육통약'),
    Category('타박상약'),
  ]),
];

class CategoryList extends StatelessWidget {
  const CategoryList(this.category);

  final Category category;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(category);
  }

  Widget _buildTiles(Category root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.name),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Category>(root),
      title: Text(root.name),
      //children: root.children.map<Widget>(_buildTiles).toList(),
      children: root.children
          .map<Widget>(
            _buildTiles,
          )
          .toList(),
    );
  }
}


////도전해본것////
/*
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  //CategoryList({this.firestore});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('category').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData) return const Text('Loading..');
        List<DocumentSnapshot> documents = snapshot.data.documents;
        return ExpansionTileList(
          //firestore: firestore,
          documents: documents,
        );
      },
    );
  }

}

class ExpansionTileList extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final Firestore firestore;

  ExpansionTileList({this.documents, this.firestore});

  List<Widget> _getChildren(){
    List<Widget> children = [];
    documents.forEach((doc) {
      children.add(
        CategoryList(
          name: doc['small1'],
          projectKey: doc.documentID,
          firestore: firestore,
        ),
      );
    });
    return children;
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getChildren(),
    );
  }
}

class CategoryExpansionTile extends StatelessWidget {
  CategoryExpansionTile({this.projectKey, this.name, this.firestore});

  final String projectKey;
  final String name;
  final Firestore firestore;

  @override
  Widget build(BuildContext context) {
    PageStorageKey _projectKey = PageStorageKey('projectKey');

    return ExpansionTile(
      key: _projectKey,
      title: Text(name,
        style: TextStyle(fontSize: 28.0),
      ),
      children: <Widget>[
        StreamBuilder(
          stream: Firestore.instance.collection('category').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return const Text('Load');
            List<DocumentSnapshot> documents = snapshot.data.documents;

            List<Widget> categoryList = [];
            documents.forEach((doc) {
              PageStorageKey _categoryKey = new PageStorageKey('${doc.documentID}');

              categoryList.add(ListTile(
                key: _categoryKey,
                title: Text(doc['small2']),
              ));
            });
            return Column(children: categoryList);
          })
      ],
    );
  }
}
*/
////도전 끝/////