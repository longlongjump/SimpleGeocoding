require 'json'

out_dir = ARGV[1] || '.'
input_filename = ARGV[0]

step = 30
(-180..180-step).step(step).each do |x|
  (-90..90-step).step(step).each do |y|
    bbox = [x,y,x+step,y+step]
    print "processing #{bbox.join(' ')}\n"
    out_filename = File.join(out_dir, "#{bbox.join('_')}.json")
    `rm #{out_filename}` if File.exists?(out_filename)
    `ogr2ogr  -nlt POLYGON -f "GeoJSON" -clipsrc #{bbox.join(' ')} #{out_filename} #{input_filename}`
  end
end
