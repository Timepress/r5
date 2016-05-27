module Odin

  def gsub filename, options={}, &block
    puts options[:log] if options[:log]
    fr = File.new(filename)
    content = fr.read
    fr.close
    change = content.clone
    block.call change
    unless content==change
      fw = File.new filename, 'w'
      fw.write change
      fw.close
    end
  end

  def sub filename, mark, part, options={}
    File.open(filename) do |f|
      content = f.read
      if options[:global]
        change = content.gsub mark, part
      else
        change = content.sub mark, part
      end
      unless change==content
        file filename, change
      end
    end
  end

  def content filename
    File.open(filename).read
  end

  def concat filename, part
    File.open(filename) do |f|
      content = f.read
      file filename, content + part
    end
  end

  def file filename, content
    File.open(filename, 'w') do |f|
      f.write content
    end
  end

  def cp from, to
    system "cp #{from} #{to}"
  end
  def rm what
    system "rm #{what}"
  end

  def cp_template template_dir, path
    cp "#{template_dir}/#{path}", path
  end

  def rake task
    system "rake #{task}"
  end

  def rails task
    system "rails #{task}"
  end

  def git task
    system "git #{task}"
  end

  def bundle task=''
    system "bundle #{task}"
  end

end

