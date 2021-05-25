import 'package:flutter_test/flutter_test.dart';
import 'package:mask_input_formatter1/mask_input_formatter.dart';

void main() {
  test('Format input value', () {
    final formatter = MaskInputFormatter('AA-##', regexp: RegExp.lettersAndNumbers);
    expect(formatter.formatText(
        TextEditingValue(text: "as-76"),
        TextEditingValue(text: "as-768")
    ),
        TextEditingValue(text: "as-76")
    );
  });
}
