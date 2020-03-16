import 'package:flutter/material.dart';
import 'package:helpinghand/main.dart';
// import 'router.dart';
import 'myColors.dart';

class Signin extends StatefulWidget{

  SigninState createState() => new SigninState();
}
enum FormType { login, register }
class SigninState extends State<Signin>{
GlobalKey formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _hintText = '';
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return smallScreen(context);
    }

    return largeScreen(context);
  }

  Widget smallScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Card(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: loginForm() +
                              [
                                SizedBox(
                                  height: 30,
                                )
                              ] +
                              submissionOptions(), // adding two widget lists
                        ))),
              ])),
              hintText(),
            ])));
  }

  Widget largeScreen(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: loginForm() +
                                    [
                                      SizedBox(
                                        height: 30,
                                      )
                                    ] +
                                    submissionOptions(), // adding two widget lists
                              ))),
                    ])),
                hintText(),
              ]))),
    );
  }

  void submitForm() async {
    // final form = formKey.currentState;
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
    // if (form.validate()) {
    //   form.save();

    //   //hides keyboard
    //   FocusScope.of(context).requestFocus(new FocusNode());
    //   // try {
    //   //   MyAuthUser firebaseUser = _formType == FormType.login
    //   //       ? await Provider.of<FireAuthService>(context)
    //   //           .signIn(_email, _password)
    //   //       : await Provider.of<FireAuthService>(context)
    //   //           .createUser(_email, '', _email, _password);

    //   //   String userId = firebaseUser.uid;

    //   //   setState(() {
    //   //     _hintText = 'Signed In\n\nUser id: $userId';
    //   //     //user created his account. Now directly sign-in
    //   //     Navigator.pushReplacementNamed(context, router.USER_PROFILE,
    //   //         arguments: firebaseUser);
    //   //   });
    //   // } catch (e) {
    //   //   setState(() {
    //   //     _hintText = 'Sign In Error\n\n${e.message}';
    //   //   });
    //   // }
    // } else {
    //   setState(() {
    //     _hintText = '';
    //   });
    // }
  }

  void register() {
    // formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _hintText = '';
    });
  }

  void signIn() {
    // formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _hintText = '';
    });
  }

  List<Widget> loginForm() {
    return [
      padded(
          child: TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
        onSaved: (val) => _email = val,
      )),
      padded(
          child: TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
        onSaved: (val) => _password = val,
      )),
    ];
  }

  List<Widget> submissionOptions() {
    switch (_formType) {
      case FormType.login:
        return [
          LogInButton(
              key: Key('login'),
              text: 'Login',
              height: 44.0,
              backgroundColor: Colors.blue,
              onPressed: submitForm),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              key: Key('register'),
              child: Text(
                "Need an account? Register",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              onPressed: register),
        ];
      case FormType.register:
        return [
          LogInButton(
              key: Key('create_account'),
              text: 'Register',
              height: 44.0,
              backgroundColor: Colors.blue,
              onPressed: submitForm),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              key: Key('sign_in'),
              child: Text(
                "Registered already ? Login",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              onPressed: signIn),
        ];
    }
    return null;
  }

  Widget hintText() {
    return Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text(_hintText,
            key: Key('hint_text'),
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center));
  }

  Widget padded({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}

class ItemCard extends StatelessWidget {
  final content;
  final icon;
  final name;
  final tasks;
  final color1;
  final color2;
  const ItemCard(
      this.icon, this.name, this.tasks, this.color1, this.color2, this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.3),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.height *
                MediaQuery.of(context).size.width /
                4980),
          ),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color1, color2])),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                child: content,
              ),
            ),
            Text(
              name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              tasks,
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}















class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget(
      {Key key, this.largeScreen, this.mediumScreen, this.smallScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return smallScreen;
    //final shortestSide = MediaQuery.of(context).size.shortestSide;
    final shortestSide = getShortestSide(context);
    //Returns the largest screen for screens 1200 or larger.
    if (shortestSide >= 1200) {
      return largeScreen;
    } else if (shortestSide > 800 && shortestSide < 1200) {
      //if medium screen not available, then return large screen
      return mediumScreen ?? largeScreen;
    } else {
      //if small screen implementation not available, then return large screen
      return smallScreen ?? largeScreen;
    }
  }

  static double getShortestSide(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  //Making these methods static, so that they can be used as accessed from other widgets

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isLargeScreen(BuildContext context) {
    return getShortestSide(context) > 1200;
  }

  //Small screen is any screen whose width is less than 800 pixels
  static bool isSmallScreen(BuildContext context) {
    return getShortestSide(context) < 800;
  }

  //Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  static bool isMediumScreen(BuildContext context) {
    return getShortestSide(context) > 800 && getShortestSide(context) < 1200;
  }
}



Widget factBot(BuildContext context) {
  return Container(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        child: Center(
          child: Icon(Icons.chat),
        ),
        elevation: 4.0,
        backgroundColor: MyColors.blue1,
        // onPressed: () => Navigator.pushNamed(context, FACTS_DIALOGFLOW),
      ));
}

class LogInButton extends StatelessWidget {
  LogInButton(
      {this.key, this.text, this.height, this.onPressed, this.backgroundColor})
      : super(key: key);
  Key key;
  String text;
  double height;
  VoidCallback onPressed;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints.expand(height: height),
      child: new RaisedButton(
          child: new Text(text,
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 4))),
          color: backgroundColor,
          textColor: Colors.black87,
          onPressed: onPressed),
    );
  }
}
