# encoding: utf-8
module EXIF

  class Degrees
    @degrees

    # "51, 59.37, 0" => [51, 59.37, 0]
    def initialize(str)
      @degrees = str.split(",").map(&:to_f)
    end

    def to_f
      @degrees.reduce { |m,v| m * 60 + v}.to_f / 3600
    end
  end


  class << self

    def degrees(degrees, ref)
      Degrees.new(degrees).to_f * ((ref == "S" || ref == "W") ? -1 : 1) rescue nil
    end

    # "2013:05:26 15:39:48" => 2013-05-26 15:39:48 +0800
    def time(str)
      str =~ /^(\d{4}):(\d\d):(\d\d) (\d\d):(\d\d):(\d\d)$/
      Time.mktime($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i) rescue nil
    end

    # "f/2.4" => 2.4
    def f_number(val)
      return nil if val.blank?
      val.gsub('f','').gsub('/','').to_f rescue nil
    end

    # "4.3 mm" => 4.3
    def focal_length(val)
      return nil if val.blank?
      val.gsub('mm','').to_f rescue nil
    end

    # "1/1042 sec." => "1/1042"
    def exposure_time(val)
      val.gsub('sec.', '').strip unless val.blank?
    end

  end

end