# Write your sql queries in this file in the appropriate method like the example below:
# 
# def select_category_from_projects
# "SELECT category FROM projects;"
# end

# Make sure each ruby method returns a string containing a valid SQL statement.

def selects_the_titles_of_all_projects_and_their_pledge_amounts
  "SELECT title, SUM(amount) FROM (SELECT * FROM projects INNER JOIN pledges ON pledges.project_id = projects.id) GROUP BY title;"
  # merges projects and pledges on project_id 
  # this assumes each project has more than one pledge, so have to use SUM
end

def selects_the_user_name_age_and_pledge_amount_for_all_pledges
  "SELECT name, age, SUM(amount) FROM (SELECT * FROM users INNER JOIN pledges ON pledges.user_id = users.id) GROUP BY name;"
  # merges users and pledges on user_id
end

def selects_the_titles_of_all_projects_that_have_met_their_funding_goal
  "SELECT * FROM (SELECT title, funding_goal - SUM(amount) AS delta FROM (SELECT * FROM projects INNER JOIN pledges ON pledges.project_id = projects.id) GROUP BY title) WHERE delta <= 0;"
  # merges projects and pledges
  # selects both titles and delta from w/funding goal as per rspec -- this should have a different method name....
  # delta is difference between funding goal and amount raised 
  # inner join tables to have the sate => select title and set delta to create condition => select for deltas <= 0 
  # I initially did SUM(amount) - funding goal because that would give a positive number if goal is met, which makes more sense, but they are testing for a negative, so I switched it.
end

def selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount
  "SELECT name, SUM(amount) FROM (SELECT * FROM users INNER JOIN pledges ON pledges.user_id = users.id) GROUP BY name ORDER BY SUM(amount) ASC;"
  # merges users and pledges
  # I originally ordered just by amount, but it needed to be ordered by SUM of the amount
end

def selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category
  "SELECT category, amount FROM (SELECT * FROM projects INNER JOIN pledges on pledges.project_id = projects.id WHERE category = 'music');"
  # merges projects and pledges
end

def selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_book_category
  "SELECT category, SUM(amount) FROM (SELECT * FROM projects INNER JOIN pledges on pledges.project_id = projects.id WHERE category = 'books');"
  # merges projects and pledges 
end