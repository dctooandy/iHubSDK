
Pod::Spec.new do |spec|

  spec.name         = "iHubSDK"

  spec.version      = "1.0.59"

  spec.summary      = "iHubSDK 是專為Ihub設計的SDK"
  spec.description  = "內容為語言設置等功能,主要為開發使用的模組化檔案,避免重工."
  spec.homepage     = "https://github.com/dctooandy/iHubSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "AndyChen" => "rd-sw18@visionsecurity.com.tw" }


  spec.ios.deployment_target = "13.0"
  spec.platform = :ios, '13.0'
  # spec.osx.deployment_target = "10.13"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"
  # spec.visionos.deployment_target = "1.0"

  spec.source       = { :git => "https://github.com/dctooandy/iHubSDK.git", :tag => "#{spec.version}" }

  spec.source_files  = "iHubSDK/**/*.{h,m,swift}"

  # spec.prepare_command = <<-CMD
  #  mkdir -p ./iHubSDK/Frameworks/
  #  cp -R ./videoSDK.framework ./iHubSDK/Frameworks/
  #  if [ ! -d "./iHubSDK/Frameworks/videoSDK.framework" ]; then
  #      echo "Error: videoSDK.framework not found in ./iHubSDK/Frameworks/"
  #      exit 1
  #  fi
  # CMD

  # spec.vendored_frameworks = 'iHubSDK/SDKs/videoSDK.framework'

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  spec.dependency "RxDataSources"
  spec.dependency "RealmSwift"
  spec.dependency "RxAlamofire"
  spec.dependency "RxGesture"
  spec.dependency "RxUIAlert"

  spec.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']
# 確保正確的架構設定
  # spec.pod_target_xcconfig = {
  #   'VALID_ARCHS' => 'arm64 x86_64',
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
  #   'ARCHS' => '$(ARCHS_STANDARD)',
  #   'ONLY_ACTIVE_ARCH' => 'NO',
  #   'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
  #   'DEFINES_MODULE' => 'YES'
  # }
end
