# README

## Introduction ##

Our team is creating an application for the Parsons Mounted Cavalry (PMC) organization. This application will enable command staff to manage the schedules and attendances of their cadets and fellow staff. In addition, admins and command staff are able to keep records of all their horses, cadets, and staff. Both cadets and command staff have the ability to check in to any of their assigned attendances/events.

## Requirements ##

This code has been run and tested using the following internal and external components

### Environment
-	Ubuntu v22.04
-	Windows 10 or 11
-	Docker Engine v20.10.22
-	Heroku v7.53
-	Others

### Program
-	Ruby v3.1.2
-	Rails v7.0.4
-	Rspec-rails v6.0.1
-	PostgreSQL v14.4
-	Other Ruby gems & versions (listed in Gemfile)

### Tools
-	Git Hub - https://github.com/SP23-CSCE431/csce431-sprints-parsons-mounted-cavalry.git
-	RuboCop v1.50.2
-	Simplecov v0.22.0
-	Brakeman v5.4.1
-	Jira
-	Others

## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/

## Documentation

Our product and sprint backlog can be found in Jira, with project name ‘ParsonsMountedCavalry’

### Document
-	Data Design v5.0
-	UX Design v2.0
-	User’s Manual v1.0
-	Others

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/SP23-CSCE431/csce431-sprints-parsons-mounted-cavalry.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec`
  
You can run all the test cases by running. This will run both the unit and integration tests.
  
  `rspec .`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd csce431-sprints-parsons-mounted-cavalry`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`

  `cd rails_app`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app

  `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files ##

Google OAuth2 support requires two keys to function as intended: Client ID and Client Secret

Create a new file called application.yml in the /config folder and add the following lines:

  `GOOGLE_OAUTH_CLIENT_ID: 'YOUR_GOOGLE_OAUTH_CLIENT_ID_HERE'`

  `GOOGLE_OAUTH_CLIENT_SECRET: 'YOUR_GOOGLE_OAUTH_CLIENT_SECRET_HERE'`

## Deployment ##

- Setup a Heroku account: https://signup.heroku.com/

- From the heroku dashboard select `New` -> `Create New Pipeline`

- Name the pipeline, and link the respective git repo to the pipeline

- Our application does not need any extra options, so select `Enable Review Apps` right away

- Click `New app` under review apps, and link your test branch from your repo

- Under staging app, select `Create new app` and link your main branch from your repo

--------
#### Changing the Timezone
If you notice that all the times are a few hours off while using the app, it is likely that the timezone set within the Heroku environment is incorrect.To fix this, you must add an environment variable.

To add environment variables to enable the proper time zone, head over to the settings tab on the pipeline dashboard

- Scroll down until `Reveal config vars`

- Add your time zone, with field `TZ` and value of your time zone. For example. If in CDT time, use `America/Chicago` as your `TZ` value.

- Now once your pipeline has built the apps, select `Open app` to open the app

- With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production`

And now your application is setup and in production mode!

--------
#### Google OAuth2 Functionality 

In the event that the URI’s for Google OAuth expire, you will need to update the secret and client ids.

- If you need to create secret and client ids, the following can be found here `https://medium.com/@adamlangsner/google-oauth-rails-5-using-devise-and-omniauth-1b7fa5f72c8e`
- Navigate to environment folder `../config/environments`
- In the environments folder find the file you wish to update (ex: if working with the production app, navigate to production.rb)
- At the bottom of the file replace the old ids with your client id and your secret id, with fields `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` respectively

--------
#### Transferring Ownership of the App on Heroku

In the event that the current owner of the application is leaving the organization, you will need to transfer the ownership of the app to the newly-chosen owner’s Heroku account.

- The new owner must have a Heroku account.
- Setup a Heroku account: https://signup.heroku.com/
- Note: the new owner must be able to pay ~$10 per month to continue running the app through their account
- Follow this documentation on how to transfer the app’s ownership on Heroku. Please see the section “Transfer an App with the Dashboard” and make sure to do this from the current owner’s account: https://devcenter.heroku.com/articles/transferring-apps
- The new owner must accept the transfer of ownership from their account to complete this process.

--------

#### Repopulating Heroku Database
In the event the heroku database is empty, you can run the following commands in the terminal to insert someone into the database:

 `heroku login`

 `heroku pg:psql -a pmc-attendance`

 `INSERT INTO users(is_admin, is_staff, first_name, last_name, classification, skill_level, phone_number, email, created_at, updated_at)`

 `Values(true, true, '(insert first name here)', '(insert last name here)', 'Senior', 'Advanced', '(insert phone number here)', '(insert tamu email here)', '(insert date ex: 2023-03-29)', '(insert date ex: 2023-03-29)');`
	
## CI/CD ##

For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated.

  `Review app: test branch`

  `Production app: main branch`

For continuous integration, we set up a Github action to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended.

## References ##

- https://www.bootrails.com/blog/rails-pundit-tutorial/
- https://medium.com/@adamlangsner/google-oauth-rails-5-using-devise-and-omniauth-1b7fa5f72c8e
- http://jsfiddle.net/Guffa/57gQa/
- https://developer.mozilla.org/en-US/docs/Web/API/Geolocation/getCurrentPosition
- https://www.w3schools.com/html/html5_geolocation.asp
- https://www.youtube.com/watch?v=cAEzzpvm43Y
- https://blog.corsego.com/export-from-database-to-excel
- https://www.youtube.com/watch?v=E_8BBAvVCqw
## Support ##

Users looking for help should reference the application help page.
Admins looking for help should reference the admin guide that should have been given to them.
