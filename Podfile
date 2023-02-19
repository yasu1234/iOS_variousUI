# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'swift_variousUI' do
  use_frameworks!

  pod 'Parchment'
  pod 'TTGSnackbar'
  pod 'RxSwift'
  pod 'RxCocoa'

  target 'swift_variousUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'swift_variousUIUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
