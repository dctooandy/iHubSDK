# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iHubSDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iHubSDK
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RealmSwift'
#  pod 'RxRealm'
  pod 'RxAlamofire'
  pod 'RxGesture'
  pod 'RxUIAlert'

end

# post_install do |installer|
#   installer.pods_project.targets.each do |target|
#     target.build_configurations.each do |config|
#       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
#     end
#   end
# end
# 重要：新增 post_install hook
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # 基本設定
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      
      # 關鍵設定：排除模擬器架構
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64 x86_64'
      # 其他基本設定
      config.build_settings['VALID_ARCHS'] = 'arm64'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      # 確保正確的部署目標
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
