import 'package:flutter/material.dart';

/// import mask_input_formmater pagkage to your class
import 'package:mask_input_formatter/mask_input_formatter.dart';

/* @Autor Amjad Jamali */

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
/// An Example class to test [MaskInputFormatter]
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
                    // Binding MaskInputFormatter with TextField
                    MaskInputFormatter(mask: '#####-#######-#'),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "42000-0000000-0",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 4),
                TextFormField(
                  // another example with text and numbers
                  inputFormatters: [
                    MaskInputFormatter(
                        mask: '(AA) ### #######', textAllCaps: true)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "(AB) 301 4567890",
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4),
                TextFormField(
                  inputFormatters: [
                    MaskInputFormatter(mask: '+# (###) ###-##-##'),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "+1 (234) 567-89-01",
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4),
                TextFormField(
                  inputFormatters: [
                    MaskInputFormatter(mask: '##/##/####'),
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "23/05/2021",
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
