require 'active_record'
require './lib/task'
require './lib/list'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the To Do list!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      mark_done
    when 'e'
      exit
    else
      invalid
    end
  end
end

def add
  puts "What do you need to do?"
  task_name = gets.chomp
  task = Task.new(:name => task_name, :done => false)
  if task.save
    puts "'#{task_name}' has been added to your To Do List."
  else
    puts "That wasn't a valid task:"
    task.errors.full_messages.each {|message| puts message}
  end
end

def list
  puts "Here is everything you need to do:"
  tasks = Task.all
  tasks.not_done.each {|task| puts task.name}
end

def mark_done
  puts "Which of these tasks would you like to mark as done?"
  Task.all.each {|task| puts task.name}

  done_task_name = gets.chomp
  done_task = Task.where(:name => done_task_name).first
  done_task.update_attributes(:done => true)
end

welcome