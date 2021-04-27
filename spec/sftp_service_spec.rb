require '../sftp_service.rb'
require 'spec_helper.rb'

describe "Test SFTP Service" do

  after do
    File.delete("#{LOCAL_PATH}test.txt") if File.exist?("#{LOCAL_PATH}test.txt")
    File.delete("#{REMOTE_PATH}test.txt") if File.exist?("#{REMOTE_PATH}test.txt")
  end

  it "can upload a file to the remote FTP directory" do
    test_file = File.new("#{LOCAL_PATH}test.txt", "w")
    test_file.puts "TEST"
    test_file.close
    SftpService.new(host: HOST, username: USER, password: PASSWORD, from_path: "#{LOCAL_PATH}test.txt", to_path: "#{REMOTE_PATH}test.txt", action: 'upload').perform
    expect(File).to exist("#{REMOTE_PATH}test.txt")
  end

  it "can download a file from the remote FTP directory" do
    test_file = File.new("#{REMOTE_PATH}test.txt", "w")
    test_file.puts "TEST"
    test_file.close
    SftpService.new(host: HOST, username: USER, password: PASSWORD, from_path: "#{REMOTE_PATH}test.txt", to_path: "#{LOCAL_PATH}test.txt", action: 'download').perform
    expect(File).to exist("#{LOCAL_PATH}test.txt")
  end
end