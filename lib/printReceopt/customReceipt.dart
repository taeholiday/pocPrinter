import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

printCustomReceipt() async {
  final List<int> _escPos = await _customEscPos();
  await SunmiPrinter.initPrinter();
  await SunmiPrinter.startTransactionPrint(true);
  await SunmiPrinter.printRawData(Uint8List.fromList(_escPos));
  await SunmiPrinter.exitTransactionPrint(true);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);
  List<int> bytes = [];
  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.reset();
  bytes += generator.cut();

  return bytes;
}
