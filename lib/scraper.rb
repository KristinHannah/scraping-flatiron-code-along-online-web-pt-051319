require 'nokogiri'
require 'open-uri'
require "pry"
require_relative './course.rb'

class Scraper
  
    def get_page
    Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
    end 
    
    def get_courses 
      self.get_page.css("#course-grid .post")
    end 
    
    def make_courses
      changer = 1
      n = changer
     get_courses.each do |inst|
          n = Course.new
          n.title = inst.css("h2").text
          n.schedule = inst.css(".date").text
          n.description = inst.css("p").text
          changer += 1
      end
    end 
  
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
    end
  
end

Scraper.new.print_courses

