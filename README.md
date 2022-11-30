<h1>My services</h1>

<h2 align="center">Topics 📋</h2>

   <p>
   
   - [About 📖](#About-)
   - [How to use 🤔](#How-to-use-)

   </p>

---

<h2 align="center">About 📖</h2>
   
<p>
  My services is an app to keep track of your personal or work services. For example, if you are a hairdresser, you can register and track all hair styles that you have done in that day.
</p>

---

<h2 align="center">How to use🤔</h2>

<p>
    You can download it to use <a href="https://github.com/lucas-242/my_services/releases/">here</a> or you can clone the repository and create your own project on Firebase.
</p>

   1. Clone this repository:
   ```
   $ git clone https://github.com/lucas-242/my_services
   ```

   2. Enter in the directory:
   ```
   $ cd my_services
   ```

   3. Generate your keys in the project android/app folder
   ```
   $ keytool -genkey -v -keystore \android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey
   ```

   4. Change the variables below in local.properties file inside the android folder:
   ```   
   flutter.minSdkVersion=23
   flutter.targetSdkVersion=30
   ```

   5. Create and configure a firebase project to use Firestore Database and Google Authentication.
   Make sure to use the flutterfire cli to generate the firebase_options.dart file in lib folder.
   ```
   $ flutterfire config
   ```

   6. Install the dependencies:
   ```
   $ flutter pub get
   ```

   7. Run the app: 
   ```
   $ flutter run
   ```