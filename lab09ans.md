1. Write an aggregate statement to sort the documents in the grades collection based on student ID and class ID. Display only the student ID and the class ID for each document.
Sort the result from high to low values for student ID and from low to high for class ID.
db.grades.aggregate(
{$sort: {student_id: -1, class_id: 1} },
{$project: {student_id: 1, class_id: 1, _id: 0} })

2. Revise the previous query to show the result for students with IDs between 10 and 12.
db.grades.aggregate(
{$match: {class_id: {$in: [10, 11, 12] } } }
,{$sort: {student_id: -1, class_id: 1} }
,{$project: {student_id: 1, class_id: 1, _id: 0} } )

3. Show only existing class IDs in the grades collection. (Do not show duplicates.)
db.grades.aggregate([{$group: {_id: "$class_id"}}])

4. Write a query to group the type of scores and display the total types in each student document
db.students.aggregate([ { $group:{ _id:'$scores.type',total:{$sum:1}} } ])

5. Write a query to show the maximum and the minimum class ID for each student. Sort the result based on student ID from low to high. Show only the first 10 students.
db.grades.aggregate(
{$group:
{_id: "$student_id",
"max_class_id": {$max: "$class_id"},
"min_class_id": {$min: "$class_id"}
}},
{$sort: {_id: 1, student_id: -1, class_id: 1} },
{$limit: 10}
)

6. Write a query to find the number of failed exams for student with ID 48.
db.grades.count({student_id: 48, scores: { $elemMatch: { score: {$lt: 50}, type: "exam" } } })
