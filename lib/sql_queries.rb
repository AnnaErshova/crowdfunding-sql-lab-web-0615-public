# users <= pledges => projects
# projects.id == pledges.project_id 
# pledges.user_id = users.id 

def selects_the_titles_of_all_projects_and_their_pledge_amounts
  "SELECT projects.title, SUM(pledges.amount) 
    FROM projects INNER JOIN pledges 
       ON pledges.project_id = projects.id
        GROUP BY projects.title;"
  # merges projects and pledges on project_id 
  # this assumes each project has more than one pledge, so have to use SUM
end

def selects_the_user_name_age_and_pledge_amount_for_all_pledges
  "SELECT users.name, users.age, SUM(pledges.amount) 
    FROM users INNER JOIN pledges 
      ON pledges.user_id = users.id 
        GROUP BY users.name;"
  # merges users and pledges on user_id
end

def selects_the_titles_of_all_projects_that_have_met_their_funding_goal
  "SELECT * FROM 
    (SELECT projects.title, projects.funding_goal - SUM(pledges.amount) AS delta 
      FROM projects INNER JOIN pledges 
        ON pledges.project_id = projects.id 
          GROUP BY title) WHERE delta <= 0;"
  # merges projects and pledges
  # selects both titles and delta from w/funding goal as per rspec -- this should have a different method name....
  # delta is difference between funding goal and amount raised 
  # inner join tables to have the sate => select title and set delta to create condition => select for deltas <= 0 
  # I initially did SUM(amount) - funding goal because that would give a positive number if goal is met, which makes more sense, but they are testing for a negative, so I switched it.
end

def selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount
  "SELECT users.name, SUM(pledges.amount) 
    FROM users INNER JOIN pledges 
      ON pledges.user_id = users.id 
        GROUP BY users.name 
          ORDER BY SUM(pledges.amount);"
  # merges users and pledges
  # I originally ordered just by amount, but it needed to be ordered by SUM of the amount
end

def selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category
  "SELECT projects.category, pledges.amount 
    FROM projects INNER JOIN pledges 
      ON pledges.project_id = projects.id 
        WHERE projects.category = 'music';"
  # merges projects and pledges
end

def selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_book_category
  "SELECT projects.category, SUM(pledges.amount) 
    FROM projects INNER JOIN pledges 
      ON pledges.project_id = projects.id 
        WHERE projects.category = 'books';"
  # merges projects and pledges 
end

