# README

This is an implementation of the code challenge

# Installation

- you would need to set the ruby version to `3.1.2`
- the project uses bundler `2.3.26`
- run `bundle install` to install all the dependencies

# Task 1

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

- you would need to register at [gender api](https://gender-api.com) to get an api key that you will insert into `.env` under name GENDER_API_AUTHENTICATION_TOKEN
- run the server `bundle exec rails server`
- use `curl` or any other alternative to access the country_guess endpoint

Curl example:
```
curl http://127.0.0.1:3000/country_guess\?name\=Cherednichenko%20Oleh
```

`%20` is encoded space character.

Responce example:
```
{"full_name":"Cherednichenko Oleh","guessed_country":["UA","SI","CZ","PT","ID","ES","IT"],"time_processed":0.200372}
```

# Task 2

Task “The Calculator”
Write a small web-service which offers the following functionality: for a given arithmetic expression (Integer Numbers and the operators +-*/), the service should respond to the result of the expression.
The request will be using GET, providing the parameter “expression”, e.g. - curl “http://calculator?expression=3*4”
The response format should be JSON and including two keys:
- expression: [echo the given expression]
- result: [computed result of the expression]
Any (plausible) way of getting a correct result is fine
Of course our service should be secure (and fast if possible)
If you want to support more than the basic operations, feel free to have them in as well ;)

# Implementation

I decided not to use ruby method `eval` to implement this calculator because `eval` is known to be not the best practice because it creates a security bridge. Instead i am using RecursiveCalculatingService service.

# Usage

- run the server `bundle exec rails server`
- use `curl` or any other alternative to access the calculator endpoint

Curl examples:
```
curl http://127.0.0.1:3000/calculator\?expression\=2\*2

curl http://127.0.0.1:3000/calculator\?expression\=2-2

curl http://127.0.0.1:3000/calculator\?expression\=2/2

curl http://127.0.0.1:3000/calculator\?expression\=2%2B2
```

`%2B` is URL encoded + character.

Responce examples:
```
{"expression":"2*2","result":4}

{"expression":"2-2","result":0}

{"expression":"2/2","result":1}

{"expression":"2+2","result":4}
```
