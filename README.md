# README

## Gems:
### 	ruby: 3.1.2
###	rails: 7.0.4.2
###	postgres: 1.1
###	puma: 5.0
###	view_component: 2.82
###	phonelib
###	pundit
###	devise
###	omniauth
###	omniauth-google-oauth2
###	rexml
###	brakeman
###	rubocop
###	rspec-rails

## Software dependencies:
###	docker v20
###	github
###	heroku cli
	
## Hardware dependencies: 
###	windows/linux machine

## Steps to setup docker and app:
###	-install docker for appropriate OS
###	-open the terminal (or powershell on windows) and run 
>		'docker pull paulinewade/csce431:latest'
###	-create a directory 'mk dir pmc'
###	-move to the directory 'cd pmc'
###	-run docker image 
###		ubuntu:
>			'docker run -it --volume "$(pwd):/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade/csce431:latest'
###		windows:
>			'docker run -it --volume "${PWD}:/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade/csce431:latest'
###	-download the app code on github and unzip within directory
###	-to install the ruby gems, run 
>		'bundle install'
###	-instantiate the database 
>		'rails db:create'
>		'rails db:migrate'
		
## Steps to reconnect to docker image:
###	-in the terminal (or powershell for windows), run
>		'docker start -ai (name of docker image)'
###		the name of the docker image can be found in the docker program
###	-then install gems by running
>		'bundle install'
		
## Steps to run tests:
###		-in the docker program, make sure the docker image is connected to
###	-in the terminal (or powershell on windows) go do the directory 
>		'cd pmc'
###	-to run all tests, use
>		'rails spec .'
###	-to run a specific integration test, run
>		'rspec ./spec/feature/(test file name here)'
###	-to run a specific unit test, run
>		'rspec ./spec/unit/(test file name here)'
		
## Heroku database:
###	-in the case of the database being completely cleaned out, install heroku cli
###	-in the terminal, run
>		'heroku login'
###	-access the heroku app by running
>	'heroku pg:psql -a pmc-attendance'
###	-To create a new admin in the terminal, run 
>		'INSERT INTO users(is_admin, is_staff, first_name, last_name, classification, skill_level, phone_number, email, created_at, updated_at)'
>		'Values(true,true, '(insert first name here)', '(insert last name here)', 'Senior', 'Advanced', '(phone number here)', '(insert tamu email here)', '(insert date ex: 2023-03-29)', '(insert date ex: 2023-03-29)');'
