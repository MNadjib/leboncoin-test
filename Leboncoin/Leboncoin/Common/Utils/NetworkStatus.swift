//
//  NetworkStatus.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit
import Network

//Based on an Github sample
class NetworkStatus {
    
    static let shared = NetworkStatus()
    
    typealias ReachableHandler = (() -> Void)
    typealias UnreachableHandler = (() -> Void)
    
    public enum Connection: CustomStringConvertible {
        case none
        case reachable
        
        public var description: String {
            switch self {
            case .none:
                return "No Connection"
            case .reachable:
                return "Active Connection"
            }
        }
    }
    
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    
    var notificationCenter: NotificationCenter = NotificationCenter.default
    
    private var isMonitorRunning = false
    private var isMonitorInvalid = false
    
    private var currentNetworkStatus: NWPath.Status?
    
    var reachableHandler: ReachableHandler?
    var unreachableHandler: UnreachableHandler?
    
    var connection: Connection {
        switch currentNetworkStatus {
        case .satisfied?:
            return .reachable
        default:
            return .none
            
        }
    }
    
    private init() {
        queue = DispatchQueue(label: "com.nbellouni.Leboncoin", qos: .default, attributes: .concurrent)
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [unowned self] path in
            let newNetworkStatus = path.status
            
            if self.currentNetworkStatus == nil {
                self.currentNetworkStatus = newNetworkStatus
                return
            }
            
            guard self.currentNetworkStatus != newNetworkStatus else { return }
            
            self.currentNetworkStatus = newNetworkStatus
            self.networkStatusChanged()
        }
    }
    
    deinit {
        stopMonitoring()
    }
    
    @discardableResult
    func startMonitoring() -> Bool {
        guard !isMonitorInvalid else { return false}
        guard !isMonitorRunning else { return false}
        monitor.start(queue: queue)
        isMonitorRunning = true
        return isMonitorRunning
    }
    
    func stopMonitoring() {
        guard isMonitorRunning else { return }
        monitor.cancel()
        isMonitorRunning = false
        isMonitorInvalid = true
    }
    
    private func networkStatusChanged() {
        
        guard let currentNetworkStatus = currentNetworkStatus else { return }
        
        let handler = currentNetworkStatus == .satisfied ? reachableHandler : unreachableHandler
        
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            handler?()
        }
    }
}
