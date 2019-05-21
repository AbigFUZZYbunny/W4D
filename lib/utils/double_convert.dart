class Converter{
  static double dynamicToDouble(dynamic _in){
    if(_in is int)
      return _in.toDouble();
    return _in;
  }
}