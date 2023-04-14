# README

This is the URL Shortener API, offering these endpoints:

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
