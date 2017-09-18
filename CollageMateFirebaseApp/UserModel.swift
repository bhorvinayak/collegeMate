//
//  UserModel.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 06/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

class UserModel{
    var id: String!
    var userName: String!
    var  email: String!
    var password:String!
    var mobileNo: String!
    var typeOfUser: String!
    var approveStatus : String!
    
    init(id: String!,userName: String!,email: String!,passowrd:String,mobileNo: String!,typeOfUser:String!,approveStatus : String!)
    {
        
       self.id=id
        self.userName=userName
        self.email=email
        self.mobileNo=mobileNo
        
        self.password=passowrd
        
        self.typeOfUser=typeOfUser
        self.approveStatus=approveStatus
        
    }
    
}
