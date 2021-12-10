import 'package:dart_serial_port/dart_serial_port.dart';

void main(List<String> arguments) {
  final name = SerialPort.availablePorts.first;
  final port = SerialPort(name);
  if (!port.openReadWrite()) print(SerialPort.lastError);
  print('Hello world!');
}
