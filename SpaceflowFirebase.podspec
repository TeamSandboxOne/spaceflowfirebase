firebase_firestore_version = '10.18.0a'

Pod::Spec.new do |s|
  s.name                   = 'SpaceflowFirebase'
  s.version                = firebase_firestore_version
  s.summary                = 'Compilation of precompiled libraries for Spaceflow'
  s.description            = 'Compilation of precompiled libraries like Firebase, FireStore, GDSignIn, Analytics, Crashlytics etc, Performance, Functions etc.'
  s.homepage               = 'https://spaceflow.io'
  s.license                = 'MIT'
  s.cocoapods_version      = '>= 1.10.0'
  s.authors                = 'Spaceflow'
  s.pod_target_xcconfig    = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.static_framework       = true
  s.source                 = {
    :git => 'https://github.com/TeamSandboxOne/spaceflowfirebase.git',
    :tag => 'CocoaPods-' + s.version.to_s
  }

  # These frameworks, minimums, and the c++ library are here from, and copied specifically to match, the upstream podspec:
  # https://github.com/firebase/firebase-ios-sdk/blob/34c4bdbce23f5c6e739bda83b71ba592d6400cd5/FirebaseFirestore.podspec#L103
  # They may need updating periodically.
  s.ios.frameworks         = 'SystemConfiguration', 'UIKit'
  s.osx.frameworks         = 'SystemConfiguration'
  s.tvos.frameworks        = 'SystemConfiguration', 'UIKit'
  s.library                = 'c++'
  s.ios.deployment_target  = '11.0'
  s.osx.deployment_target  = '10.13'
  
  s.source_files = 'Sources/Firebase.h'
  
  s.preserve_paths = [
    'Sources/run',
    'Sources/upload-symbols',
  ]
  
  # Ensure the run script and upload-symbols are callable via
  # ${PODS_ROOT}/FirebaseCrashlytics/<name>
  s.prepare_command = <<-PREPARE_COMMAND_END
    cp -f ./Sources/run ./run
    cp -f ./Sources/upload-symbols ./upload-symbols
  PREPARE_COMMAND_END
  
  s.ios.pod_target_xcconfig = {
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'GCC_PREPROCESSOR_DEFINITIONS' =>
      'CLS_SDK_NAME="Crashlytics iOS SDK" ' +
      # For nanopb:
      'PB_FIELD_32BIT=1 PB_NO_PACKED_STRUCTS=1 PB_ENABLE_MALLOC=1',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}"',
  }

  s.osx.pod_target_xcconfig = {
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'GCC_PREPROCESSOR_DEFINITIONS' =>
      'CLS_SDK_NAME="Crashlytics Mac SDK" ' +
      # For nanopb:
      'PB_FIELD_32BIT=1 PB_NO_PACKED_STRUCTS=1 PB_ENABLE_MALLOC=1',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}"',
  }  
  
  
# Base Pod gets everything except leveldb, which if included here may collide with inclusions elsewhere
  s.subspec 'Base' do |base|
    frameworksBase = Dir.glob("Sources/*.xcframework").select do |name|
        true
      end
      
      base.resource = 'Sources/Resources/*.bundle'
      base.preserve_paths = frameworksBase
    end

  end