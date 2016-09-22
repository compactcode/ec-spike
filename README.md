# Simulating large volumes of notficications being processed via sidekiq.

Sends SMS notifications using Twilio

## Setup

Add the following entries to your .env file:

```
TWILIO_SID='yoursid'
TWILIO_TOKEN='yourtoken'
TWILIO_NUMBER='yournumber'

```

Create the DB:

`rails db:create db:migrate`

## Generating Data

Import 50,000 fake records that take 100ms to process but send no notificaitons.

`rake import:customers`

Import 50,000 fake records with a list configured to send SMS notfications via twilio:

`rake 'import:customers[0402111222, 0431111222]'`

## Generating Events

Generate notification events for all records that have been created.

`rake import:events`

## Processing Events

Process the queue using a 100 threads.

`sidekiq -c 100`
