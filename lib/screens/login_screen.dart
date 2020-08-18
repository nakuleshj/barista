import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
    final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      );
  final _loginFormKey = GlobalKey<FormState>();
  final _registrationFormKey = GlobalKey<FormState>();
  String email;
  String password;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Register'),
          content: SingleChildScrollView(
            child: Form(
              key: _registrationFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    cursorColor: kPrimaryColor,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) return 'Required';
                      else if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))
                        return 'Enter a valid Email Address';
                      else
                        return null;
                    },
                    onFieldSubmitted: (value) {
                      //currentNode.unfocus();
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'Your Email Address',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    'A password will be sent to your Email address',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: getFontSize(context, -2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.black12,
              padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontSize: getFontSize(context, 0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
              onPressed: () {
                //Register
                if(_registrationFormKey.currentState.validate())
                  print('Validated');
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.white,
                  fontSize: getFontSize(context, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: getFontSize(context, 10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          cursorColor: kPrimaryColor,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            //currentNode.unfocus();
                            FocusScope.of(context).nextFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Username or Email Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) return 'Required';
                            return null;
                          },
                          cursorColor: kPrimaryColor,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                              color: kPrimaryColor,
                              padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
                              onPressed: () async{
                                try{
                                  final token = await woocommerce.authenticateViaJWT(username: email, password: password);
                                  if(token!=null)
                                  {int userID=await woocommerce.fetchLoggedInUserId();
                                  SharedPreferences.getInstance().then((value) {value.setInt('userID', userID);value.setBool('isLoggedIn', true);});
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
                                  }
                                }
                                catch(e){
                                  print(e);
                                }
                                
                                // final myCart = await woocommerce.addToMyCart(quantity: 2.toString(), itemId: 17.toString());
                                // print(myCart.price);
                                // if (_loginFormKey.currentState.validate()){
                                //   var token=await woocommerce.authenticateViaJWT(username: email, password: password);
                                //   print(token.toString());
                                  // final customer = woocommerce.loginCustomer(username: email, password: password);
                                //   }
                                //Submit form
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 0),
                                ),
                              ),
                            ),
                            Text('Forgot Password?',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: kDefaultFontFamily,
                                  fontSize: getFontSize(context, 0),
                                ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: kDefaultFontFamily,
                                  fontSize: getFontSize(context, 0),
                                )),
                            GestureDetector(
                              onTap: () {
                                _showMyDialog();
                              },
                              child: Text(' Register',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontFamily: kDefaultFontFamily,
                                    fontSize: getFontSize(context, 0),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
