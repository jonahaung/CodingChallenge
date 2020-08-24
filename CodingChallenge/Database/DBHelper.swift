//
//  DBHelper.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import Foundation
import SQLite3

final class DBHelper {

    static let shared = DBHelper()
    
    private let dbPath: String = "CodingChallenge.sqlite"
    private var db:OpaquePointer?
    
    init(){
        db = openDatabase()
        createTable()
    }
}


// Methods

extension DBHelper {
    // Insert
    func insert(user: LoginUser) {
        if isEmailExisted(for: user.email) {
            deleteByEmail(email: user.email)
        }
        let insertStatementString = "INSERT INTO person (email, password, name, courntry) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK else {
            print("INSERT statement could not be prepared.")
            return
        }
        
        sqlite3_bind_text(insertStatement, 1, user.email.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, user.password.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, user.name.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, user.courntry.utf8String, -1, nil)
        
        if sqlite3_step(insertStatement) == SQLITE_DONE {
            print("Successfully inserted row.")
        } else {
            print("Could not insert row.")
        }

        sqlite3_finalize(insertStatement)
    }
    
    
    // Query
    func getUser(email: String) -> LoginUser? {
        var queryStatement: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(db, "SELECT * FROM person WHERE email = ?;", -1, &queryStatement, nil) == SQLITE_OK else {
            print("SELECT statement could not be prepared")
            return nil
        }
        
        sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil)
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            
            let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            
            let loginUser = LoginUser(email: email, password: password, name: name, courntry: country)
            return loginUser
        }
        
        sqlite3_finalize(queryStatement)
        return nil
    }
    
    func getUser(email: String, password: String) -> LoginUser? {
        var queryStatement: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(db, "SELECT * FROM person WHERE email = ? AND password = ?;", -1, &queryStatement, nil) == SQLITE_OK else {
            print("SELECT statement could not be prepared")
            return nil
        }
        
        sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil)
        sqlite3_bind_text(queryStatement, 2, password.utf8String, -1, nil)
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            
            let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            
            let loginUser = LoginUser(email: email, password: password, name: name, courntry: country)
            return loginUser
        }
        
        sqlite3_finalize(queryStatement)
        return nil
    }
    
    func isEmailExisted(for email: String) -> Bool {
        return getUser(email: email) != nil
    }
    
    // Update
    func updateUser(user: LoginUser){
        deleteByEmail(email: user.email)
        insert(user: user)
    }


    // Delete
    func deleteByEmail(email: String) {
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, "DELETE FROM person WHERE email = ?;", -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, email.utf8String, -1, nil)
            
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


// Init Database

extension DBHelper {
    
    private func openDatabase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else{
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    private func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(email TEXT PRIMARY KEY, password TEXT, name TEXT, courntry TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
}
