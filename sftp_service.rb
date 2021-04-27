class SftpService
  require 'net/sftp'

  def initialize(args={})
    @host = args[:host]
    @username = args[:username]
    @password = args[:password]
    @from_path = args[:from_path]
    @to_path = args[:to_path]
    @action = args[:action]
  end

  def perform
    Net::SFTP.start(@host, @username, password: @password) do |sftp|
      sftp.send("#{@action}!", @from_path, @to_path)
    end
  end
end