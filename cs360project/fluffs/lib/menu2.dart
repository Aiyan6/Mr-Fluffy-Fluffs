import 'package:flutter/material.dart';
import 'package:mr_fluffy_fluffs/Data/addons.dart';
import 'package:mr_fluffy_fluffs/cart_1.dart';
import 'package:mr_fluffy_fluffs/extra.dart';


// The Main class for Menu Two that gets the data from the previous Menu Screen
// This uses a List View (Scrollable) inside a Scaffold and then uses multiple Row and Column Widgets to hold the the elements in their palce

class MenuTwo extends StatefulWidget { 

  final img, name, subtitle, price;
  const MenuTwo({ Key key, this.img, this.name, this.subtitle, this.price}): super(key: key);

  @override
  _MenuTwoState createState() => _MenuTwoState();
}

class _MenuTwoState extends State<MenuTwo> {

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    

    return StreamBuilder(
      initialData: {"img" : widget.img, "name": widget.name, "subtitle": widget.subtitle, "price" : widget.price},
      stream: bloc.getStream,
      builder: (context, snapshot) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView (
        shrinkWrap: true,
        primary: false,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: blockHeight * 2.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      icon: Icon(Icons.keyboard_arrow_left),
                      color: Colors.red[400],
                    ),
                    IconButton(
                      onPressed: () {
                        if (bloc.allItems.isNotEmpty) 
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => Cart(),
                            ),
                          );
                      },
                      icon: Stack(

                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          // For Notification Bar 
                          if (bloc.allItems.length > 0)
                          Padding(
                            padding: EdgeInsets.only(left: blockWidth * 0.2),
                            child: CircleAvatar(
                              radius: blockWidth * 2,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                (bloc.allItems[bloc.allItems.length-1]['quan'] + bloc.allItems[bloc.allItems.length-1]['number']).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: blockWidth * 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.red[200],
                    ),
                  ],
                ),
              ),
              Container(
            // From the Left and Right of Container + A bit from Bottom
                padding: EdgeInsets.fromLTRB(blockWidth* 1.5, 0, blockHeight * 2, blockWidth * 2),
                child: Column (
                  children: <Widget>[            
                    SizedBox(height: blockWidth * 1.4),
                      SettingMenuTwoCards(
                        img: widget.img,
                        name: widget.name,
                        subtitle: widget.subtitle,
                        price: widget.price,
                      ),
                  ],
                ),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                Container(
                  padding: EdgeInsets.only(left: blockWidth * 1), 
                    child: Text(
                    "Extra Toppings",
                    style: TextStyle(
                      fontSize: blockWidth * 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[400],
                      fontFamily: "NunitoSans-SemiBold"
                    ),
                  ),
                ),
              ],
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget> [
//                Container(
//                  padding: EdgeInsets.only(left: blockWidth * 1),
//                    child: Text(AAAAAAAAA
//                    "Select upto 4",
//                    style: TextStyle(
//                      fontSize: blockWidth * 3,
//                      color: Colors.brown[400],
//                    ),
//                  ),
//                ),
//              ],
//            ),
            Column(
              children: <Widget>[
                ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: addons == null ? 0 :addons.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map addon = addons[index];
                        return AddonMenu(
                          name: addon['name'],
                          price: addon['price'],
                        );

                      },
                ),
              ],
            ),
            SizedBox(height: blockHeight * 1.5),
            ],
          ),
         bottomNavigationBar: BottomBar(name: widget.name, price: widget.price, img: widget.img),         
      );
      }
    );
  }
}


// This Addon is for adding addon names and checkboxess along with their prices with them

class AddonMenu extends StatefulWidget {
  final String name;
  final int price;

  AddonMenu({Key key, this.name, this.price}) : super(key: key);

  @override
  _AddonMenuState createState() => _AddonMenuState();
}

class _AddonMenuState extends State<AddonMenu> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: blockWidth* 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: blockWidth* 1),
                    child: CheckBoxes(name: widget.name, price: widget.price),
                  ),
                  SizedBox(width: blockWidth* 2),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: blockWidth* 4,
                      color: Colors.brown[300],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.brown[200],
                    size: blockWidth* 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: blockWidth* 3),
                    child: Text(
                      "Rs ${widget.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: blockWidth* 3,
                        color: Colors.brown[400],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// This Class Creates the Checkboxes that are used in Addons

class CheckBoxes extends StatefulWidget {

  final String name;
  final int price;

  CheckBoxes({Key key, this.name, this.price}) : super(key: key);

  @override
  _CheckBoxesState createState() => _CheckBoxesState();
}

class _CheckBoxesState extends State<CheckBoxes> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;

    return Material(
      child: ClipOval(
        child: SizedBox(
          width: Checkbox.width + (blockWidth),
          height: Checkbox.width + (blockWidth),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _value = !_value;
                if (_value == true) {
                  bloc.addCheckout({
                      "name" : widget.name,
                      "price" : widget.price
                    });
                    print(bloc.checkoutItem);
                }else if (_value == false) {
                    bloc.removeCheckout({
                      "name" : widget.name,
                      "price" : widget.price
                    });
                    print(bloc.checkoutItem);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: blockWidth * 0.5, color: Colors.black),
                borderRadius: BorderRadius.circular(blockWidth * 6),
              ),
              child: _value
                ? Container(
                    color: Color(0xffbb5e1e),
                    child: Icon(
                      Icons.check,
                      size: Checkbox.width,
                      color: Colors.white,
                    ))
                : Icon(
                    Icons.check_box_outline_blank,
                    size: 0,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

// This Bottom bar is for adding icons of Plus and Minus as well as Add to Cart Button

class BottomBar extends StatefulWidget {

  final String name;
  final String img;
  final int price;


  BottomBar({Key key, this.name, this.price, this.img}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  int _number = 0;


  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: blockHeight * 15,
            child: Column(
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: blockHeight * 6, 
                          child:FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if(_number!=0){
                                _number--;
                              }
                            });
                          },
                        child: Icon(Icons.remove, color: Color(0xffbb5e1e)),
                          backgroundColor: Colors.white,
                          heroTag: null,                        
                        ),
                      ),
                    ),
                    SizedBox(width: blockWidth * 2),
                    Text('$_number',
                        style: TextStyle(fontSize: blockWidth * 5)
                    ),
                    SizedBox(width: blockWidth * 1),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  SizedBox(
                      height: blockHeight * 6, 
                        child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _number++;
                          });
                        },
                        child: Icon(Icons.add, color: Colors.white,),
                        backgroundColor: Color(0xffbb5e1e),
                        heroTag: null,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, blockHeight * 0.8, 0, blockHeight * 1.2),
                      child: SizedBox(
                        width: blockWidth * 30,
                        height: blockHeight * 6,
                        child: RaisedButton(
                          onPressed: (){

                              bloc.addToCart({"name" : widget.name, "price": widget.price*_number,"original":widget.price, "img" : widget.img,"number" : _number,"quan":quan});
                              print(bloc.allItems);

                              quan = quan + bloc.allItems[bloc.allItems.length-1]['number'];

                              print(quan);

                          },
                          textColor: Colors.white,
                          color: Color(0xffbb5e1e),
                          child: Center(
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(
                                fontSize: blockWidth * 3,
                                fontFamily: 'NunitoSansSemiBold',
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(blockWidth * 6)
                          ),
                        ),
                      ),
                    ),  
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingMenuTwoCards extends StatelessWidget {
  final String name;
  final String img;
  final String subtitle;
  final int price;

  SettingMenuTwoCards({Key key, this.img, this.name, this.subtitle, this.price}) :super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Container(
      // For Image Padding
      padding: EdgeInsets.fromLTRB(0, blockHeight * 0.5, 0, blockHeight * 0.5),
        child: Row(
          children: <Widget>[
            Padding(
              // For Text Padding
              padding: EdgeInsets.only(left: 0.0, right: blockWidth * 1.5),
              child: Container(
                height: blockWidth * 40,
                width: blockWidth * 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(blockWidth * 2),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Flexible(
              child: 
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                   fontSize: blockWidth * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[400],
                    fontFamily: 'NunitoSans-SemiBold',
                  ),
                ),
                SizedBox(height: blockHeight * 1),
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: blockWidth * 3,
                        fontWeight: FontWeight.w300,
                        color: Colors.brown[400],
                        fontFamily: 'NunitoSans-Regular',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                       padding: EdgeInsets.only(right: blockWidth * 2),
                       child: Text(
                       "$price",
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: blockWidth * 4,
                         fontWeight: FontWeight.bold,
                         color: Colors.brown[400],
                         fontFamily: 'NunitoSans-SemiBold',
                       ),
                     ),
                   ),
                  ],
                  ),
              ],
            ),
           ),
          ],
        ),
    );
  }
}



 