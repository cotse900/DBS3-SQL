//DBS311NFF Group 01 Assignment 02
//Muhammad Ahmed 146908207 -> Section table
//Chungon Tse 154928188 -> Course table
//Mohammadhossein Sobhanmanesh 116523200 -> Financial table
#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

struct Section
{
	int sectionid;
	int professorid;
	int courseid;
	int classnumber;
	string coursetime;
};

struct Financial
{
	int financialid;
	double balance;
	string bankname;
	int bankaccnum;
	int cardnum;
};

struct Course
{
	int courseid;
	string coursename;
	string crsdescription;
	int creditnumber;
	int programid;
};



// Muhammad Ahmed's functions
// Section table CRUD
void insertSection(Connection* conn)
{
	Section section;
	int err = 0;

	cout << "Section ID: ";
	cin >> section.sectionid;
	cout << "Professor ID: ";
	cin >> section.professorid;
	cout << "Course ID: ";
	cin >> section.courseid;
	cout << "Class number: ";
	cin >> section.classnumber;
	cout << "Class time: ";
	cin >> section.coursetime;

	try
	{
		Statement* stmt = conn->createStatement();
		stmt->setSQL("BEGIN spSectionInsert(:1, :2, :3, :4, :5, :6); END;");
		stmt->registerOutParam(1, Type::OCCIINT, sizeof(err));
		stmt->setNumber(2, section.sectionid);
		stmt->setNumber(3, section.professorid);
		stmt->setNumber(4, section.courseid);
		stmt->setNumber(5, section.classnumber);
		stmt->setString(6, section.coursetime);

		stmt->executeUpdate();
		err = stmt->getInt(1);

		if (err > 0)
		{
			cout << "\nSUCCESS: New section inserted.\n\n";
		}
		else
		{
			cout << "\nERROR: New section could not be inserted. The entered section ID may already exist.\n\n";
		}

		conn->terminateStatement(stmt);
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
};

void readSection(Connection* conn)
{
	Section section;
	int err = 0;
	string row;

	cout << "Enter the section ID of the section to view: ";
	cin >> section.sectionid;

	try
	{
		Statement* stmt = conn->createStatement();
		stmt->setSQL("BEGIN spSectionRead(:1, :2, :3, :4, :5, :6); END;");
		stmt->registerOutParam(1, Type::OCCIINT, sizeof(err));
		stmt->setNumber(2, section.sectionid);
		stmt->registerOutParam(3, Type::OCCIINT, sizeof(section.professorid));
		stmt->registerOutParam(4, Type::OCCIINT, sizeof(section.courseid));
		stmt->registerOutParam(5, Type::OCCIINT, sizeof(section.classnumber));
		stmt->registerOutParam(6, Type::OCCISTRING, sizeof(section.coursetime));

		stmt->executeUpdate();
		err = stmt->getInt(1);
		section.professorid = stmt->getInt(3);
		section.courseid = stmt->getInt(4);
		section.classnumber = stmt->getInt(5);
		section.coursetime = stmt->getString(6);

		if (err > 0)
		{
			cout << "\nSUCCESS: Section retrieved.\n\n";

			cout << "Section ID:   " << section.sectionid << endl;
			cout << "Professor ID: " << section.professorid << endl;
			cout << "Course ID:    " << section.courseid << endl;
			cout << "Class Number: " << section.classnumber << endl;
			cout << "Class Time:   " << section.coursetime << endl << endl;
		}
		else
		{
			cout << "\nERROR: Section could not be Retrieved. Entry with the specified section ID may not exist.\n\n";
		}

		conn->terminateStatement(stmt);
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
};

void updateSection(Connection* conn)
{
	Section section;
	int err = 0;

	cout << "Section ID: ";
	cin >> section.sectionid;
	cout << "Professor ID: ";
	cin >> section.professorid;
	cout << "Course ID: ";
	cin >> section.courseid;
	cout << "Class number: ";
	cin >> section.classnumber;
	cout << "Class time: ";
	cin >> section.coursetime;

	try
	{
		Statement* stmt = conn->createStatement();
		stmt->setSQL("BEGIN spSectionUpdate(:1, :2, :3, :4, :5, :6); END;");
		stmt->registerOutParam(1, Type::OCCIINT, sizeof(err));
		stmt->setNumber(2, section.sectionid);
		stmt->setNumber(3, section.professorid);
		stmt->setNumber(4, section.courseid);
		stmt->setNumber(5, section.classnumber);
		stmt->setString(6, section.coursetime);

		stmt->executeUpdate();
		err = stmt->getInt(1);

		if (err > 0)
		{
			cout << "\nSUCCESS: Section updated.\n\n";
		}
		else
		{
			cout << "\nERROR: Section could not be updated. Entry with the specified section ID may not exist.\n\n";
		}

		conn->terminateStatement(stmt);
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
};

void deleteSection(Connection* conn)
{

	Section section;
	int err = -1;

	cout << "Enter the section ID of the section to delete: ";
	cin >> section.sectionid;

	try
	{
		Statement* stmt = conn->createStatement();
		stmt->setSQL("BEGIN spSectionDelete(:1, :2); END;");
		stmt->registerOutParam(1, Type::OCCIINT, sizeof(err));
		stmt->setNumber(2, section.sectionid);

		stmt->executeUpdate();
		err = stmt->getInt(1);

		if (err > 0)
		{
			cout << "\nSUCCESS: Section deleted.\n\n";
		}
		else
		{
			cout << "\nERROR: Section could not be deleted. Entry with the specified section ID may not exist.\n\n";
		}

		conn->terminateStatement(stmt);
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
};

// Mohammadhossein Sobhanmanesh's functions
// Financial table CRUD
// int getFinancial(Connection *conn, int fid, struct Financial *f)
int getFinancialByID(Connection* conn, struct Financial* f)
{

	cout << "Enter the financial id: ";
	cin >> f->financialid;

	cout << endl;

	try
	{
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spFinancialSelectByID(:1, :2, :3, :4, :5, :6); END;");

		int result = 0;

		stmt->setInt(1, f->financialid);
		stmt->registerOutParam(2, Type::OCCIDOUBLE, sizeof(f->balance));
		stmt->registerOutParam(3, Type::OCCISTRING, sizeof(f->bankname));
		stmt->registerOutParam(4, Type::OCCIINT, sizeof(f->bankaccnum));
		stmt->registerOutParam(5, Type::OCCIINT, sizeof(f->cardnum));
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		f->balance = stmt->getDouble(2);
		f->bankname = stmt->getString(3);
		f->bankaccnum = stmt->getInt(4);
		f->cardnum = stmt->getInt(5);
		result = stmt->getInt(6);

		conn->terminateStatement(stmt);

		if (result == -1)
		{
			// error
			cout << "Didn't find anything" << endl << endl;
			return 0;
		}

		cout << "Financial id: " << f->financialid << endl;
		cout << "Balance: " << f->balance << endl;
		cout << "Bank name: " << f->bankname << endl;
		cout << "Bank Account number: " << f->bankaccnum << endl;
		cout << "Card Number: " << f->cardnum << endl << endl;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
}

int insertFinancialByID(Connection* conn, struct Financial* f)
{
	// fid : 80021
	// balance : 22000.2
	// bankname : "Bank of America"
	// bankaccnum : 39020
	// cardnum : 49020

	cout << "Enter the financial id: ";
	cin >> f->financialid;
	cout << "Enter the balance: ";
	cin >> f->balance;
	cout << "Enter the bank name: ";
	// cin >> f->bankname;
	cin.clear();
	cin.ignore(1000, '\n');
	getline(cin, f->bankname);

	cout << "Enter the bank account number: ";
	cin >> f->bankaccnum;
	cout << "Enter the card number: ";
	cin >> f->cardnum;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spFinancialInsertByID(:1, :2, :3, :4, :5, :6); END;");

		stmt->setInt(1, f->financialid);
		stmt->setDouble(2, f->balance);
		stmt->setString(3, f->bankname);
		stmt->setInt(4, f->bankaccnum);
		stmt->setInt(5, f->cardnum);
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));
		stmt->executeUpdate();

		result = stmt->getInt(6);
		// result is going to be 1 or -1

		conn->terminateStatement(stmt);

		if (result == -1)
		{
			cout << "Insert data faild" << endl << endl;
			return 0;
		};
		cout << "Financial with id# " << f->financialid << " was inserted..." << endl;

		cout << "Financial id: " << f->financialid << endl;
		cout << "Balance: " << f->balance << endl;
		cout << "Bank name: " << f->bankname << endl;
		cout << "Bank account number: " << f->bankaccnum << endl;
		cout << "Card number: " << f->cardnum << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
}

int deleteFinancialByID(Connection* conn, struct Financial* f)
{

	cout << "Enter the financial id: ";
	cin >> f->financialid;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spFinancialDeleteByID(:1, :2); END;");

		stmt->setInt(1, f->financialid);
		stmt->registerOutParam(2, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		result = stmt->getInt(2);
		conn->terminateStatement(stmt);

		// result is going to be 1 or -1
		if (result == -1)
		{
			// handle the error
			cout << "Deleting the Financial with id# " << f->financialid << "failed" << endl << endl;
			return 0;
		}

		cout << "financila with id : " << f->financialid << " was deleted" << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
}

int updateFinancialByID(Connection* conn, struct Financial* f)
{
	cout << "Enter the financial id: ";
	cin >> f->financialid;
	cout << "Enter the Balance: ";
	cin >> f->balance;
	cout << "Enter the Bank Name: ";
	// cin >> f->bankname;
	//  here seems have some data in buffer and needs to get clear
	cin.clear();
	cin.ignore(1000, '\n');
	getline(cin, f->bankname);
	cout << "Enter the Bank Account number: ";
	cin >> f->bankaccnum;
	cout << "Enter the Card number: ";
	cin >> f->cardnum;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spFinancialUpdateByID(:1, :2, :3, :4, :5, :6); END;");

		stmt->setInt(1, f->financialid);
		stmt->setInt(2, f->balance);
		stmt->setString(3, f->bankname);
		stmt->setInt(4, f->bankaccnum);
		stmt->setInt(5, f->cardnum);
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		result = stmt->getInt(6);
		conn->terminateStatement(stmt);

		// result is going to be 1 or -1
		if (result == -1)
		{
			// handle the error
			cout << "Updating the Financial with id# " << f->financialid << "failed" << endl << endl;
			return 0;
		}

		cout << "Financial with id : " << f->financialid << " was updated" << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();

	}
	return 0;
}

// Chungon Tse's functions
// Course table CRUD
int insertCourseByID(Connection* conn, struct Course* cse)
{

	cout << "Enter the course id: ";
	cin >> cse->courseid;
	cout << "Enter the course name: ";
	cin.clear();
	cin.ignore(1000, '\n');
	getline(cin, cse->coursename);
	cout << "Enter the course description: ";
	//cin.clear();
	//cin.ignore(1000, '\n');
	getline(cin, cse->crsdescription);
	cout << "Enter the credit number: ";
	cin >> cse->creditnumber;
	cout << "Enter the program ID: ";
	cin >> cse->programid;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spCourseInsertByID(:1, :2, :3, :4, :5, :6); END;");

		stmt->setInt(1, cse->courseid);
		stmt->setString(2, cse->coursename);
		stmt->setString(3, cse->crsdescription);
		stmt->setInt(4, cse->creditnumber);
		stmt->setInt(5, cse->programid);
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));
		stmt->executeUpdate();

		result = stmt->getInt(6);
		// result is going to be 1 or -1

		conn->terminateStatement(stmt);

		if (result == -1)
		{
			cout << "Insert data failed" << endl;
			return 0;
		};
		cout << "Course with id# " << cse->courseid << " was inserted..." << endl
			<< endl;

		cout << "Course id: " << cse->courseid << endl;
		cout << "Course name: " << cse->coursename << endl;
		cout << "Course description: " << cse->crsdescription << endl;
		cout << "Credit number: " << cse->creditnumber << endl;
		cout << "Program id: " << cse->programid << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
}

int getCourseByID(Connection* conn, struct Course* cse)
{

	cout << "Enter the course id: ";
	cin >> cse->courseid;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spCourseReadByID(:1, :2, :3, :4, :5, :6); END;");

		stmt->setInt(1, cse->courseid);
		stmt->registerOutParam(2, Type::OCCISTRING, sizeof(cse->coursename));
		stmt->registerOutParam(3, Type::OCCISTRING, sizeof(cse->crsdescription));
		stmt->registerOutParam(4, Type::OCCIINT, sizeof(cse->creditnumber));
		stmt->registerOutParam(5, Type::OCCIINT, sizeof(cse->programid));
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		cse->coursename = stmt->getString(2);
		cse->crsdescription = stmt->getString(3);
		cse->creditnumber = stmt->getInt(4);
		cse->programid = stmt->getInt(5);
		result = stmt->getInt(6);

		// result is going to be 1 or -1

		conn->terminateStatement(stmt);

		if (result == -1)
		{
			cout << "Get data failed" << endl << endl;
			return 0;
		};
		cout << "Course with id# " << cse->courseid << " was retrieved..." << endl
			<< endl;
		cout << "Course id: " << cse->courseid << endl;
		cout << "Course name: " << cse->coursename << endl;
		cout << "Course description: " << cse->crsdescription << endl;
		cout << "Credit number: " << cse->creditnumber << endl;
		cout << "Program id: " << cse->programid << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
};

int deleteCourseByID(Connection* conn, struct Course* cse)
{
	cout << "Enter the course id: ";
	cin >> cse->courseid;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spCourseDeleteByID(:1, :2); END;");

		stmt->setNumber(1, cse->courseid);
		stmt->registerOutParam(2, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		result = stmt->getInt(2);
		conn->terminateStatement(stmt);

		// result is going to be 1 or -1
		if (result == -1)
		{
			// handle the error
			cout << "Deleting the Course with id# " << cse->courseid << "failed" << endl << endl;
			return 0;
		}

		cout << "Course with id : " << cse->courseid << " was deleted" << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();
	}
	return 0;
};

int updateCourseByID(Connection* conn, struct Course* cse)
{

	cout << "Enter the course id: ";
	cin >> cse->courseid;
	cout << "Enter the course name: ";
	cin.clear();
	cin.ignore(1000, '\n');
	getline(cin, cse->coursename);
	cout << "Enter the course description: ";
	/*cin.clear();
	cin.ignore(1000, '\n');*/
	getline(cin, cse->crsdescription);
	cout << "Enter the credit number: ";
	cin >> cse->creditnumber;
	cout << "Enter the program ID: ";
	cin >> cse->programid;

	cout << endl;

	try
	{
		int result = 0;
		Statement* stmt = conn->createStatement();
		stmt->setSQL(
			"BEGIN spCourseUpdateByID(:1, :2, :3, :4, :5, :6); END;");

		stmt->setNumber(1, cse->courseid);
		stmt->setString(2, cse->coursename);
		stmt->setString(3, cse->crsdescription);
		stmt->setNumber(4, cse->creditnumber);
		stmt->setNumber(5, cse->programid);
		stmt->registerOutParam(6, Type::OCCIINT, sizeof(result));

		stmt->executeUpdate();
		result = stmt->getInt(6);
		conn->terminateStatement(stmt);

		// result is going to be 1 or -1
		if (result == -1)
		{
			// handle the error
			cout << "Updating the Course with id# " << cse->courseid << "failed" << endl << endl;
			return 0;
		}

		cout << "Course with id : " << cse->courseid << " was updated" << endl << endl;

		return 1;
	}
	catch (SQLException& sqlExcp)
	{
		std::cout << sqlExcp.getErrorCode() << ": "
			<< sqlExcp.getMessage();

	}
	return 0;
};

// UI and Main Menu Logic 
int menu(void)
{
	cout << "------------- College Registration -------------" << endl;
	//Section table
	cout << "1.  Create a section entry" << endl;
	cout << "2.  Read a section entry" << endl;
	cout << "3.  Update a section entry" << endl;
	cout << "4.  Delete a section entry" << endl;
	//Financial table
	cout << "5.  Create a financial entry" << endl;
	cout << "6.  Read a financial entry" << endl;
	cout << "7.  Update a financial entry" << endl;
	cout << "8.  Delete a financial entry" << endl;
	//Course table
	cout << "9.  Create a course entry" << endl;
	cout << "10. Read a course entry" << endl;
	cout << "11. Update a course entry" << endl;
	cout << "12. Delete a course entry" << endl;
	cout << "0. Exit" << endl;

	cout << "\nEnter an option: ";

	bool done = false;
	int choice;
	do
	{
		cin >> choice;
		if (!(choice <= 12 && choice >= 0))
		{
			cin.clear();
			cin.ignore(1000, '\n');
			cout << "Invalid.\nEnter an option (0 to 12): ";
		}
		else
		{
			done = true;
		}
	}
	while (!done);
	return choice;
}

int main(void)
{
	Environment* env = nullptr;
	Connection* conn = nullptr;
	string str;
	string usr = "";
	string pass = "";
	string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";
	struct Course cse;
	struct Financial f;

	try
	{
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(usr, pass, srv);
		cout << "Username: " << usr << endl;
		cout << "Password: " << pass << endl;
		cout << "Connection was successful!" << endl << endl;

		cout << "Group Number : 01" << endl;
		cout << "Group Members: " << endl;
		cout << "               Muhammad Ahmed 146908207" << endl;
		cout << "               Chungon Tse 154928188" << endl;
		cout << "               Mohammadhossein Sobhanmanesh 116523200" << endl;
		cout << endl;

		int num = 0;
		int input = 0;
		bool keepgoing = true;
		bool correctCode = false;

		do
		{
			input = menu();
			switch (input)
			{
			case 1:
				insertSection(conn);
				break;
			case 2:
				readSection(conn);
				break;
			case 3:
				updateSection(conn);
				break;
			case 4:
				deleteSection(conn);
				break;
			case 5:
				if (insertFinancialByID(conn, &f))
				{
					cout << "err";
				}
				break;
			case 6:
				if (getFinancialByID(conn, &f))
				{
					cout << "err";
				}
				break;
			case 7:
				if (updateFinancialByID(conn, &f))
				{
					cout << "err";
				}
				break;
			case 8:
				if (deleteFinancialByID(conn, &f))
				{
					cout << "err";
				}
				break;
			case 9:
				if (insertCourseByID(conn, &cse))
				{
					cout << "err";
				}
				break;
			case 10:
				if (getCourseByID(conn, &cse))
				{
					cout << "err";
				}
				break;
			case 11:
				if (updateCourseByID(conn, &cse))
				{
					cout << "err";
				}
				break;
			case 12:
				if (deleteCourseByID(conn, &cse))
				{
					cout << "err";
				}
				break;
			case 0:
				cout << endl << "Thank you and goodbye!!" << endl;
				keepgoing = false;
				break;
			}
		}
		while (keepgoing);

		env->terminateConnection(conn);
		Environment::terminateEnvironment(env);

	}
	catch (SQLException& sqlExcp)
	{
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}
	return 0;
}