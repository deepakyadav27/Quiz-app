import 'package:flutter/material.dart';
import 'package:green_book/Utils/SizeConfig.dart';
import 'package:green_book/Utils/Utils.dart';
import 'package:green_book/api.dart';
import 'package:green_book/helper/UIHelper.dart';
import 'package:green_book/models/CategoryModel.dart';
import 'package:green_book/screens/QuizScreen.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List<CategoryModel> categoryList = [];
  @override
  void initState() {
    super.initState();
    API().fetchImageUrl().then((value) {
      value.forEach((category) {
        CategoryModel categoryModel = new CategoryModel();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.apiLink = category['apilink'];
        categoryModel.imageUrl = category['img'];

        setState(() {
          categoryList.add(categoryModel);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: UIHelper.getAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Available Quiz"),
            ListView.builder(
              itemCount: categoryList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal * 4,
                    vertical: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(categoryList[index]),
                        ),
                      );
                    },
                    tileColor: Utils.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    leading: Image.network(categoryList[index].imageUrl!),
                    title: Text(categoryList[index].name!),
                    isThreeLine: true,
                    subtitle: Text("Difficulty:Basic \n 100/25,000+ Questions"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 3),
        child: UIHelper.getBottomText(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 44,
        width: SizeConfig.screenWidth * 2 / 3,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text(
            "Instant Quiz",
            style: TextStyle(
              color: Utils.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          backgroundColor: Utils.lightGreen,
        ),
      ),
    );
  }
}
