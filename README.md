# mask_input_formatter

[![pub package](https://img.shields.io/pub/v/mask_input_formatter.svg)](https://pub.dartlang.org/packages/mask_input_formatter)
[![likes](https://badges.bar/mask_input_formatter/likes)](https://pub.dev/packages/mask_input_formatter/score)
[![popularity](https://badges.bar/mask_input_formatter/popularity)](https://pub.dev/packages/mask_input_formatter/score)
[![pub points](https://badges.bar/mask_input_formatter/pub%20points)](https://pub.dev/packages/mask_input_formatter/score)
[![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)



The package provides TextInputFormatter for TextField and TextFormField which format the input by a given mask.

<!-- ![flutter_image](https://user-images.githubusercontent.com/84534787/120998591-a95c6980-c7a1-11eb-9435-7d7587f0b32b.png | width=100)  -->
<img WIDTH="60%" src="https://user-images.githubusercontent.com/84534787/120998591-a95c6980-c7a1-11eb-9435-7d7587f0b32b.png">
<br />

## Demo

<!-- ![mask_example](https://user-images.githubusercontent.com/84534787/120998728-ca24bf00-c7a1-11eb-97a4-3d96df827c40.gif){:width="50%"} -->
<img width="40%" src="https://user-images.githubusercontent.com/84534787/120998728-ca24bf00-c7a1-11eb-97a4-3d96df827c40.gif">


## Usage

1. Add dependency.

Run this command:

With Flutter:

```dart
$ flutter pub add mask_input_formatter
```

or add following package in your `pubspec.yaml` file inside the `dependencies:` section.
```dart
dependencies:
  mask_input_formatter: ^0.0.3
```
2. Importing the library:

```dart
import 'package:mask_input_formatter/mask_input_formatter.dart';
```

3. Create a mask formatter:

```dart
MaskInputFormatter myFormatter =  MaskInputFormatter(mask: '(AA) #####');
```

4. Set with TextField/TextFormField:

```dart
TextFormField(
    inputFormatters: [myFormatter],
    decoration: InputDecoration(
        hintText: "(AB) 12345",
    )
) // TextFormField
```


## Result

```dart
// Input  --> JK75757
// Output --> (JK) 75757 set formatted text on TextField
```

## Other Mask
You can use the mask whatever you defined in formatter:

```dart
MaskInputFormatter dateFormatter =  MaskInputFormatter(mask: '##/##/####');
// --> 26/05/2021
MaskInputFormatter phoneFormatter =  MaskInputFormatter(mask: '+# (###) ###-####');
// --> +1 (234) 567-8901
MaskInputFormatter numberFormatter =  MaskInputFormatter(mask: 'AAA-###', textAllCaps: true);
// --> XYZ-789
```


Check [example](https://pub.dartlang.org/packages/mask_input_formatter/example) folder for code sample


## Note
In last example. --> (AAA-###)
* 'A' character will allow only letters from A-Z.
* '#' character will allow only numbers.
* And other characters and symbols will be added as mask.

## Contributing
Suggestions and Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Developer Team:
Amjad Jamali & his team members (Kamran Khan, Hina Hussain, Faiza Farooqui) :tada:

## License
[Apache 2.0](https://opensource.org/licenses/Apache-2.0/)
