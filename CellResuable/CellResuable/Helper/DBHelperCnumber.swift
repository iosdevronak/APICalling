//
//  DBHelperCnumber.swift
//  CellResuable
//
//  Created by Ronak Patel on 21/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import Foundation

import SQLite3

class DBHelperCnumber {
    
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "ronakDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    
    
    
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS contact_number(Id INTEGER PRIMARY KEY,number TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("ContactNumber table created.")
            } else {
                print("ContactNumber table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id:Int, number:String)
    {
        let contacts = read()
        for c in contacts
        {
            if c.Id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO contact_number (Id, number) VALUES (NULL, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (number as NSString).utf8String, -1, nil)
          //  sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String , -1,nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func read() -> [ContactNumber] {
        let queryStatementString = "SELECT * FROM contact_number;"
        var queryStatement: OpaquePointer? = nil
        var psns : [ContactNumber] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let number = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
          //      let number = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(ContactNumber(number: number, id: Int(id)))
               
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }

    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM contact_number WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
