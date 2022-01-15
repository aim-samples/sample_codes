import 'package:flutter/material.dart';
import 'package:multiple_theme/firebase_page.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StreamingSharedPreferences.instance.then((preferences) => runApp(MyApp(ThemeSettings(preferences,),),),);
}

class MyApp extends StatelessWidget {
  MyApp(this.settings);
  final ThemeSettings settings;
  @override Widget build(BuildContext context) => PreferenceBuilder<ThemeObject>(
    preference: settings.theme,
    builder: (context, theme) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multiple theme',
      theme: ThemeData(
        brightness: getBrightness(isDarkMode: theme.isDarkMode),
        primaryColor: getColor(color: theme.primaryColor),
        accentColor: getColor(color: theme.accentColor),),
      home: SettingsUI(settings),)
  );
}
class SettingsUI extends StatefulWidget{
  final ThemeSettings settings;
  SettingsUI(this.settings);
  @override _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  final accentColorController = TextEditingController();
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Settings'),),
    body: Container(
      child: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Dark mode'),
            value: widget.settings.theme.getValue().isDarkMode,
            onChanged: (_) => changeBrightness(),
            secondary: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
    ),
  );
  void changeBrightness(){
    ThemeObject theme = widget.settings.theme.getValue();
    theme.isDarkMode = !theme.isDarkMode;
    widget.settings.theme.setValue(theme);
  }
  void changeAccentColor(String color){
    ThemeObject theme = widget.settings.theme.getValue();
    theme.accentColor = color;
    widget.settings.theme.setValue(theme);
  }
}
class ThemeSettings {
  ThemeSettings(StreamingSharedPreferences preferences) : theme =
  preferences.getCustomValue<ThemeObject>(
    Keys.theme,
    defaultValue: ThemeObject(
      accentColor: colorValue(color : Colors.redAccent[200],),
      isDarkMode: false,
      primaryColor: colorValue(color : Colors.pink[700],),),
    adapter: JsonAdapter(
      serializer: (value) => value.toJson(),
      deserializer: (value) => ThemeObject.fromJson(value),),);
  Preference<ThemeObject> theme;
}
class ThemeObject {
  ThemeObject({this.accentColor, this.primaryColor, this.isDarkMode});
  String accentColor;
  String primaryColor;
  bool isDarkMode;
  ThemeObject.fromJson(Map<String, dynamic> json) :
        accentColor = json[Keys.accentColor],
        isDarkMode = json[Keys.isDarkMode],
        primaryColor = json[Keys.primaryColor];
  Map<String, dynamic> toJson() => {
    Keys.accentColor : accentColor,
    Keys.isDarkMode : isDarkMode,
    Keys.primaryColor: primaryColor,};
}
class Keys {
  static const String theme         = 'theme';
  static const String accentColor   = 'accentColor';
  static const String isDarkMode    = 'isDarkMode';
  static const String primaryColor  = 'primaryColor';
}

String      colorValue({Color color})         => '0x' + color.value.toRadixString(16);
Color       getColor({String color})          => Color(int.parse(color));
Brightness  getBrightness({bool isDarkMode})  => isDarkMode == true ? Brightness.dark : Brightness.light;

