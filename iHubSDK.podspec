
Pod::Spec.new do |spec|

  spec.name         = "iHubSDK"
  spec.version      = "1.0.5"
  spec.summary      = "iHubSDK 是專為Ihub設計的SDK"
  spec.description  = "內容為語言設置等功能,主要為開發使用的模組化檔案,避免重工."
  spec.homepage     = "https://github.com/dctooandy/iHubSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Andychen" => "rd-sw18@visionsecurity.com.tw" }

  spec.ios.deployment_target = "13.0"
  # spec.osx.deployment_target = "10.13"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"
  # spec.visionos.deployment_target = "1.0"

  spec.source       = { :git => "https://github.com/dctooandy/iHubSDK.git", :tag => "#{spec.version}" }

  spec.source_files  = "iHubSDK/*.{h,swift}"
  spec.exclude_files = "Classes/Exclude"

  

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  spec.dependency "RxDataSources"
  spec.dependency "RxAlamofire"
  spec.dependency "RxGesture"
  spec.dependency "RxUIAlert"

  spec.swift_versions = "5.0"

end
