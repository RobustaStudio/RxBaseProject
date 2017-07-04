Pod::Spec.new do |s|
	s.name             = 'RxBaseProject'
	s.version          = '0.3.0'
	s.summary          = 'RxBaseProject is a kickstarting project for RxApplications'
	s.description      = <<-DESC
	RxBaseProject is a kickstarting project for RxApplications, no need to keep repeating the code over and over again
					   DESC
	s.homepage         = 'http://gitlab.robustastudio.com/ios/RxBaseProject'
	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.author           = { 'ahmed93' => 'ahmed.moh.magdi93@gmail.com' }
	s.source           = { :git => 'gitlab@gitlab.robustastudio.com:ios/RxBaseProject.git', :tag => s.version.to_s }
	s.source_files = 'RxBaseProject/Classes/**/*'
	s.ios.deployment_target = '9.0'
    s.preserve_path = 'RxBaseProject/Classes/**/*.{h,m,swift}'
	s.frameworks = 'AVFoundation', 'UIKit'

    #s.requires_arc = true
    #s.pod_target_xcconfig = {
    #    'OTHER_LDFLAGS' => '$(inherited)',
    #    'OTHER_LDFLAGS' => '-lObjC'
    #}

	#################
	# Subspec
	#################
	# s.subspec 'Sources' do |ss|
	# 	ss. source_files = 'RxBaseProject/'
	# end

	#################
	# Dependecies
	################

	s.subspec 'Core' do |ss| 	
		ss.dependency 'Moya-ObjectMapper/RxSwift', '2.3.2'
		ss.dependency 'RxSwift'
		ss.dependency 'RxCocoa'
		ss.dependency 'RxOptional' ,       '~> 3.1.3'
		ss.dependency 'Moya',              '~> 8.0.5'
		ss.dependency 'Alamofire' ,        '~> 4.4.0'
		ss.dependency 'ReachabilitySwift', '~> 3.0.0'
		ss.dependency 'RxDataSources' ,    '~> 1.0.3'
		ss.dependency 'Result' ,           '~> 3.2.1'
    end

    s.subspec 'ExtraHandling' do |ss|
    	ss.dependency 'Kingfisher' ,       '~> 3.6.1'
    	ss.dependency 'DZNEmptyDataSet' ,  '~> 1.8.1'
    	ss.dependency 'SVProgressHUD',     '~> 2.1.2'
		ss.dependency 'SwiftMessages',     '~> 3.3.3'
		ss.dependency 'ReusableKit' ,      '~> 1.1.0'
		ss.dependency 'SnapKit',           '~> 3.2.0'
		ss.dependency 'Then',              '~> 2.1.0'
    end
	
end
