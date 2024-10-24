# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iHubSDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iHubSDK
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RealmSwift', '~> 10.44.0'
  pod 'RxRealm'
  pod 'RxAlamofire'
  pod 'RxGesture'
  pod 'RxUIAlert'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end