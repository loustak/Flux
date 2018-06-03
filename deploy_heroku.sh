heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set POOL_SIZE=18
SECRET=mix phx.gen.secret
heroku config:set SECRET_KEY_BASE="${SECRET}"
GUARDIAN=mix phx.gen.secret
heroku config:set GUARDIAN_SECRET_KEY="${GUARDIAN}"
heroku run "POOL_SIZE=2 mix ecto.migrate"
echo Enter the url of the front end: 
read FRONT_URL
heroku config:set ALLOWED_ORIGIN="${FRONT_URL}"
echo You can now open the app