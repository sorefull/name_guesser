# README

This is an implementation of the code challenge

# Task

Task “The Name Guesser”
Write a small web-service which offers the following functionality: for a given last name
(surname), the service should respond with the country it's most likely to come from. The request will be using GET, proving the parameter “name”, e.g.
- curl “http://country_guess?name=Müller”
The response format should be JSON and including three keys:
- guessed_country: [DE, US, NL, ...]
- requested_name: [echo name parameter]
- time_processed: [time passed by while guessing the country]

Any (plausible) way of guessing the country is okay (e.g. heuristic, database, external web-service, whatever :))
Of course our service should be secure (and fast if possible)

# Implementation

I found a service gender-api that offers an api that based on the name can predict the nationality, gender and some other information. Sadly it does not work only for last name, a first name or a full name should be passed.

# Usage

- you would need to set the ruby version to `3.1.2`
- the project uses bundler `2.3.26`
- run `bundle install` to install all the dependencies
- you would need to register at [gender api](https://gender-api.com) to get an api key that you will insert into `.env`, you can also use my free key that is already there
- run the server `bundle exec rails server`
- use `curl` or any other alternative to access the country_guess endpoint

Curl example:
```
curl http://127.0.0.1:3000/country_guess\?name\=Cherednichenko%20Oleh
```

Responce example:
```
{"full_name":"Cherednichenko Oleh","guessed_country":["UA","SI","CZ","PT","ID","ES","IT"],"time_processed":0.200372}
```
