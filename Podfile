source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target 'Assesment 2022' do
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'DSFSparkline', :git => 'https://github.com/dagronf/DSFSparkline/'
  pod 'Localize-Swift'

  target 'Assesment 2022Tests' do
    inherit! :search_paths
    # Pods for testing
    pod "Cuckoo"
  end

  target 'Assesment 2022UITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
