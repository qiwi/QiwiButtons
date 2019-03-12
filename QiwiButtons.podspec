Pod::Spec.new do |s|
	s.name = 'QiwiButtons'
	s.version = '1.0'
	s.swift_version = '4.2'
	s.ios.deployment_target = '9.0'
	s.author   = { 'QIWI Wallet iOS Team' => 'iphone@qiwi.ru' }
	s.requires_arc = true
	s.license = { :type => 'BSD' }
	s.homepage = 'https://github.qiwi.com/client-dev-ios/QiwiButtons'
	s.summary = 'QIWI Buttons'
	s.source = { :git => 'https://github.qiwi.com/client-dev-ios/QiwiButtons.git', :branch => 'master' }
	s.source_files = 'QiwiButtons/**/*.swift'
	s.static_framework = true
end
