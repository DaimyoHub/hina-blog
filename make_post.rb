#!/usr/bin/env ruby
require 'fileutils'
require 'commonmarker'

def make_post_path(title)
  "posts/#{title.gsub(' ', '_').downcase}"
end

def compile_post(title)
  fname = make_post_path(title)
  raw = File.open("#{fname}.md", "r") { |f| f.read }
  body = CommonMarker.render_doc(raw).to_html
  File.open("#{fname}.html", "w") { |f|
    f.write "<!DOCTYPE html>
<html>
  <head>
      <meta charset=utf8 />
      <meta name=viewport content=\"width=device-width, initial-scale=1.0\" />
      <title>#{title}</title>
      <link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\"/>
  </head>
  <body>
    <img src=\"../pics/jup_ant_wat.png\" alt=\"Jupyter et Antiope, Watteau.\"/>    

    <h1>Hina, selon moi.</h1>
    
    <p>Quelques idées à propos d'Hina, mon infrastructure de compilation expérimentale.</p>
    
    <br/>
    
    <a href=\"../index.html\">Page principale</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
    <a href=\"../about.html\">A propos du blog</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
    <a href=\"../contact.html\">Me contacter</a>
    
    <hr/>
    
    #{body}
    </body>

    <br>
    <footer>
        <hr/>
    
        <a href=\"../index.html\">Page principale</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
        <a href=\"../about.html\">A propos du blog</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
    <a href=\"../contact.html\">Me contacter</a>

        <br/><br/>

        <a rel=\"license\" href=\"http://creativecommons.org/licences/by-nd/4.0/\">
            <img alt=\"Creative Commons License\" style=\"border-width:0\" src=\"https://licensebuttons.net/l/by-nd/4.0/80x15.png\"/>
        </a>

        <br/>

        Copyright (c) 2021 Daimyo. Ce blog est sous license <a rel=\"license\" href=\"http://creativecommons.org/licenses/by-nd/4.0/\">CC BY-ND 4.0 International License</a>.
    </footer>
</html>"}

end

if ARGV.length != 2
  STDERR.puts "Usage: article.rb [compile|new] <title>"
  exit 1
end

aname = ARGV[1]

if ARGV[0] == "compile"
  compile_post aname 
elsif ARGV[0] == "new"
  fname = make_post_path(aname)
  File.open("#{fname}.org", "w") { |f| f.write "* #{aname}\n/#{Time.now.strftime("%Y-%m-%d")}/\n" }
  puts "Source file is located at `#{fname}.org.`"
else
  STDERR.puts "Invalid action: #{ARGV[0]}.\nAvailable actions: compile,new."
end
