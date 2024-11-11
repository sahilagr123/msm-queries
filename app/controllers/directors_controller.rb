class DirectorsController < ApplicationController
  def index
    render({ :template => "director_templates/list"})
  end

  def show
    the_id = params.fetch("the_id")

    @matching_records = Director.where({ :id => the_id })

    @the_director = @matching_records.at(0)
    render({ :template => "director_templates/details"})
  end

  def youngest
    
    dir = Director.where.not({ :dob => nil})
    
    @youngest_age = 1000
    @youngest = dir.at(0)

    year_now = Time.now.year
    month_now = Time.now.month
    day_now = Time.now.day

    #@youngest = dir.at(0)
    age = 0
    dir.all.each do |a_director|
      #calculate age
      age = year_now - a_director.dob.year
      if (month_now > a_director.dob.month)
        age = age + 1
      elsif (month_now = a_director.dob.month)
        if (day_now >= a_director.dob.day)
          age = age + 1
        end
      end

      #if age < youngest_age, then current director is youngest. 
      if (age < @youngest_age)
        @youngest_age = age
        @youngest = a_director
      end

      age = 0
    
    end

    render({ :template => "director_templates/youngest"})
  end

  def eldest
    render({ :template => "director_templates/eldest"})
  end
end
