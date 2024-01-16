import 'package:event_channel_demo/core/constants/icon_constants.dart';
import 'package:event_channel_demo/core/constants/string_constants.dart';
import 'package:event_channel_demo/core/custom_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class MethodChannelView extends StatefulWidget {
  const MethodChannelView({super.key});

  @override
  State<MethodChannelView> createState() => _MethodChannelViewState();
}

class _MethodChannelViewState extends State<MethodChannelView> {
  static const MethodChannel _methodChannel =
  MethodChannel('exampleMethodChannel');

  int _result = 0;

  Future<void> _calculateSum(int a, int b) async {
    try {
      final dynamic result = await _methodChannel
          .invokeMethod('calculateSum', {'a': a, 'b': b});
      setState(() {
        _result = result as int;
      });
    } on PlatformException catch (e) {
      setState(() {
        _result = 0;
      });
      if (kDebugMode) {
        print('Error: ${e.message}');
      }
    }
  }
  void _stopListeningAndClearMethodChannelData() {
    setState(() {
      _result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(StringConstants.methodChannel),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.all(12),
                decoration:  const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppIcons.bgImage),
                        alignment: Alignment.center,
                        fit: BoxFit.fill)),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.15),
          Text(
            '${StringConstants.result}: $_result',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(title: '${StringConstants.calculateSum} (10 + 20)',
              onTap: () => _calculateSum(10, 20),
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(title: '${StringConstants.calculateSum} (5 + 7)',
            onTap: () => _calculateSum(5, 7),
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(title: StringConstants.clearData,
            onTap: _stopListeningAndClearMethodChannelData,
          ),
        ],
      ),
    );
  }
}
