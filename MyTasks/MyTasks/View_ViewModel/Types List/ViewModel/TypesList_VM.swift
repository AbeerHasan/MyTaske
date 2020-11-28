//
//  TypesList_VM.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/23/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation

class TypesList_VM {
    
    
  //---- Variables -----------------------------------------------------------
    let coreDataManager: CoreDataProtocol
    private var types: [Type] = [Type]()
       
    private var typeCellViewModels: [TypesListCell_VM] = [TypesListCell_VM]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfCells: Int {
        return typeCellViewModels.count
    }
    
    var reloadTableViewClosure: (()->())?
    
    init(coreDataManager: CoreDataProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
//--- Tasks TableViw and Cell Setup Functions -------------------------------
    
    func createTypeCellViewModel(name: String) -> TypesListCell_VM {
        return TypesListCell_VM(name: name)
    }
    
    func getCellViewModel(at index: Int) -> TypesListCell_VM {
        let typeCell_VM = typeCellViewModels[index]
       
        return typeCell_VM
    }
    
    func cellClicked(index: Int){
        currentTasksList = types[index].name
        NotificationCenter.default.post(name: NSNotification.Name(typeNotificationName), object: nil)
    }
//-------------------
    func getTypes(completion: @escaping ([Type] , String?) -> ()){
        coreDataManager.getAllTypes { (types, error) in
           self.types = types
           var typeCellViewModels = [TypesListCell_VM]()
           for type in types{
               typeCellViewModels.append(self.createTypeCellViewModel(name: type.name))
           }
           self.typeCellViewModels = typeCellViewModels
           completion(types,error)
        }
    }
    func addType(name: String, completion: @escaping (_ error: String) -> ()){
        if name != "" && name != " " {
            coreDataManager.addType(name: name) { (type, error) in
                self.types.append(type)
                self.typeCellViewModels.append(self.createTypeCellViewModel(name: name))
            }
        }else {
            completion("Please write a name")
        }
    }
    
   func removeType(index: Int){
        coreDataManager.removeType(type: types[index]) { (error) in
            print(error ?? "Error removing type")
            self.types.remove(at: index)
            self.typeCellViewModels.remove(at: index)
        }
   }
    
   func saveData(){
        self.coreDataManager.saveContext { (error) in
            print(error)
        }
    }
}
