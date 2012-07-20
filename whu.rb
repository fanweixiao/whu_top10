require 'nokogiri'
require 'net/http'
require 'open-uri'

t       = Time.now
url     = 'http://whuface.com/page_top?r=' + (t.to_f * 1000).to_i.to_s
cookie  = 'g=female'
referer = 'http://whuface.com/'
_seq    = 1
_prefix = "#{t.mon}-#{t.day.to_s.rjust(2,'0')}-#{t.hour.to_s.rjust(2, '0')}-#{t.min.to_s.rjust(2, '0')}"

Nokogiri::HTML(open(url, 'Cookie' => cookie)).xpath("//img/@src").each do |src|
  File.open("#{_prefix}-#{_seq.to_s.rjust(2,'0')}-#{File.basename(src)}", 'wb') do |f| 
    begin
      puts "Downloading top #{_seq.to_s.rjust(2,' ')}: #{src}"
      f.write(open(src, "Referer" => referer).read)
    rescue
      puts 'err occurd'
    end
  end
  _seq+=1
end

puts 'DONE'
