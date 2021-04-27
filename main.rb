require_relative 'sftp_service.rb'

def main_program
  puts "SFTP CLI"
  action = set_action
  puts action
  puts "Enter destination host URL"
  host = gets.chomp
  puts "Enter the source (from) path, including the filename"
  from_path = gets.chomp
  puts "Enter the desination (to) path, including the filename"
  to_path = gets.chomp
  puts "Please confirm the info:"
  puts "Host: #{host} - #{action.capitalize} from #{from_path} to #{to_path}"
  initiate_file_transfer(host, from_path, to_path, action)
end

def set_action
  puts "Upload (1) or Download (2)? Hit Q to quit."
  valid = false
  while valid == false
    input = gets.chomp.downcase
    case input
    when "1" || "upload"
      valid = true
      return "upload"
    when "2" || "download"
      valid = true
      return "download"
    when "q" || "quit"
      puts "Exiting program..."
      exit
    else
      puts "Invalid input, please enter 1 for Upload or 2 for Download"
    end
  end
end

def initiate_file_transfer(host, from_path, to_path, action)
  puts "Hit any key to initiate file transfer, or Q to Quit"
  input = gets.chomp.downcase
  if input == "q"
    "Exiting program"
    exit
  else
    puts "Enter username"
    username = gets.chomp
    puts "Enter password"
    password = STDIN.getpass
    begin
      SftpService.new(host: host, username: username, password: password, from_path: from_path, to_path: to_path, action: action).perform
      puts "File transfer completed successfully"
    rescue => e
      puts "File transfer could not be completed. Errors: #{e}"
    end
  end
end

main_program