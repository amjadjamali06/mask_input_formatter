# mask_input_formatter

The package provides TextInputFormatter for TextField and TextFormField which format the input by a given mask.

![Flutter Logo](/images/flutter_image.png)

## Example

Check 'example' folder for code sample

![Example Input](/images/mask_example.gif)

## Usage
1. Follow the install guide
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
## Contributing
Suggestions and Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Developer Team:
Amjad Jamali & his team members (Kamran Khan, Hina Hussain, Faiza Farooqui) :tada:

## License
[MIT](https://choosealicense.com/licenses/mit/)
