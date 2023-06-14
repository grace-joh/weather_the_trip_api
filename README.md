<h1 align="center">Weather the Trip</h1>

## About

Weather the Trip is a REST API that allows users to plan road trips. Users can see the current weather, a five day forecast, and a 24-hour forecast of the current day. Users can also create a roadtrip and will be provided the forecasted weather at their destination. This project was completed as a solo project for Turing School of Software and Design's Back End Engineering Program, Module 3. 

### Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## Built with

* Ruby on Rails v 7.0.4
* Ruby v 3.1.1
* PostgreSQL
* Postman
* Visual Studio Code
* Miro

## Getting Started

### Installation

In your terminal:
1. Fork and clone the repository locally `git clone git@github.com:grace-joh/weather_the_trip_api.git`
1. Navigate into the directory `cd weather_the_trip_api`
1. Install gem packages: `bundle install`
1. Setup the database: `rails db:{create,migrate}`

External APIs:
1. Apply for an API key with 
    * [Mapquest](https://developer.mapquest.com/user/login/sign-up) 
    * [Weather API](https://www.weatherapi.com/signup.aspx)
    * [Geonames API](https://www.geonames.org/login)

1. Run `bundle exec figaro install` and add the API keys to the `./config/application.yml` file.

    ```
    # ./config/application.yml
    MAPQUEST_API_KEY: <your key here>
    WEATHER_API_KEY: <your key here>
    GEONAMES_API_KEY: <your username here>
    ```

### Testing

To run all tests from your command line:
* run `bundle exec rspec`

All tests should be passing. Happy and sad path cases were accounted for and tested for each [endpoint](##endpoints).

To test the endpoints:
* In your terminal, run `rails s` to start a local server.
* Use an API platform like [Postman](https://app.getpostman.com/run-collection/26085409-1cb627ef-d500-4f6f-b849-9b655205c7ed?action=collection%2Ffork&collection-url=entityId%3D26085409-1cb627ef-d500-4f6f-b849-9b655205c7ed%26entityType%3Dcollection%26workspaceId%3Df402ed1d-531c-4451-ad21-b6367689bff9) or a REST API client extension like [Thunder Client](https://www.thunderclient.io/).

## Endpoints


### GET `/api/v0/forecast?location=dallas,tx`
  <details><summary>Request</summary>
    * Send the location as a query parameter
  </details>

  <details><summary>Response</summary>
    <pre>
      <code>
        {
          "data": {
              "id": null,
              "type": "forecast",
              "attributes": {
                  "current_weather": {
                      "last_updated": "2023-06-14 10:30",
                      "temperature": 79.0,
                      "feels_like": 85.1,
                      "humidity": 90,
                      "uvi": 6.0,
                      "visibility": 2.0,
                      "condition": "Light drizzle",
                      "icon": "cdn.weatherapi.com/weather/64x64/day/266.png"
                  },
                  "daily_weather": [
                      {
                          "date": "2023-06-15",
                          "sunrise": "06:18 AM",
                          "sunset": "08:37 PM",
                          "max_temp": 101.1,
                          "min_temp": 75.2,
                          "condition": "Patchy rain possible",
                          "icon": "cdn.weatherapi.com/weather/64x64/day/176.png"
                      },
                      ... days 2 to 4 ...,
                      {
                          "date": "2023-06-19",
                          "sunrise": "06:19 AM",
                          "sunset": "08:38 PM",
                          "max_temp": 98.4,
                          "min_temp": 73.9,
                          "condition": "Sunny",
                          "icon": "cdn.weatherapi.com/weather/64x64/day/113.png"
                      }
                  ],
                  "hourly_weather": [
                      {
                          "time": "00:00",
                          "temperature": 77.0,
                          "conditions": "Patchy light rain with thunder",
                          "icon": "cdn.weatherapi.com/weather/64x64/night/386.png"
                      },
                      {
                          "time": "01:00",
                          "temperature": 76.1,
                          "conditions": "Patchy light rain with thunder",
                          "icon": "cdn.weatherapi.com/weather/64x64/night/386.png"
                      },
                      {
                      ... hours 2 to 22 ...,
                      {
                          "time": "23:00",
                          "temperature": 80.8,
                          "conditions": "Light rain shower",
                          "icon": "cdn.weatherapi.com/weather/64x64/night/353.png"
                      }
                  ]
              }
          }
      }
      </code>
    </pre>
  </details>

### POST `/api/v0/users`
<details><summary>Request</summary>
  <pre>
    <code>
    {
        "email": "weather_the_trip@api.com",
        "password": "vacationtime!",
        "password_confirmation": "vacationtime!"
    }
    </code>
  </pre>
</details>

<details><summary>Response</summary>
  <pre>
    <code>
    {
        "data": {
            "id": "1",
            "type": "users",
            "attributes": {
                "email": "weather_the_trip@api.com",
                "api_key": "mVc536E2Gp4CLyVmd6hPmfak71fgqcsD"
            }
        }
    }
    </code>
  </pre>
</details>

### POST 'api/v0/sessions'

<details><summary>Request</summary>
  <pre>
    <code>
    {
        "email": "weather_the_trip@api.com",
        "password": "vacationtime!"
    }
    </code>
  </pre>
</details>

<details><summary>Response</summary>
  <pre>
    <code>
    {
        "data": {
            "id": "1",
            "type": "users",
            "attributes": {
                "email": "weather_the_trip@api.com",
                "api_key": "mVc536E2Gp4CLyVmd6hPmfak71fgqcsD"
            }
        }
    }
    </code>
  </pre>
</details>

### POST `/api/v0/road_trip`

<details><summary>Request for a Possible Route</summary>
  <pre>
    <code>
    {
        "origin": "dallas,tx",
        "destination": "denver, co",
        "api_key": "mVc536E2Gp4CLyVmd6hPmfak71fgqcsD"
    }
    </code>
  </pre>
</details>

<details><summary>Response for a Possible Route</summary>
  <pre>
    <code>
    {
        "data": {
            "id": null,
            "type": "road_trip",
            "attributes": {
                "start_city": "dallas, tx",
                "end_city": "denver,co",
                "travel_time": "11:17:25",
                "weather_at_eta": {
                    "datetime": "2023-06-14 11:00",
                    "temperature": 51.6,
                    "conditions": "Partly cloudy"
                }
            }
        }
    }
    </code>
  </pre>
</details>

<details><summary>Request for an Impossible Route</summary>
  <pre>
    <code>
    {
        "origin": "dallas,tx",
        "destination": "South Korea",
        "api_key": "mVc536E2Gp4CLyVmd6hPmfak71fgqcsD"
    }
    </code>
  </pre>
</details>

<details><summary>Response for an Impossible Route</summary>
  <pre>
    <code>
    {
        "data": {
            "id": null,
            "type": "road_trip",
            "attributes": {
                "start_city": "dallas, tx",
                "end_city": "South Korea",
                "travel_time": "impossible route",
                "weather_at_eta": {}
            }
        }
    }
    </code>
  </pre>
</details>

## Database Schema


## Looking Forward
Currently, Weather the Trip completes the requirements for the project as described here. My next steps for this project includes:
* Weather Features
  * Exposing an endpoint that allows users to see the forecasted weather at multiple stops throughout their trip.
  * Allowing users to choose the units of measurement for the weather.
* Road Trip Features
  * Exposing an endpoint that allows users to save road trips to their account.
  * Exposing an endpoint that allows users to see their saved road trips.
  * Exposing an endpoint that allows users to delete their saved road trips.
  * Exposing an endpoint that allows users to update their saved road trips.
* Refactoring
  * Refactoring the API consumption to be more DRY.
  * Exploring Redis for caching for the API consumption.

## About the Developer

* Grace Joh - [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/grace-joh)