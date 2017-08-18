Pod::Spec.new do |s|

  s.name                    = "GKNavigationBarViewControllerSwift"

  s.version                 = "1.0.2"

  s.summary                 = "iOS自定义导航栏-导航栏联动，Swift版本"

  s.homepage                = "https://github.com/QuintGao/GKNavigationBarViewControllerSwift"

  s.license                 = "MIT"

  s.authors                 = { "高坤" => "1094887059@qq.com" }

  s.social_media_url        = "https://github.com/QuintGao"

  s.platform                = :ios, "8.0"

  s.ios.deployment_target   = "8.0"

  s.source                  = { :git => "https://github.com/QuintGao/GKNavigationBarViewControllerSwift.git", :tag => s.version.to_s }

  s.requires_arc            = true

  s.source_files            = 'GKNavigationBarViewControllerSwift/**/*.{swift,h}'

  s.resource                = 'GKNavigationBarViewControllerSwift/Resource'

end
