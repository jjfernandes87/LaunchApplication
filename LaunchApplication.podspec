Pod::Spec.new do |s|
s.name             = 'LaunchApplication'
s.version          = '0.0.1'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.summary          = 'Crie um sequencia de inicailização de forma simples e rápida.'
s.homepage         = 'https://github.com/jjfernandes87/LaunchApplication'
s.social_media_url = 'https://twitter.com/jfernandes87'
s.author           = { 'jjfernandes87' => 'julio.fernandes87@gmail.com' }
s.source           = { :git => 'https://github.com/jjfernandes87/LaunchApplication.git', :tag => s.version }

s.ios.deployment_target = '9.3'
s.source_files = 'LaunchApplication/Classes/**/*'

s.description      = <<-DESC
Se você precisa criar um sequencia de inicialização antes de abrir seu aplicativo, você pode criar um sequencia de metodos para serem executados e forma sincrona.
                        DESC
end
