require 'nokogiri'
require 'net/http'
require 'open-uri'

url     = 'http://whuface.com/page_top?r='
cookie  = 'g=female'
referer = 'whuface.com'

Nokogiri::HTML(open(url, 'Cookie' => cookie)).xpath("//img/@src").each do |src|
  puts src
  # File.open(File.basename(src), 'wb'){ |f| f.write(open(src).read) }    
  File.open(File.basename(src) + '.jpg', 'wb') do |f| 
    begin
      f.write(open(src, "Referer" => referer).read)
    rescue
      puts "err occurd"
    end
  end
end

puts 'DONE'
