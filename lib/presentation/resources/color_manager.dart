import 'package:flutter/material.dart';

class ColorManagar {
  static Color primary = HexColor.fromHex("#FE724C");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryWithOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color darkPrimary = HexColor.fromHex("#D17D11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#E61F34");
  static Color black = HexColor.fromHex("#000000");
}

//converting color to HexColor
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; //8 char with opacity
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
