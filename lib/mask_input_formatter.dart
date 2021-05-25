library mask_input_formatter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RegExp {
  letters,
  numbers,
  lettersAndNumbers
}

class MaskInputFormatter extends TextInputFormatter{

  static const String letters = 'abcdefghijklmnopqrstuvwxyz';
  static const String numbers = '1234567890';
  static const String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyz1234567890';

  List<String> _maskChars = [];
  List<int> _maskIndices = [];

  String regex = lettersAndNumbers;
  final String mask;
  String _allowableValues='';

  final RegExp regexp;

  MaskInputFormatter(this.mask, {@required this.regexp}){
    switch(regexp){
      case RegExp.numbers:{ regex = numbers; }break;
      case RegExp.lettersAndNumbers:{ regex = lettersAndNumbers; }break;
      case RegExp.letters:{ regex = letters; }break;
      default:{ regex = lettersAndNumbers; }break;
    }
    int maskPos = 0;
    for (int i =0 ;i<mask.length;) {
      String ch = mask.characters.characterAt(i).toString();
      if(ch!='#' && ch!='A'){
        String sChar = '';
        for(;(sChar!='#' && sChar!='A' && i<mask.length);){
          ch=ch+sChar;
          i++;
          if(i<mask.length) {
            print('${mask.characters.characterAt(i).toString()}');
            sChar = mask.characters.characterAt(i).toString();
          }
        }
        _maskIndices.add(maskPos);
        _maskChars.add(ch);
        maskPos++;
      }else{
        i++;
        maskPos++;
        _allowableValues=_allowableValues+ch;
      }
    }
  }


  TextEditingValue formatText(TextEditingValue oldValue, TextEditingValue newValue) {

    String text = '';
    String temp = newValue.text;

    for (int i = 0; i < temp.length; i++) {
      String ch = temp.characters.characterAt(i).toString();
      if (regex.contains(ch.toLowerCase())) {
        text = text + ch;
      }
    }

    temp = text;
    text='';
    for (int i = 0; i < temp.length; i++) {
      String ch = temp.characters.characterAt(i).toString();
      String regCh = _allowableValues.characters.characterAt(i).toString();
      if(regCh == 'A' && letters.contains(ch))
        text = text + ch;
      else if(regCh == '#' && numbers.contains(ch))
        text = text + ch;
    }

    int offset = newValue.selection.baseOffset;

    temp = oldValue.text;
    String oldText = '';
    for (int i = 0; i < temp.length; i++) {
      String ch = temp.characters.characterAt(i).toLowerCase().toString();
      if (regex.contains(ch)) {
        oldText = oldText + ch;
      }
    }

    if (text == oldText && newValue.text.length > oldValue.text.length) {
      offset--;
    }

    String filteredText = '';

    for (int i = 0, j = 0; i < text.length; ) {
      if (j < _maskChars.length && i == _maskIndices[j]-j) {
        filteredText = filteredText + _maskChars[j];
        j++;
      }
      filteredText = filteredText + text[i];
      i++;
      if(i == text.length){
        if (j < _maskChars.length && i == _maskIndices[j]-j) {
          filteredText = filteredText + _maskChars[j];
          j++;
        }
      }
    }

    int maskSpaces=0;
    if (newValue.text.length > oldValue.text.length) {
      for(int mIndex, i=0 ;i<_maskIndices.length; i++){
        mIndex = _maskIndices.elementAt(i)+maskSpaces+1;
        offset = (offset == mIndex) ? offset+_maskChars.elementAt(i).length : offset;
        maskSpaces = (maskSpaces+_maskChars.elementAt(i).length-1);
      }

      for(int i=0 ; i < _maskIndices.length ; i++) {
        if(_maskIndices[i] == (offset-i+(i>0?1:0))) {
          offset = _maskChars[i].length+offset;
          break;
        }
      }
    }
    else if (newValue.text.length < oldValue.text.length) {
      while(text == oldText && offset>1 && !regex.contains(filteredText[offset-1])) {
        offset--;
      }
    }

    if(offset>filteredText.length){
      offset = filteredText.length;
    }

    return TextEditingValue(
        text: filteredText,
        selection: TextSelection(
            baseOffset: offset,
            extentOffset: offset,
            affinity: newValue.selection.affinity,
            isDirectional: newValue.selection.isDirectional
        )
    );
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(oldValue.text.length == mask.length && newValue.text.length >= mask.length){
      return oldValue;
    }else{
      return formatText(oldValue, newValue);
    }
  }

}
