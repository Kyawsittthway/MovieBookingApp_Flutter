import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var countryCodes = [
    "+95",
    "+65",
    "+1",
    "+66",
  ];

  @override
  Widget build(BuildContext context) {
    String? dropDownValue = countryCodes[0];
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
              child: Container(
            height: 0.0,
          )),
          Container(
            child: Image.asset('assets/loginLogo.png'),
          ),
          SizedBox(
            height: 96,
          ),
          Text(
            "Verify Your Phone Number",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              fontFamily: 'DM Sans',
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "We will send a 6-digits sms code\n to verify your phone number.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: 'DM Sans'
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
           DropdownButton(
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue!;
                });
              },
              selectedItemBuilder: (BuildContext context) { //<-- SEE HERE
                return <String>['Car', 'Train', 'Bus', 'Flight']
                    .map((String value) {
                  return Text(
                    dropDownValue!,
                    style:  TextStyle(
                        color: Colors.blue,
                        fontSize: 30
                    ),
                  );
                }).toList();
              },
              items: <String>['Car', 'Train', 'Bus', 'Flight']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 200,
                child: TextFormField(
                  keyboardType: TextInputType.number,style: TextStyle(
                  color:Colors.white,
                ),
                  decoration: InputDecoration(

                    border: UnderlineInputBorder(
                    ),

                    hintText: "Mobile Phone",
                    hintStyle: TextStyle(
                      color:Colors.grey,

                    ),
                  ),
                )
              )
    ]
          ),
          SizedBox(height: 30,),
          Container(

            child: ElevatedButton(
              child: Text("Verify your phone number"),
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                primary:Colors.green,
                onPrimary: Colors.black

              )
            ),
          ),
          SizedBox(height: 30,),
          Container(

            child: ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Icon(Icons.g_mobiledata),
                    Text("Verify your phone number"),

  ]

                ),
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    primary:Colors.white,
                    onPrimary: Colors.black

                )
            ),
          )
        ],
      ),
    ));
  }
}
