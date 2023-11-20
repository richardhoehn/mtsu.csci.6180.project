# todo

## Server
* Work on the PUT (update) of the ticket 
    * Update the status by passing `ticketStatusId`
    * updte the `geoLocation` by passing `lng` and `lat`
    * Update the `problemTypeId`
* Implement adding the Picture
    * Handling the POST(ing) of the `form-data` from the mobile app
    * Save the picture to `/images/` folder, based on the `id` of the ticket. Expl: `./images/xxxx.png`
* Implement retrieving (`GET`) to Picture
    * Using `GET` -> `https://0.0.0.0/tickets/xxxx/images/` This will return a "link" to the image.
    * Retrun object like this: `{imageUrl: "http://images/xxxx.png"}`
    * ~True way of implemtnign this... is that you make this a redirect. using the reidect status code of a 301~

## App
* Ticket Screen
    * This includes displaying the location of the ticket's `geoLocation`
* Add Serach / Filter to PickUp Screen
* Screen to Take Picture
* Button to Set Location of a Ticket (Car)
* Button / Dropdown to Change Ticket Status
* Button / Dropdown to Change Problem Type
