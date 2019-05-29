class Converter{
  static double dynamicToDouble(dynamic _in){
    if(_in is int)
      return _in.toDouble();
    else if(_in is String)
      return double.parse(_in);
    else
      return _in;
  }
}