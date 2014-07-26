# encoding: utf-8
module SecureRandom

  def self.uuid_short
    ary = self.random_bytes(16).unpack("NnnnnN")
    ary[2] = (ary[2] & 0x0fff) | 0x4000
    ary[3] = (ary[3] & 0x3fff) | 0x8000
    "%08x%04x%04x%04x%04x%08x" % ary
  end

end