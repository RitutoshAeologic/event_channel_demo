import 'package:event_channel_demo/core/constants/icon_constants.dart';
import 'package:event_channel_demo/core/constants/string_constants.dart';
import 'package:event_channel_demo/core/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class EventChannelView extends StatefulWidget {
  const EventChannelView({super.key});

  @override
  State<EventChannelView> createState() => _EventChannelViewState();
}

class _EventChannelViewState extends State<EventChannelView> {

  static const EventChannel _deviceEventChannel =
  EventChannel('deviceEventChannel');
  static const EventChannel _stringEventChannel =
  EventChannel('stringEventChannel');

  Map<String, dynamic>? _deviceInfo;
  String _stringFromNative = StringConstants.notReceivedString;

  void _stopListeningAndClearEventChannelData() {
    setState(() {
      _deviceInfo = null;
      _stringFromNative = StringConstants.notReceivedString;
    });
  }



  void _sendDeviceInfoEvent() {
    _deviceEventChannel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        _deviceInfo = Map<String, dynamic>.from(event);
      });
    });
  }

  void _sendStringEvent() {
    _stringEventChannel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        _stringFromNative = event.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(StringConstants.eventChannel),
      ),
      body: Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: MediaQuery.of(context).size.height*0.12),
          if (_deviceInfo != null)
            for (var entry in _deviceInfo!.entries)
              Text(
                '${entry.key}: ${entry.value}',
                style: const TextStyle(fontSize: 16),
              ),
          Text(
            '${StringConstants.stringFromNative}: $_stringFromNative',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(title: StringConstants.getDeviceInfoNative,
            onTap: _sendDeviceInfoEvent
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(title: StringConstants.getStringNative,
              onTap: _sendStringEvent
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(title: StringConstants.clearData,
              onTap: _stopListeningAndClearEventChannelData
          ),

        ],
      ),
    );
  }
}
