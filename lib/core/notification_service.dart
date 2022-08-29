
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotificationService{
  static LocalNotificationService? _instance;
  static LocalNotificationService get instance {
    if(_instance==null){
      debugPrint("LocalNotificationService nulldı oluştu");
      return  _instance = LocalNotificationService._init();
    }
    else {
      debugPrint("LocalNotificationService önceki kullanıldı");
      return _instance!;
    }
  }
  late final BehaviorSubject<String?> onNotifications;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ;
  late final InitializationSettings initializationSettings ;
  late final AndroidNotificationChannel channel;
  LocalNotificationService._init(){
    onNotifications=BehaviorSubject<String?>();
    flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();


    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:(a,b,c,d){},
    );

    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,iOS:initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    init();

  }
  void listenOnTabNotifications({required BuildContext context})=>onNotifications.stream.listen((String? value){
    _onClickedNotification(value,context:context);
    debugPrint("listen OnTab Notifications");
    onNotifications.stream.forEach((element) { debugPrint(element);
    debugPrint("-*-");});
  });

  void _onClickedNotification(String? payload,{required BuildContext context}){
    debugPrint("_onClickedNotification");
  //  if(payload!=null)Get.to(()=>NotificationDetailPage(payload:payload,));
  }
  static initializeTimeZones()async{  // mainde çağır
    tz.initializeTimeZones();
    final locationName= await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }
  Future<void> init() async {
    /*
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel("high_importance_channel");
     */
    debugPrint("init local notify");
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
      showBadge: true,
      enableLights: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    /// When app is closed
    final details= await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if(details != null && details.didNotificationLaunchApp){
      onNotifications.add(details.payload);

      debugPrint("Normal behaviour");
      debugPrint(details.payload);
    }
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
          debugPrint("When initialize local notification behaviour");
        });
  }
  Future<void> showNotification({String? title, String? body,required int hashcode,required String? payload})async {
    debugPrint("---------showNotification---------");
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('high_importance_channel', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        channelShowBadge: true,
        icon: '@mipmap/ic_launcher',
        channelAction: AndroidNotificationChannelAction.values[
        1
        ],
        color: const Color(0x00960002),
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ticker: 'AcnTurk Sigorta');

    const IOSNotificationDetails iosPlatformChannelSpecifics =
    IOSNotificationDetails(
      threadIdentifier: "high_importance_channel",
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(iOS:iosPlatformChannelSpecifics,android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      hashcode,title??'plain title', body??'plain body', platformChannelSpecifics,
      payload: payload??'item x',);
  }
  Future showScheduledNotification(
      {int id = 0,
        String? title,
        String? body,
        String? payload,
        required DateTime scheduledDate}) async {
    debugPrint("********----*********");
    //scheduledDate mandatory
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate,tz.local),
      schedulePlatformChannelSpecifics(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,

    );
  }
  NotificationDetails schedulePlatformChannelSpecifics(){
    debugPrint(AndroidNotificationChannelAction.values.toString());
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails('schedule task channel', 'AcnTurk Tasks',
        channelDescription: 'Scheduled task notification',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        channelShowBadge: true,
        icon: '@mipmap/ic_launcher',
        /*
      channelAction: AndroidNotificationChannelAction.values[
      1
      ],
       */
        color: Color(0x960002),
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ticker: 'AcnTurk Sigorta');

    const IOSNotificationDetails iosPlatformChannelSpecifics =
    IOSNotificationDetails(
      threadIdentifier: "schedule task channel",
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(iOS:iosPlatformChannelSpecifics,android: androidPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }
}