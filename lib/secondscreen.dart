import 'package:flutter/material.dart';
import 'package:flurry_navigation/flurry_navigation.dart';
import 'main.dart';

final secondscreen = new Screen(
    contentBuilder: (BuildContext context) {
      return new Center(
        child: new Container(
          // height: 250,
          child: new Padding(
            padding: const EdgeInsets.all(25.0),
            child: new Column(
              children: [
                new Expanded(
                    child: new Center(
                        child: GuardForm()
                    )
                ),
                new Expanded(
                    child: new Center(
                        child: AnimatedMapControllerPage()
                    )
                )
              ],
            ),
          ),
        ),

      );
    }
);

class GuardForm extends StatefulWidget{
  GuardFormState createState() => new GuardFormState();
} 

class GuardFormState extends State<GuardForm>{
  List<String> _locs = <String>['', 'Kottayam', 'Pampady', 'Kanjirappally', 'Erattupetta'];
  String _loc = '';
  List<String> _dtypes = <String>['', 'Floods', 'Cyclone', 'Landslides', 'Droughts'];
  String _dtype = '';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Form(
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 200),
                children: <Widget>[
                  new Text("Rescue Guards near you"),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.location_city),
                          labelText: 'Location',
                        ),
                        isEmpty: _loc == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _loc,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _loc = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _locs.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.tonality),
                          labelText: 'Disaster Type',
                        ),
                        isEmpty: _dtype == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _dtype,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _dtype = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _dtypes.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Find'),
                        onPressed: null,
                      )),
                ],
          )),
      ),
    );
  }

}
