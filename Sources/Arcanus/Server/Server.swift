// Copyright © 2018 Jack Maloney. All Rights Reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import CloudEnvironment
import Configuration
import Foundation
import Health
import Kitura
import SwiftKueryORM
import LoggerAPI

public func serverMain() {
    do {
        let server = try Server()
        try server.run()
    } catch {
    }
}

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class Server {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Run the metrics initializer
        initializeMetrics(router: self.router)
        // Open database
        try Database.openSharedDatabase()
        
        SwiftKueryORM.Database.default = SwiftKueryORM.Database(single: Database.shared.db)
        
        do {
            try User.createTableSync()
            try Game.createTableSync()
            
            let user = try User(username: "jmmaloney4", password: "12345")
            user.save { (user, err) in
                if err != nil {
                    Log.error("ERROR!! \(err!)")
                } else {
                    Log.info("\(user!)")
                }
            }
            // try Auth.createTableSync()
        } catch let err {
            // Error, but table already created
            Log.error("\(err)")
        }
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        initializeUserRoutes(app: self)
        // initializeGameRoutes(app: self)
    }

    public func run() throws {
        try self.postInit()
        Kitura.addHTTPServer(onPort: self.cloudEnv.port, with: self.router)
        Kitura.run()
    }
}
