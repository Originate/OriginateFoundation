Pod::Spec.new do |s|
  s.name                = "OriginateFoundation"
  s.version             = "0.0.1"
  s.summary             = "OriginateFoundation bundles fundamental behaviors / categories / extensions commonly used to streamline iOS development."

  s.homepage            = "https://github.com/Originate/OriginateFoundation"
  s.license             = 'MIT'
  s.author              = { "Philip Kluz" => "philip.kluz@originate.com" }
  s.source              = { :git => "https://github.com/Originate/OriginateFoundation.git", :tag => s.version.to_s }

  s.platform            = :ios, '8.0'
  s.requires_arc        = true

  s.source_files        = 'Pod/Sources/**/*'

  s.public_header_files = 'Pod/Sources/**/*.h'
end
