platform :ios, '14.0'

target 'Brasileirao' do
  use_frameworks!
  pod 'SDWebImage'
  pod 'SDWebImageSVGCoder'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
