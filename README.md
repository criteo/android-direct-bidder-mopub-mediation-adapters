# Criteo Adapters for Mopub Mediation (Android)
This repository contains Criteo’s Adapter for Mopub Mediation. It must be used in conjunction with the [Criteo Publisher SDK](https://github.com/criteo/android-publisher-sdk). 
For requirements, instructions, and other info, see [Integrating Criteo with Mopub Mediation](https://publisherdocs.criteotilt.com/app/android/mediation/mopub/).

# Download
Add the following maven repository into your top-level *build.gradle* file:

```kotlin
allprojects {
    repositories {
        jcenter()
    }
}
```

Then, in your app's module *build.gradle* file, add the following implementation configuration to the *dependencies* section:

```kotlin
implementation 'com.criteo.mediation.mopub:criteo-adapter:4.2.0.0'
```

# License
[Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html)
