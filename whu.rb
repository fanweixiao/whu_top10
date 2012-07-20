require 'nokogiri'
require 'net/http'
require 'open-uri'

t       = Time.now
url     = 'http://whuface.com/page_top?r=' + (t.to_f * 1000).to_i.to_s
cookie  = 'g=female'
referer = 'http://whuface.com/'
_seq    = 1

Nokogiri::HTML(open(url, 'Cookie' => cookie)).xpath("//img/@src").each do |src|
  File.open(t.mon.to_s + '-' + t.day.to_s + '-' + t.hour.to_s + '-' + t.min.to_s + '-' + _seq.to_s + '-' + File.basename(src), 'wb') do |f| 
    begin
      puts "Downloading: " + src
      f.write(open(src, "Referer" => referer).read)
    rescue
      puts 'err occurd'
    end
  end
  _seq+=1
  puts _seq
end

puts 'DONE'
