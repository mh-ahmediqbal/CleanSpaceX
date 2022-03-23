platform :ios, '12.1'

def shared_pods

    pod 'Moya'
    pod 'PromiseKit'
    pod 'Kingfisher'
    pod "ImageSlideshow/Kingfisher"
end

target 'CleanSpaceX' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  shared_pods

  # Pods for CleanSpaceX

  target 'CleanSpaceXTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CleanSpaceXUITests' do
    # Pods for testing
  end

end
