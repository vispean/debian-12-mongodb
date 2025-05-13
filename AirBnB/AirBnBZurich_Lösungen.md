[//]: # (######################################################)
[//]: # (#                                                    #)
[//]: # (#            MongoDB - AirBnB - Lösungen             #)
[//]: # (#                                                    #)
[//]: # (######################################################)

[//]: # (@author      Christian Locher <locher@faithpro.ch>)
[//]: # (@copyright   2025 Faithful programming)
[//]: # (@license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3)
[//]: # (@version     2025-05-13)

# MongoDB-AirBnB-Lösungen

## Einfache Aufgaben

01. Anzahl aller Einträge zählen
> funktioniert nur in der MongoSH
db.listings.countDocuments()
> oder (für weitere Lösungen wird nur die obere Form verwendet)
db["listings"].countDocuments()

02. Alle Einträge mit dem Zimmertyp "Private room" anzeigen
{ room_type: "Private room" }
db.listings.find({ room_type: "Private room" })

03. Alle eindeutigen Zimmertypen auflisten
> funktioniert nur in der MongoSH
db.listings.distinct("room_type")

04. Einträge mit dem Wort "luxury" im Namen anzeigen
{ name: /luxury/i }
db.listings.find({ name: /luxury/i })

05. Alle Einträge mit einem Preis unter 100 USD anzeigen
{ price: { $lt: 100 } }
db.listings.find({ price: { $lt: 100 } })

06. Einträge mit einer Bewertungen von mindestens 4.5 anzeigen
{ review_scores_rating: { $gte: 4.5 } }
db.listings.find({ review_scores_rating: { $gte: 4.5 } })

07. Einträge nach Preis aufsteigend sortieren
> funktioniert nur in der MongoSH
db.listings.find().sort({ price: 1 })

08. Alle Einträge mit einem Preis unter 100 USD anzeigen, dabei jeweils nur den Namen und den Preis auszugeben
{ price: { $lt: 100 } }, { name: 1, price: 1, _id: 0 }
db.listings.find({ price: { $lt: 100 } }, { name: 1, price: 1, _id: 0 })

## Mittelschwere Aufgaben

09. Die ersten 5 Einträge mit der höchsten Bewertung anzeigen (leere Bewertungen müssen weggefiltert werden)
> funktioniert nur in der MongoSH
db.listings.find({ review_scores_rating: { $ne: '' } }).sort({ review_scores_rating: -1 }).limit(5)

10. Durchschnittlicher Preis pro Zimmertyp berechnen
> funktioniert nur in der MongoSH
db.listings.aggregate([ { $group: { _id: "$room_type", averagePrice: { $avg: "$price" } } } ])

11. Durchschnittlicher Preis aller Einträge berechnen
> funktioniert nur in der MongoSH
db.listings.aggregate([ { $group: { _id: null, avgPrice: { $avg: "$price" } } } ])

12. Anzahl der Einträge pro Zimmertyp zählen
> funktioniert nur in der MongoSH
db.listings.aggregate([ { $group: { _id: "$room_type", count: { $sum: 1 } } } ])

## Anspruchsvolle Aufgaben

13. Einträge mit mindestens den folgenden Ausstattungsmerkmalen: "Wifi", "Hot tub", "Lake access" anzeigen
{ amenities: { $all: ["Wifi", "Hot tub", "Lake access"] } }
db.listings.find({ amenities: { $all: ["Wifi", "Hot tub", "Lake access"] } })

14. Einträge mit mindestens dem folgenden Ausstattungsmerkmal: "Wifi" und mindestens einem der beiden Austattungsmerkmalen: "Hot tub" oder "Lake access" anzeigen
{ amenities: { $all: ["Wifi"], $in: ["Hot tub", "Lake access"] } }
db.listings.find({ amenities: { $all: ["Wifi"], $in: ["Hot tub", "Lake access"] } })
> oder
{ $and: [ { amenities: "Wifi" }, { amenities: { $in: ["Hot tub", "Lake access"] } } ] }
db.listings.find({ $and: [ { amenities: "Wifi" }, { amenities: { $in: ["Hot tub", "Lake access"] } } ] })

15. Top 5 Gastgeber mit den meisten Einträgen anzeigen
> funktioniert nur in der MongoSH
db.listings.aggregate([ { $group: { _id: "$host_id", count: { $sum: 1 } } }, { $sort: { count: -1 } }, { $limit: 5 } ])


16. Einträge mit einer Bewertung über dem Durchschnitt absteigend sortieren
> funktioniert nur in der MongoSH
const avgReviewScore = db.listings.aggregate([ { $group: { _id: null, averageReviewScore: { $avg: "$review_scores_rating" } } } ]).toArray()[0].averageReviewScore;
db.listings.find({ review_scores_rating: { $gt: avgReviewScore } }).sort({ review_scores_rating: -1 })
