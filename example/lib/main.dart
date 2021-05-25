import 'package:flutter/material.dart';
import 'package:mask_input_formatter1/mask_input_formatter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersData(),
    );
  }

}

class UsersData extends StatefulWidget {
  const UsersData({Key key}) : super(key: key);

  @override
  _UsersData createState() => _UsersData();
}

class _UsersData extends State<UsersData> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      inputFormatters: [
                        MaskInputFormatter('#####-#######-#', regexp: RegExp.numbers),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "42000-0000000-0",
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      inputFormatters: [
                        MaskInputFormatter('+# (###) ###-##-##', regexp: RegExp.numbers),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "+1 (234) 567-89-01",
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      inputFormatters: [
                        MaskInputFormatter('##/##/####', regexp: RegExp.numbers),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "23/05/2021",
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      inputFormatters: [MaskInputFormatter('(AA) #####', regexp: RegExp.lettersAndNumbers)],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "(AB) 12345",
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}
