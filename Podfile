# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DB8' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DB8
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'MessageKit'
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'MessageKit'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end


end
