#!/bin/bash
echo "Restarting services"

export RAILS_ENV="development"

rake db:create
rake db:migrate
rake db:seed
rake swagger:docs
bundle exec rails server -b 0.0.0.0

echo "Done!"