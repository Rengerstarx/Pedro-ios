# Uncomment the next line to define a global platform for your project
ios_deployment_target = '13.0'

target 'TaGOnrog' do
  use_frameworks!
  pod 'TinyConstraints', '4.0.2'
  pod 'Toast-Swift', '5.1.0'
  pod 'Moya/Combine', '15.0.0'
  pod 'SDWebImage', '5.18.10'
  pod 'AMPopTip', '4.12.0'
  pod 'PKHUD', '5.3.0'
  pod 'Shuffle-iOS', '0.5.0'
  pod 'UIViewController+KeyboardAnimation', '1.3'
  pod 'FloatingPanel', '2.8.2'
  pod 'Parchment', '3.2.0'
  pod 'Pulsator', '0.6.0'
  pod 'UITextView+Placeholder', '1.4.0'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseAnalytics'
  pod 'GoogleSignIn'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
      target.build_configurations.each do |config|
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
  end
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < ios_deployment_target.to_f
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = ios_deployment_target
        end
      end
    end
  end
end
