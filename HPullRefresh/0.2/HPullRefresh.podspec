Pod::Spec.new do |s|
  s.name         = "HPullRefresh"
  s.version      = "0.2"
  s.summary      = "horizontal PullRefresh on ScrollView."
  s.homepage     = "https://github.com/donbe/HPullRefresh"

  s.license  = 'MIT'
  s.author       = { "donbe" => "donbe520@gmail.com" }
  s.source       = { 
    :git => "https://github.com/donbe/HPullRefresh.git", 
    :tag => "0.2"
  }

  s.platform     = :ios, '5.0'
  s.frameworks   = 'QuartzCore'
  s.source_files = 'horizontalPullRefresh/*.{h,m,png}'
  s.requires_arc = true
end