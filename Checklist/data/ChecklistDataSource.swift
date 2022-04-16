//
//  ChecklistDataSource.swift
//  Checklist
//
//  Created by Abel  on 13/04/2022.
//

import Foundation

//checklist dummy data source
class ChecklistDataSource{
    
    public var checkListItems = [ChecklistItem]()
    
    func getCount() -> Int
    {
        return checkListItems.count
    }
    
    func initDummyChecklist(){
        for i in 0...10{
            
            let checkListItem = ChecklistItem()
            
            switch(i % 5)
            {
            case 0:
                checkListItem.title = "Learn iOS"
                break
            case 1:
                checkListItem.title = "Eat dinner"
                break
            case 2:
                checkListItem.title = "facetime with Yohan ❤️"
                break
            case 3:
                checkListItem.title = "Read books"
                break
            case 4:
                checkListItem.title = "Check mails"
                break
            default:
                break
            }
            //append checklist item into list
            checkListItems.append(checkListItem)
        }
    }
    
    func appendChecklistIem(at checklistItem: ChecklistItem)
    {
        checkListItems.append(checklistItem)
    }
}
