target 'WeatherTheDay' do
  use_frameworks!
  pod 'SideMenu'
  pod 'Prephirences'
  pod 'Prephirences/CoreData'
  pod 'LocationPickerViewController', :git => 'https://github.com/JeromeTan1997/LocationPicker.git', :branch => 'swift-3'
  pod 'ForecastIO', :git => 'https://github.com/sxg/ForecastIO.git', :branch => 'swift3'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
