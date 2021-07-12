//
//  ViewModel.swift
//  Sfera view v1
//
//  Created by Максим on 10.07.2021.
//

import Foundation

protocol TimersViewModel: AnyObject {
    
    // MARK: - Properties
    var timersBind: Dynamic<[TimerElement]> { get }
    
    // MARK: - Functions
    func didAddTimerTap(timer: TimerElement)
    func didRemoveTimer(index: Int)
    func sortTimers()
}

class TimersViewModelImpl: TimersViewModel {
    var timersBind: Dynamic<[TimerElement]> = Dynamic([])
    
    func didAddTimerTap(timer: TimerElement) {
        timersBind.value.append(timer)
    }
    
    func didRemoveTimer(index: Int) {
        timersBind.value.remove(at: index)
    }
    
    func sortTimers() {
        timersBind.value.sort{$0.sec > $1.sec}
    }
}
