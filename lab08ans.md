Question 2 In the employees collection, using Mongo query display all the employee ids and emails.
db.employees.find({},{"employee_id": 1, "email" : 1})

Question 3 In the product collection, display all the product id, product name and list price
db.products.find({},{"product_id": 1, "product_name": 1, "list_price": 1})

Question 4 In the employees collection, using Mongo query display all the employee ids, emails and manager id whose manger ids are 1,3,9.
db.employees.find({manager_id: { $in: [1, 3, 9]}}, {_id: 0, employee_id: 1, email: 1, manager_id: 1})

Question 5 In the product collection, display all the product id, product name and list price whose list price are in range between 400 to 500
db.products.find({"list_price": { $gte: 400, $lte: 500}},{_id:1, product_id:1, product_name:1, list_price:1})

Question 6 In the employees collection, using Mongo query display all the employee ids, hire date and first name who are hired in August 2016.
db.employees.find({"hire_date": {$gte: ISODate("2016-08-01"), $lte: ISODate("2016-08-31")}}, {_id: 0, employee_id: 1, hire_date: 1, first_name: 1})

Question 7 In the product collection, display all the product id, product name and standard cost whose standard cost are NOT in the range between 700 to 800
db.products.find({$or: [{"standard_cost": {$lt: 700}}, {"standard_cost": {$gt: 800}}]}, {product_id:1, product_name:1, standard_cost:1})

Question 8 In the employees collection, using Mongo query display all the data except email, phone and job title.
db.employees.find({},{phone: 0, email: 0, job_title: 0})

Question 9 In the product collection, display all the product id, product name and standard cost where products are in the list of ids (5,8,9,30,50,70,80) or the list price is above 1000
db.products.find({ $or: [{"product_id":{$in: [5, 8, 9, 30, 50, 70, 80] }},{"list_price": {$gt: 1000}}]},{product_id:1, product_name:1, standard_cost:1})

Question 10 In the employees collection, using Mongo query display all the data that has null values.
db.employees.find({"manager_id": "NULL"})

Question 11 In the product collection, update product ids 1,3 and 5 to have a new key/value pair quantity as 100 and their new list price as 1000, once updated display those product ids,product name and list price
db.products.replaceOne({ product_id: 1 }, { "product_id":1,"product_name" : "G.Skill Ripjaws V Series","description" : "Speed:DDR4-3000,Type:288-pin DIMM,CAS:15Module:8x8GBSize:64GB","standard_cost" : 450.36,"list_price" : 1000,"category_id" : 5, "quantity": 100})
db.products.replaceOne({ product_id: 3 }, { "product_id":3,"product_name" : "Corsair CB-9060011-WW","description" : "Chipset:GeForce GTX 1080 Ti,Memory:11GBCore Clock:1.57GHz","standard_cost" : 573.51,"list_price" : 1000,"category_id" : 2, "quantity" : 100 })
db.products.replaceOne({ product_id: 5 }, { "product_id":5,"product_name" : "PNY VCQK6000-PB","description" : "Chipset:Quadro K6000,Memory:12GBCore Clock:902MHz","standard_cost" : 1740.31,"list_price" : 1000,"category_id" : 2, "quantity" : 100 })

db.products.find({ product_id: {$in: [1, 3, 5] } }, { _id:0,product_id : 1, product_name : 1, list_price : 1 })
