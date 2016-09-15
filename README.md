# Simulating large volumes of notficications being processed via sidekiq.

## Setup

`rails db:create db:migrate`

Import 50,000 records.

`rake import:data`

Generate up to 100,000 notification events for the records that have been created.

`rake import:events`

Process the queue using a 100 threads.

`sidekiq -c 100`
