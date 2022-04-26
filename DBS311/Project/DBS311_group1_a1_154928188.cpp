//DBS311 Group 1
//Mohammadhossein Sobhanmanesh 116523200
//Muhammad Ahmed 146908207
//Chungon Tse 154928188
#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

struct Employee
{
	int employee_id;
	string first_name;
	string last_name;
	string email;
	string phone;
	string hire_date;
	int manager_id;
	string job_title;
};
struct Course
{
	int courseID;
	string courseName;
	string crsDescription;
	int creditNumber;
	int programID;
};

int menu(void);
int findEmployee(Connection* conn, int employee_id, struct Employee* emp);
void displayEmployee(Connection* conn, struct Employee emp);
int findCourse(Connection* conn, int courseID, struct Course* course);
void displayCourse(Connection* conn, struct Course course);
void displayAllCourses(Connection* conn);

int main(void)
{
	Environment* env = nullptr;
	Connection* conn = nullptr;
	string str;
	string usr = "";
	string pass = "";
	string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";

	try
	{
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(usr, pass, srv);
		cout << "Connection is successful!" << endl;
		cout << "Group 1" << endl;
		cout << "Members:" << endl;
		cout << "Mohammadhossein Sobhanmanesh 116523200" << endl;
		cout << "Muhammad Ahmed 146908207" << endl;
		cout << "Chungon Tse 154928188" << endl;

		struct Employee emp;
		struct Course course;

		int num, input = 0;
		bool keepgoing = false;
		bool correctCode = false;
		do {
			input = menu();
			switch (input)
			{
			case 1:
				keepgoing = true;
				do{
				cout << "Please enter employee ID: ";
				cin >> num;
				if (findEmployee(conn, num, &emp) == 1)
				{
					cout << "Valid input!" << endl;
					cout << "Search in table..." << endl;
					displayEmployee(conn, emp);
					correctCode = true;
				}
				else
				{
					cin.clear();
					cin.ignore(100, '\n');
					cout << "Invalid Employee Number. Try again!\n";
					correctCode = false;
				}
				} while (correctCode == false);
				break;
			case 2:
				keepgoing = true;
				cout << "Enter course code to display a course: ";
				cin >> num;
				if (findCourse(conn, num, &course) == 1) {
					displayCourse(conn, course);
				}
				else {
					cout << "There is no such course coded " << num << endl;
				}
				break;
			case 3:
				keepgoing = true;
				displayAllCourses(conn);
				break;
			case 4:
				keepgoing = true;
				//insert table
			case 0:
				cout << endl << "Thank you and goodbye!!" << endl;
				keepgoing = false;
				break;
			}
		} while (keepgoing);

		env->terminateConnection(conn);
		Environment::terminateEnvironment(env);

	}
	catch (SQLException& sqlExcp)
	{
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}
	return 0;
}

int menu(void)
{
	cout << endl << "------------- College Registration -------------" << endl;
	cout << "1. Find Employee" << endl;
	cout << "2. Find and display a course" << endl;
	cout << "3. Display all courses" << endl;
	cout << "4. To-do" << endl;
	cout << "0. Exit" << endl;

	cout << "\nEnter your choice: ";

	int choice;
	char newline;
	bool done;
	do
	{
		cin >> choice;
		newline = cin.get();
		if (cin.fail() || newline != '\n')
		{
			done = false;
			cin.clear();
			cin.ignore(1000, '\n');
			cout << "Invalid. Enter an option of 1/2/3/4/0.";
		}
		else
		{
			done = choice >= 0 && choice <= 4;
			if (!done)
			{
				cout << "Invalid. Enter an option of 1/2/3/4/0.";
			}
		}
	} while (!done);
	return choice;
}

int findEmployee(Connection* conn, int employee_id, struct Employee* emp)
{

	Statement* stmt = conn->createStatement();

	ResultSet* rs = stmt->executeQuery("Select employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title from employees where employee_id =" + to_string(employee_id));
	//employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title

	if (!rs->next())
	{
		return 0;
	}
	else
	{
		emp->employee_id = rs->getInt(1);
		emp->first_name = rs->getString(2);
		emp->last_name = rs->getString(3);
		emp->email = rs->getString(4);
		emp->phone = rs->getString(5);
		emp->hire_date = rs->getString(6);
		emp->manager_id = rs->getInt(7);
		emp->job_title = rs->getString(8);
		return 1;
	}
}
void displayEmployee(Connection* conn, struct Employee emp)
{
	cout << left;
	cout.width(14);
	cout << "Employee ID";
	cout.width(13);
	cout << "First Name";
	cout.width(17);
	cout << "Last Name";
	cout.width(34);
	cout << "Email";
	cout.width(16);
	cout << "Phone";
	cout.width(14);
	cout << "Hire Date";
	cout.width(15);
	cout << "Manager ID";
	cout.width(35);
	cout << "Job Title" << endl;

	cout << left;
	cout.width(14);
	cout << emp.employee_id;
	cout.width(13);
	cout << emp.first_name;
	cout.width(17);
	cout << emp.last_name;
	cout.width(34);
	cout << emp.email;
	cout.width(16);
	cout << emp.phone;
	cout.width(14);
	cout << emp.hire_date;
	cout.width(15);
	cout << emp.manager_id;
	cout.width(35);
	cout << emp.job_title << endl;
}

int findCourse(Connection* conn, int courseID, Course* course)
{
	Statement* stmt = conn->createStatement();
	ResultSet* rs = stmt->executeQuery("Select courseid, coursename, crsdescription, creditnumber, programid from course WHERE courseid =" + to_string(courseID));

	if (!rs->next())
	{
		return 0;
	}
	else
	{
		course->courseID = rs->getInt(1);
		course->courseName = rs->getString(2);
		course->crsDescription = rs->getString(3);
		course->creditNumber = rs->getInt(4);
		course->programID = rs->getInt(5);
		return 1;
	}
}
void displayCourse(Connection* conn, struct Course course)
{
	cout << endl << "------------- Course Information -------------" << endl;
	cout << "Course ID: " << course.courseID << endl;
	cout << "Course Name: " << course.courseName << endl;
	cout << "Description: " << course.crsDescription << endl;
	cout << "No. of credits: " << course.creditNumber << endl;
	cout << "Program ID: " << course.programID << endl;
}
void displayAllCourses(Connection* conn) {
	Statement* stmt = conn->createStatement();

	ResultSet* rs = stmt->executeQuery("Select courseid, coursename, crsdescription, creditnumber, programid from course");

	cout << endl << "------------- All Courses -------------" << endl << endl;
	cout.setf(ios::left);
	cout.width(12);
	cout << "Course ID";
	cout.width(32);
	cout << "Course";
	cout.width(89);
	cout << "Description";
	cout.width(9);
	cout << "Credit";
	cout.width(14);
	cout << "Program ID" << endl;

	cout.width(152);
	cout.fill('-');
	cout << '-' << endl;
	cout.fill(' ');

	while (rs->next())
	{
		int courseID = rs->getInt(1);
		string courseName = rs->getString(2);
		string crsDescription = rs->getString(3);
		int creditNumber = rs->getInt(4);
		int programID = rs->getInt(5);
		cout.setf(ios::left);
		cout.width(12);
		cout << courseID;
		cout.width(32);
		cout << courseName;
		cout.width(89);
		cout << crsDescription;
		cout.width(9);
		cout << creditNumber;
		cout.width(14);
		cout << programID << endl;
	}
}