1.
db.Seneca.insertOne({"first_name": "Sara", "last_name": "Stone", "email": "s_stone@gmail.com", "city": "Toronto", "status": "full-time", "gpa": 3.6, "program": "CPA"})
2.
db.Seneca.find()

db.Seneca.find().forEach(printjson)
3.
db.Seneca.deleteOne({"status": "full-time"})

db.Seneca.findOne({"first_name":"Sara"})
4.
studarray = [
{"_id": 1001, "first_name": "Sara", "last_name": "Stone", "email": "s_stone@gmail.com", "city": "Toronto", "status": "full-time", "gpa": 3.8, "program": "CPA"},
{"_id": 1002, "first_name": "Jack", "last_name": "Adam", "email": "j_adam@gmail.com", "city": "North York", "status": "part-time", "gpa": 3.6, "program": "CPA"}
]

db.student.insert(studarray)

BulkWriteResult({
"writeErrors" : [ ],
Lab7A Mongo part 1 query
"writeConcernErrors" : [ ],
"nInserted" : 2,
"nUpserted" : 0,
"nMatched" : 0,
"nModified" : 0,
"nRemoved" : 0,
"upserted" : [ ]
})

db.student.find()
5.
db.student.remove({})

6.
db.dropDatabase()
{ "ok" : 1 }
