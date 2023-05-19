<h1>Kazi</h1>

<h2 align="center">Topics 📋</h2>

   <p>
   
   - [About 📖](#About-)
   - [How to use 🤔](#How-to-use-)

   </p>

---

<h2 align="center">About 📖</h2>
   
<p>
  Kazi is an app to keep track of your personal or work services. For example, if you are a hairdresser, you can register and track all hair styles that you have done in that day.
</p>

---

<h2 align="center">How to use🤔</h2>

<p>
    You can download it to use <a href="https://github.com/lucas-242/Kazi/releases/">here</a> or you can clone the repository and create your own project on Firebase.
</p>

   1. Clone this repository:
   ```
   $ git clone https://github.com/lucas-242/Kazi
   ```

   2. Enter in the directory:
   ```
   $ cd Kazi
   ```

   3. Generate your keys in the project android/app folder
   ```
   $ keytool -genkey -v -keystore \android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   4. Change the variables below in local.properties file inside the android folder:
   ```   
   flutter.minSdkVersion=23
   flutter.targetSdkVersion=31
   ```

   5. Create and configure a firebase project to use Firestore Database and Google Authentication.
   Make sure to use the flutterfire cli to generate the firebase_options.dart file in lib folder.
   ```
   $ flutterfire config
   ```

   6. Create a file named ad_keys.dart in lib/app/shared/constants.
   ```
   $ echo "abstract class AdKeys {
   static const androidFinishAddActionKeyDev = 'ca-app-pub-3940256099942544/1033173712';
   static const androidFinishAddActionKeyProd = '';
   static const iosFinishAddActionKeyDev = 'ca-app-pub-3940256099942544/4411468910';
   static const iosFinishAddActionKeyProd = '';

   static const androidCalendarServiceListKeyDev = 'ca-app-pub-3940256099942544/6300978111';
   static const androidCalendarServiceListKeyProd = '';
   static const iosCalendarServiceListKeyDev = 'ca-app-pub-3940256099942544/2934735716';
   static const iosCalendarServiceListKeyProd = '';

   static const androidHomeServiceListKeyDev = 'ca-app-pub-3940256099942544/6300978111';
   static const androidHomeServiceListKeyProd = '';
   static const iosHomeServiceListKeyDev = 'ca-app-pub-3940256099942544/2934735716';
   static const iosHomeServiceListKeyProd = '';
   }" > lib/app/shared/constants/ad_keys.dart
   ```

   7. Add your adMob app id in the android/key.properties
   ```
   adMobAppId.debug=ca-app-pub-3940256099942544~3347511713
   adMobAppId.release=ca-app-pub-xxxxx~xxxxx
   ```

   8. Add metadata in Android/app/src/main/AndroidManifest
   ```
   <meta-data
        android:name="com.google.android.gms.ads.APPLICATION_ID"
        android:value="@string/ADMOB_APPID"/>
   ```

   9. Change the buildTypes in android/app/build.gradle
   ```
   buildTypes {
      debug {
         resValue "string", "ADMOB_APPID", keystoreProperties['adMobAppId.debug']
         signingConfig signingConfigs.debug
      }
      release {
         resValue "string", "ADMOB_APPID", keystoreProperties['adMobAppId.release']
         signingConfig signingConfigs.release
      }
   }
   ```

   10. Install the dependencies.
   ```
   $ flutter pub get
   ```

   11. Run the app. 
   Set APP_EVN to prod if you want to run on prod mode.
   ```
   $ flutter run --dart-define="APP_ENV=dev"
   ```
