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
   - DB_HOST: localhost
   - DB_PORT: 5434 (5432 if you're not using the docker-compose.yml file provided)

     The ABSTRACT_API_KEY is created by signing up Abstract's Geolocation API (no need input any cards, just sign up [here](https://www.abstractapi.com/api/ip-geolocation-api) and you get the key)

4. If there's no `database.yml` created, just use `database_sample.yml`, rename it to `database.yml`.

5. If you're using a Docker database, run `docker-compose up`. If not, can skip this step.

6. Run `rails db:create db:migrate`

7. Run `rails s`

### Deployment

I used [Render](https://render.com) to deploy my application. It provided me with the [documentation](https://render.com/docs/deploy-rails) needed to configure a PostgreSQL database with a Rails app before deployment.

The client-side application is hosted on Vercel and its repo can be accessed [here](https://github.com/amrllkmn/url-shortener-ui).
