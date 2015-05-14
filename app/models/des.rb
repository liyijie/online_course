#http://www.oschina.net/code/snippet_164175_37994
#encoding: utf-8
class Des
  require 'openssl'
  require 'base64'

  ALG = 'DES-EDE3-CBC'
  KEY = 'uryeiyel'
  DES_KEY = 'uygbfs3w'

  class << self
    def encode(str)
      des = OpenSSL::Cipher::Cipher.new ALG
      des.pkcs5_keyivgen KEY, DES_KEY
      des.encrypt
      cipher = des.update str
      cipher << des.final
      Base64.urlsafe_encode64 cipher
    end

    def decode(str)
      str = Base64.urlsafe_decode64 str
      des = OpenSSL::Cipher::Cipher.new ALG
      des.pkcs5_keyivgen KEY, DES_KEY
      des.decrypt
      des.update(str) + des.final
    end
  end
end