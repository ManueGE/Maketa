Pod::Spec.new do |spec|

  spec.name         = "Maketa"
  spec.version      = "1.1.1"
  spec.summary      = "An operational API to manage AutoLayout"
  spec.description  = <<-DESC
  **Maketa** provides an operational, easy to read, easy to write, API to manage AutoLayout.  
                   DESC
  spec.homepage     = "https://github.com/ManueGE/Maketa/"
  spec.license      = "MIT"


  spec.author    = "Manuel García-Estañ"
  spec.social_media_url   = "http://twitter.com/ManueGE"

  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/ManueGE/Maketa.git", :tag => "#{spec.version}" }

  spec.requires_arc = true
  spec.framework = "UIKit"

  spec.source_files = "Maketa/*.{swift}"
end
