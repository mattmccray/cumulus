# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cumulus}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["M@ McCray"]
  s.date = %q{2008-12-09}
  s.description = %q{**Non Functional / Still in Planning Stage**  Here's the high-level (brain dump):  * Site content is organized in collections * Collections are serialized * Each have support for next, previous, first, last, etc * The content files are HTML * Templates are object based (each content type can be rendered with their own templates) * Templates are HTML with interspersed Liquid markup * All meta data is described using HTML meta tags * You custom meta data tags in a content objects * You can specify 'prototype' content objects in a collection with a _proto folder in the collection}
  s.email = ["darthapo@gmail.com"]
  s.executables = ["cumulus", "cumulus-gen"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/cumulus", "bin/cumulus-gen", "cumulus.gemspec", "lib/cumulus.rb", "lib/cumulus/cli.rb", "lib/cumulus/configuration.rb", "lib/cumulus/hash_db.rb", "lib/cumulus/resources.rb", "lib/cumulus/resources/attachment.rb", "lib/cumulus/resources/base_resource.rb", "lib/cumulus/resources/content.rb", "lib/cumulus/resources/layout.rb", "lib/cumulus/resources/skin.rb", "lib/cumulus/resources/template.rb", "lib/cumulus/scanner.rb", "lib/support/trollop.rb", "script/console", "script/destroy", "script/generate", "test/fixtures/my_site/Rakefile", "test/fixtures/my_site/config/content.yml", "test/fixtures/my_site/config/publishing.yml", "test/fixtures/my_site/config/site.yml", "test/fixtures/my_site/content/articles/about/index.html", "test/fixtures/my_site/content/articles/about/test.rb", "test/fixtures/my_site/content/posts/001-hello-world/index.html", "test/fixtures/my_site/skin/styles/screen.css", "test/fixtures/my_site/skin/templates/layouts/home.html", "test/fixtures/my_site/skin/templates/layouts/main.html", "test/fixtures/my_site/skin/templates/objects/article.html", "test/fixtures/my_site/skin/templates/objects/article.summary.html", "test/fixtures/my_site/skin/templates/objects/post.html", "test/fixtures/my_site/skin/templates/objects/post.summary.html", "test/test_cumulus.rb", "test/test_cumulus_cli.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/darthapo/cumulus}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cumulus}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{**Non Functional / Still in Planning Stage**  Here's the high-level (brain dump):  * Site content is organized in collections * Collections are serialized * Each have support for next, previous, first, last, etc * The content files are HTML * Templates are object based (each content type can be rendered with their own templates) * Templates are HTML with interspersed Liquid markup * All meta data is described using HTML meta tags * You custom meta data tags in a content objects * You can specify 'prototype' content objects in a collection with a _proto folder in the collection}
  s.test_files = ["test/test_cumulus.rb", "test/test_cumulus_cli.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.6"])
      s.add_runtime_dependency(%q<liquid>, [">= 1.9"])
      s.add_runtime_dependency(%q<rake>, [">= 0.8"])
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<shoulda>, [">= 2.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.6"])
      s.add_dependency(%q<liquid>, [">= 1.9"])
      s.add_dependency(%q<rake>, [">= 0.8"])
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<shoulda>, [">= 2.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.6"])
    s.add_dependency(%q<liquid>, [">= 1.9"])
    s.add_dependency(%q<rake>, [">= 0.8"])
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<shoulda>, [">= 2.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
