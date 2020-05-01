import 'package:flutter/material.dart';
import 'package:mr_fluffy_fluffs/cart_1.dart';
import 'package:mr_fluffy_fluffs/menu2.dart';
import 'package:mr_fluffy_fluffs/profile.dart';
import 'package:mr_fluffy_fluffs/sideBar.dart';
import 'package:mr_fluffy_fluffs/Data/menuItems.dart';
import 'package:mr_fluffy_fluffs/Data/temp_1.dart';
import 'package:mr_fluffy_fluffs/extra.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

TextEditingController emailController = new TextEditingController();

class _MenuState extends State<Menu> {
  
  // For accessing the Drawer 

  final GlobalKey<ScaffoldState> _menuKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Scaffold(
      backgroundColor: Colors.white,

      // To be used for the Drawer

      key: _menuKey,
      drawerEdgeDragWidth: 0,
      drawer: SideBar(),

      // A ListView was used in this case instead of a column because we wanted this screen to scroll and this can't be done by using Columns

      body: Container(
        child: ListView(
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
                  color: Colors.red[200],
                ),
                IconButton(
                  onPressed: () {
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
                                bloc.allItems.length.toString(),
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
            Row(
              children: <Widget>[
                Flexible(
                      child: FlatButton(
                    onPressed: () {
                      _menuKey.currentState.openDrawer();
                    },
                    child: Text(
                      "Sort By",
                      style: TextStyle(
                        color: Colors.red[200],
                        fontSize: blockWidth * 4,
                        fontFamily: 'NunitoSans-Regular',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.brown[200], 
                         width: blockWidth * 0.3,
                       ),
                       borderRadius: BorderRadius.circular(blockWidth),
                      ),
                      hintText: "Search Menu",
                      suffixIcon: IconButton(
                        onPressed: (){
                          String name = emailController.text;

                          if (name.isEmpty){
                            temp = menuItems;
                          }
                          else {
                            List<Map> temp2 = [];
                            for (Map i in temp) {
                              for (int j = 0; j < i['name'].length; j++) {
                                if(j+name.length+1>i['name'].length){
                                  break;
                                }
                                if (name.toLowerCase() == i['name']
                                    .substring(j, j + name.length)
                                    .toLowerCase()) {
                                  temp2.add(i);
                                  break;
                                }
                              }
                            }
                          }
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                      onSubmitted: (String name){
                        setState((){
                          if (name.isEmpty){
                            temp = menuItems;
                          }
                          else {
                            List<Map> temp2 = [];
                            for (Map i in temp) {
                              for (int j = 0; j < i['name'].length; j++) {
                                if(j+name.length+1>i['name'].length){
                                  break;
                                }
                                if (name.toLowerCase() == i['name']
                                    .substring(j, j + name.length)
                                    .toLowerCase()) {
                                  temp2.add(i);
                                  break;
                                }
                              }
                            }
                            temp = temp2;
                          }
                        });
                      }
                  ),
                ),
              ],
            ),
            HelperMenu(),
          ],
        ),
      ),
    );
  }
}


// A special helper class created for adding the menu items

class HelperMenu extends StatefulWidget {

  @override
  _HelperMenuState createState() => _HelperMenuState();
}

class _HelperMenuState extends State<HelperMenu> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Material(
      child: Container(
        // From the Left and Right of Container + A bit from Bottom
        padding: EdgeInsets.fromLTRB(blockWidth* 1.5, 0, blockHeight * 2, blockWidth * 2),
        child: Column (
          children: <Widget>[            
            SizedBox(height: blockWidth * 1.4),

            // A ListView builder allows access to the List file containing the data in an easy and efficient manner
            // This Data is then sent to another helper file which places all the components of the Menu in place. 

              ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: temp == null ? 0 :temp.length,
              itemBuilder: (BuildContext context, int index) {
                Map menu = temp[index];
                return SettingMenuCards(
                  img: menu['img'],
                  name: menu['name'],
                  subtitle: menu['subtitle'],
                  price: menu['price'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// This helper file placed all the components of the menu

class SettingMenuCards extends StatelessWidget {
  final String name;
  final String img;
  final String subtitle;
  final int price;

  SettingMenuCards({Key key, this.img, this.name, this.subtitle, this.price}) :super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

  // This helper file placed all the components of the menu
    return Container(
      // For Image Padding
      padding: EdgeInsets.fromLTRB(0, blockHeight * 0.5, 0, blockHeight * 0.5),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,MaterialPageRoute(
              builder: (context) => MenuTwo(img: img, name: name, subtitle: subtitle, price:  price),
            ),
          );
        },

        // For adjusting the images in place
        
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

            // The Flexible Widget allowed the components to be placed according to the alignments mentioned. 
            // Wrap was used for the Description Section so the text would not overflow

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
                    fontFamily: 'NunitoSansSemiBold',
                  ),
                ),
                SizedBox(height: blockHeight * 1),
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      subtitle,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: blockWidth * 3,
                        fontWeight: FontWeight.w300,
                        color: Colors.brown[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                       padding: EdgeInsets.only(right: blockWidth * 2),
                       child: Text(
                       "Rs $price",
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: blockWidth * 4,
                         fontWeight: FontWeight.bold,
                         color: Colors.brown[400],
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
      ),
    );
  }
}