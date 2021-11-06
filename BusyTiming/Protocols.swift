//
//  Protocols.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/4/21.
//

protocol DisplayTimerProtocol  {
    func  displayTimer(result:String)
}

protocol DisplayTimerDelegat {
    var  displayTimerDelegat: DisplayTimerProtocol? {get set}
}

protocol DisplayAffairProtocol {
    func selectedAffaire(nameAffair: String)
}


