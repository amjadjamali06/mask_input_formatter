library mask_input_formatter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* @Autor Amjad Jamali */

/// A [MaskInputFormatter] class is used for masking text inserted in [TextField] and [TextFormField].
///
/// This is a class which extends [TextInputFormatter] class,
/// [TextInputFormatter] can be optionally injected into an [EditableText]
/// to provide as-you-type validation and formatting of the text being edited.
///
class MaskInputFormatter extends TextInputFormatter {
  List<String> _maskChars = [];
  List<int> _maskIndices = [];

  String _letters = 'abcdefghijklmnopqrstuvwxyz';
  String _numbers = '1234567890';
  String _regex = '';
  String? mask='';
  String _allowableValues = '';
  String _newChar = '';

  bool? textAllCaps;
  bool _isBackPressed = false;

  int _maxLength = 0, _newLength = 0, _oldLength = 0;

  int _offset=0;

  /// The constructor of [MaskInputFormatter] class accepts two arguments.
  /// 1. [mask] this is required parameter, text will be formatted on the basis of this mask,
  /// 2. [textAllCaps] this is optional, when user wants all letters capital then he can set [textAllCaps] = true,
  MaskInputFormatter({required this.mask, this.textAllCaps}) {
    textAllCaps=textAllCaps??false;
    mask=mask??'';
    /// checking regex in mask
    if (mask!.contains('#') && mask!.contains('A'))
      _regex = _letters + _numbers;
    else if (mask!.contains('#'))
      _regex = _numbers;
    else if (mask!.contains('A'))
      _regex = _letters;
    else {
      print('invalid mask \'$mask\' (Ex.\'AAA-###\')');
      mask = '';
      return;
    }
    _maxLength = mask!.length;

    int maskPos = 0;

    /// separating mask characters and positions form applied mask
    for (int i = 0; i < _maxLength;) {
      String ch = mask![i];
      if (ch != '#' && ch != 'A') {
        String sChar = '';
        for (; (sChar != '#' && sChar != 'A' && i < _maxLength);) {
          ch = ch + sChar;
          i++;
          if (i < _maxLength) {
            sChar = mask![i];
          }
        }
        _maskIndices.add(maskPos);
        _maskChars.add(ch);
        maskPos++;
      } else {
        i++;
        maskPos++;
        _allowableValues = _allowableValues + ch;
      }
    }
  }

  /// method to format user input into given mask
  TextEditingValue _formatText(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = _getUnmaskedText(newValue.text);

    newText = _getValidText(newText);

    _offset = newValue.selection.baseOffset;

    String oldText = _getUnmaskedText(oldValue.text);

    String filteredText = _getMaskedText(newText, oldText);

    if (newText == oldText && !_isBackPressed) {
      _offset--;
    }

    int maskSpaces = 0;

    /// maintain offset(cursor position) occording to given mask
    if (!_isBackPressed) {
      for (int mIndex, i = 0; i < _maskIndices.length; i++) {
        mIndex = _maskIndices.elementAt(i) + maskSpaces + 1;
        _offset = (_offset == mIndex)
            ? _offset + _maskChars.elementAt(i).length
            : _offset;
        maskSpaces = (maskSpaces + _maskChars.elementAt(i).length - 1);
      }

      for (int i = 0; i < _maskIndices.length; i++) {
        if (_maskIndices[i] == (_offset - i + (i > 0 ? 1 : 0))) {
          _offset = _maskChars[i].length + _offset;
          break;
        }
      }
    } else {
      while (newText == oldText &&
          _offset > 1 &&
          !_regex.contains(filteredText[_offset - 1].toLowerCase())) {
        _offset--;
      }
    }

    while (_offset < filteredText.length &&
        !_isBackPressed &&
        !_regex.contains(filteredText[_offset])) {
      _offset++;
    }

    if (_offset > filteredText.length) {
      _offset = filteredText.length;
    }

    /// returning new value with masked text
    return TextEditingValue(
      text: textAllCaps! ? filteredText.toUpperCase() : filteredText,
      selection: TextSelection(
          baseOffset: _offset,
          extentOffset: _offset,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional),
    );
  }

  /// method to format user input into given mask
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (mask == '') {
      return newValue;
    }
    _newLength = newValue.text.length;
    _oldLength = oldValue.text.length;
    _isBackPressed = _newLength < _oldLength;

    if (_isBackPressed) {
      return _formatText(oldValue, newValue);
    } else {
      /// get new inserted character
      _newChar = newValue.text[oldValue.selection.baseOffset];
    }

    if (!_regex.contains(_newChar) && _oldLength == _newLength - 1) {
      /// if new value not contain allowable values return old value
      return oldValue;
    } else if (_oldLength == _maxLength && _newLength >= _maxLength) {
      /// if already inserted max chars return old value
      return oldValue;
    } else if (newValue.composing.start != -1 &&
        !_letters.contains(newValue.text[oldValue.selection.baseOffset]) &&
        _newLength > _oldLength) {
      if (_newLength > _oldLength) {
        return _formatText(
            oldValue,
            TextEditingValue(
              text: newValue.text.substring(0, _maxLength),
              selection: newValue.selection,
            ));
      }
      return oldValue;
    } else {
      /// format input value
      return _formatText(oldValue, newValue);
    }
  }

  /// check if number
  bool _isNumber(String ch) {
    return _numbers.contains(ch);
  }

  /// check if Letter
  bool _isLetter(String ch) {
    return _letters.contains(ch.toLowerCase());
  }

  bool _isValid(String ch) {
    return _regex.contains(ch.toLowerCase());
  }

  /// validate text
  String _getValidText(String temp) {
    String text = '';
    for (int i = 0, j = 0;
        i < temp.length && j < _allowableValues.length;
        i++) {
      String ch = temp[i];
      String regCh = _allowableValues[j];
      if (regCh == 'A' && _isLetter(ch)) {
        text = text + ch;
        j++;
      } else if (regCh == '#' && _isNumber(ch)) {
        text = text + ch;
        j++;
      }
    }
    return text;
  }

  /// get unmasked text
  String _getUnmaskedText(String temp) {
    String text = '';
    for (int i = 0; i < temp.length; i++) {
      String ch = temp[i];
      text = text + (_isValid(ch) ? ch : '');
    }
    return text;
  }

  /// get masked text
  String _getMaskedText(String newText, String oldText) {
    String text = '';
    for (int i = 0, j = 0; i < newText.length;) {
      if (j < _maskChars.length && i == _maskIndices[j] - j) {
        text = text + _maskChars[j];
        j++;
      }
      text = text + newText[i];
      i++;

      if (i == newText.length && newText.length >= oldText.length) {
        if (((_offset >= text.length) || newText.length == 1) &&
            j < _maskChars.length &&
            i == _maskIndices[j] - j) {
          text = text + _maskChars[j];
          j++;
        }
      }
    }
    return text;
  }
}
