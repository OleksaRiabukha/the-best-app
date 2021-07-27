# README

The scaffold Rails app for the internship project. 

- ruby 3.0.1
- rails 6.1.4 
- database PostgreSQL 
- RSpec for tests

### To launch app: 

- Ask owner about master key to decrypt credentials for database access 
- pull app from the github on your local machine
- create roles for postgres 
- amend credentials with your data with `EDITOR="code --wait" rails credentials:edit --environment development`. Do the same for the test environment
- run `rails s` in root folder
- you should be able to see a standard rails greeting after going to localhost:3000 in your browser
