require "securerandom"

def secure_token
  token_file = settings.root + "/.secret"
  if File.exist?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end