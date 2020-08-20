import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카테고리", //카테고리

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
              //onPressed: () {}
              onPressed: (){
                //////////검색 페이지 만들면 이건 없애기///////////////
                Navigator.of(context).push(
                  //검색 페이지로 임의로 이동
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: Text("검색어를 입력해 주세요")),
                      );
                    },
                  ),
                );
              } //누르면 search page
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) => CategoryList(
          data[index],
        ),
      ),
    );
  }



}

class Category {
  //--- Name Of Drug
  final String name;
  final List<Category>
  children;
  Category(this.name, [this.children = const<Category>[]]);
}

final List<Category> data = <Category>[
  Category(
      '대분류1',
      <Category>[
        Category('small1'),
        Category('small2'),
        Category('small3'),
        Category('small4')
      ]
  ),
  Category(
      '대분류2',
      <Category>[
        Category('small1'),
        Category('small2'),
        Category('small3'),
        Category('small4')
      ]
  ),
  Category(
      '대분류3',
      <Category>[
        Category('small1'),
        Category('small2'),
        Category('small3'),
        Category('small4')
      ]
  )
];

class CategoryList extends StatelessWidget {

  const CategoryList(this.category);
  final Category category;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(category);
  }

  Widget _buildTiles(Category root){
    if(root.children.isEmpty){
      return ListTile(
        title: Text(root.name),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Category>(root),
      title: Text(root.name),
      //children: root.children.map<Widget>(_buildTiles).toList(),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

}