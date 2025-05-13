[//]: # (######################################################)
[//]: # (#                                                    #)
[//]: # (#            MongoDB - AirBnB - Solutions            #)
[//]: # (#                                                    #)
[//]: # (######################################################)

[//]: # (@author      Christian Locher <locher@faithpro.ch>)
[//]: # (@copyright   2025 Faithful programming)
[//]: # (@license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3)
[//]: # (@version     2025-05-13)

# MongoDB-AirBnB-Solutions

## Simple tasks

01. Count the number of all entries
> only works in MongoSH
db.listings.countDocuments()
> or (only the upper form is used for further solutions)
db["listings"].countDocuments()

02. Show all entries with room type “Private room”
{ room_type: "Private room" }
db.listings.find({ room_type: "Private room" })

03. List all unique room types
> only works in MongoSH
db.listings.distinct("room_type")

04. Showing entries with the word "luxury" in the name
{ name: /luxury/i }
db.listings.find({ name: /luxury/i })

05. Show all entries with a price under USD 100
{ price: { $lt: 100 } }
db.listings.find({ price: { $lt: 100 } })

06. Show entries with a rating of at least 4.5
{ review_scores_rating: { $gte: 4.5 } }
db.listings.find({ review_scores_rating: { $gte: 4.5 } })

07. Sort entries by price in ascending order
> only works in MongoSH
db.listings.find().sort({ price: 1 })

08. Show all entries with a price below USD 100, displaying only the name and price in each case
{ price: { $lt: 100 } }, { name: 1, price: 1, _id: 0 }
db.listings.find({ price: { $lt: 100 } }, { name: 1, price: 1, _id: 0 })

## Moderately difficult tasks

09. Show the first 5 entries with the highest rating (empty ratings must be filtered out)
> only works in MongoSH
db.listings.find({ review_scores_rating: { $ne: '' } }).sort({ review_scores_rating: -1 }).limit(5)

10. Calculate average price per room type
> only works in MongoSH
db.listings.aggregate([ { $group: { _id: "$room_type", averagePrice: { $avg: "$price" } } } ])

11. Calculate average price of all entries
> only works in MongoSH
db.listings.aggregate([ { $group: { _id: null, avgPrice: { $avg: "$price" } } } ])

12. Count the number of entries per room type
> only works in MongoSH
db.listings.aggregate([ { $group: { _id: "$room_type", count: { $sum: 1 } } } ])

## Challenging tasks

13. Show entries with at least the following features: "Wifi", "Hot tub", "Lake access"
{ amenities: { $all: ["Wifi", "Hot tub", "Lake access"] } }
db.listings.find({ amenities: { $all: ["Wifi", "Hot tub", "Lake access"] } })

14. Show entries with at least the following equipment feature: "Wifi" and at least one of the two equipment features: "Hot tub" or "Lake access"
{ amenities: { $all: ["Wifi"], $in: ["Hot tub", "Lake access"] } }
db.listings.find({ amenities: { $all: ["Wifi"], $in: ["Hot tub", "Lake access"] } })
> or
{ $and: [ { amenities: "Wifi" }, { amenities: { $in: ["Hot tub", "Lake access"] } } ] }
db.listings.find({ $and: [ { amenities: "Wifi" }, { amenities: { $in: ["Hot tub", "Lake access"] } } ] })

15. Show top 5 hosts with the most entries
> only works in MongoSH
db.listings.aggregate([ { $group: { _id: "$host_id", count: { $sum: 1 } } }, { $sort: { count: -1 } }, { $limit: 5 } ])


16. Sort entries with a rating above the average in descending order
> only works in MongoSH
const avgReviewScore = db.listings.aggregate([ { $group: { _id: null, averageReviewScore: { $avg: "$review_scores_rating" } } } ]).toArray()[0].averageReviewScore;
db.listings.find({ review_scores_rating: { $gt: avgReviewScore } }).sort({ review_scores_rating: -1 })
