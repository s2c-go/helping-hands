import 'package:flutter/material.dart';
import 'main.dart';
import 'signin.dart';

var cardsList = [
  [
    ItemCard(Icons.local_offer, 'Tsunmai', '23.3', Colors.transparent,
        Colors.transparent, Text("open")),
    ItemCard(Icons.local_offer, 'Floods', '23.3', Colors.transparent,
        Colors.transparent, Text("open")),
    ItemCard(Icons.local_offer, 'Drought', '23.3', Colors.transparent,
        Colors.transparent, Text("open")),
    ItemCard(Icons.local_offer, 'LandSlides', '23.3', Colors.transparent,
        Colors.transparent, Text("open")),
  ],
  [
    ItemCard(Icons.local_offer, 'Socks', '23.3', Colors.transparent,
        Colors.transparent, Text("Adham")),
    ItemCard(Icons.local_offer, 'Socks', '23.3', Colors.transparent,
        Colors.transparent, Text("Adham")),
    ItemCard(Icons.local_offer, 'Socks', '23.3', Colors.transparent,
        Colors.transparent, Text("Adham")),
    ItemCard(Icons.local_offer, 'Socks', '23.3', Colors.transparent,
        Colors.transparent, Text("Adham")),
  ]
];


class BottomSection extends StatefulWidget {
  const BottomSection({
    Key key, 
  }) : super(key: key);

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  Future test() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin(),));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: (MediaQuery.of(context).size.height * 0.22),
            child: PageView(
              physics: BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for (var i = 0; i < cardsList.length; ++i)
                  
                    ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            VerticalDivider(
                              color: Colors.black54,
                              width: 10,
                              endIndent: 5,
                              indent: 5,
                            ),
                        itemCount: cardsList[i].length,
                        itemBuilder: (context, index) => cardsList[i][index]),     
              ],
            )),
        Divider(
          height: 1,
          color: Colors.black54,
          indent: 5,
          endIndent: 5,
        ),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Sign In"),
              color: Colors.transparent,
              onPressed: test,//Navigator.push(context, MaterialPageRoute(builder: (context)=> Signin(),)) ,
            ),
            Spacer(),
            FlatButton(
              child: Text("Help Center"),
              color: Colors.transparent,
            )
          ],
        )
      ],
    );
  }
}
