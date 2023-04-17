# README

This is the URL Shortener API, offering these endpoints:

### Endpoints

1. `POST /shorten`
   - Request body:
   ```json
   {
     "url": "target_url",
     "slug": "string" // This is optional
   }
   ```
   - Response:
   ```json
   {
     "message": "Created",
     "short_url": "http://localhost:3000/1431cf"
   }
   ```
2. `GET  /:slug`
   - Params:
   ```json
       slug: "The generated string from POST /shorten"
   ```
   - Response: Redirected to target url
3. `GET  /:id/report`
   - Params:
   ```json
       id: "The id of the generated url"
   ```
   - Response:
     ```json
     {
       "id": 2,
       "target_url": "https://www.wikipedia.com",
       "slug": "1431cf",
       "created_at": "2023-04-14T14:13:12.727Z",
       "updated_at": "2023-04-14T14:13:12.727Z",
       "times_clicked": 0,
       "click_timestamp": {},
       "origin": [],
       "short_url": "http://localhost:3000/1431cf"
     }
     ```
4. `GET  /urls/analytics`
   - Response:
     ```json
         "data": [
         {
             "id": 2,
             "target_url": "https://www.wikipedia.com",
             "slug": "1431cf",
             "created_at": "2023-04-14T14:13:12.727Z",
             "updated_at": "2023-04-14T14:13:12.727Z",
             "times_clicked": 0,
             "click_timestamp": {},
             "origin": [],
             "short_url": "http://localhost:3000/1431cf"
         },
         ...
         ]
     ```

### Setup

1. Use ruby 2.7.5 for this app.
2. Run `bundle install`.
3. Create an application.yml, with these values:

   - DB_USERNAME: YOUR_USERNAME
   - DB_PASSWORD: YOUR_PASSWORD
   - ABSTRACT_API_KEY: YOUR_ABSTRACT_API_KEY
   - HOST_URL: http://localhost:3000

     The ABSTRACT_API_KEY is created by signing up Abstract's Geolocation API (no need input any cards, just sign up [here](https://www.abstractapi.com/api/ip-geolocation-api) and you get the key)

4. If you're using a Docker database (through running `docker-compose up`), comment the username like this on `database.yml`:
   ```yml
   default: &default
   adapter: postgresql
   encoding: unicode
   host: localhost
   # username: <%= ENV["DB_USERNAME"] %>
   ```
5. Run `rails db:create db:migrate`

6. Run `rails s`
