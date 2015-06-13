#
# Be sure to run `pod lib lint kublaiOSToolbox.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "kublaiOSToolbox"
  s.version          = "0.0.4"
  s.summary          = "Operational Swift functions, extensions and all."
  s.description      = <<-DESC
                       An optional longer description of kublaiOSToolbox

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/kublaios/kublaiOSToolbox"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Kubilay Erdogan" => "kublaios@gmail.com" }
  s.source           = { :git => "https://github.com/kublaios/kublaiOSToolbox.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kublaios'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'kublaiOSToolbox' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pods/Reachability/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'Reachability', '~> 3.2'
end
