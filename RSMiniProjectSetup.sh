#Here is the script to setup this rails app, have to associate join tables by has many through, and remove foregin keys to avoid non-existed items in the given data.
rails new RSMiniProject -G -T -B --database=postgresql
cp problems/*csv RSMiniProject/
echo "gem 'rspec-rails'" >> RSMiniProject/Gemfile
echo "gem 'dotenv-rails'" >> RSMiniProject/Gemfile
echo "gem 'bcrypt'" >> RSMiniProject/Gemfile
echo "gem 'devise'" >> RSMiniProject/Gemfile
echo "gem 'activeadmin', github: 'activeadmin'" >> RSMiniProject/Gemfile
#echo "gem 'jquery-datatables-rails'" >> RSMiniProject/Gemfile
echo ".env" >> RSMiniProject/.gitignore
echo "*.csv" >> RSMiniProject/.gitignore
cd RSMiniProject && bundle install
# rails generate scaffold Admin username password
rails generate model User name
rails generate model Item name
rails generate model Category name
rails generate model Categories_Item category:references item:references
rails generate model Items_User item:references user:references
rails generate controller Items index show

# rails generate devise Admin
rake db:create
rake db:migrate
rails generate active_admin:install
# rails generate devise:install and model is no longer required because active_admin invoked devise installation
rake db:migrate