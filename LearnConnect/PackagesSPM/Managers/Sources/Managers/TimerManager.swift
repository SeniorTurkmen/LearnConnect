//
//  TimerManager.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public enum TimerManagerState {
    case stop
    case resume
}

public protocol TimerManagerDelegate: AnyObject {
    func timerDidUpdate(timeRemaining: Int)
    func timerDidFinish()
}

public final class TimerManager {
    private var timer: Timer?
    private var backgroundTime = Date()
    private var onSceneTime = Date()

    public weak var delegate: TimerManagerDelegate?
    public var timeRemaining: Int = 180
    public var timerState: TimerManagerState = .stop

    public init() {}

    deinit {
        stop()
    }

    public func startTimer() {
        timer = Timer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true
        )
        guard let timer else { return }
        RunLoop.main.add(timer, forMode: .common)
    }

    public func pause() {
        timerState = .stop
        backgroundTime = Date()
        timer?.invalidate()
    }

    public func resume() {
        onSceneTime = Date()
        let difference = Calendar.current.dateComponents(
            [.minute, .second],
            from: backgroundTime,
            to: onSceneTime
        )
        let totalBackgrounTime = ((difference.minute ?? 0) * 60) + (difference.second ?? 0)
        guard timeRemaining - totalBackgrounTime >= 0 else {
            stop()
            return
        }
        timeRemaining -= totalBackgrounTime
        startTimer()
    }

    public func stop() {
        timerState = .stop
        delegate?.timerDidUpdate(timeRemaining: 0)
        delegate?.timerDidFinish()
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Actions
extension TimerManager {
    @objc private func updateTime() {
        timerState = .resume
        timeRemaining -= 1
        delegate?.timerDidUpdate(timeRemaining: timeRemaining)
        guard timeRemaining <= 0 else { return }
        stop()
        delegate?.timerDidFinish()
    }
}
