//
//  Reachability.swift
//  pokedata
//
//  Created by Camiilo on 22/01/24.
//

import Foundation
import Network

/// Protocolo de la clase Reachability
protocol NetworkStatusDelegate: AnyObject {
    func didUpdateNetworkStatus(_ status: NetworkStatus)
}

/// Clase responsable de gestionar el estado de la conexion a Internet
class Reachability {

    static let shared = Reachability()

    private let monitor = NWPathMonitor()

    weak var delegate: NetworkStatusDelegate?

    private init() {
        startMonitoring()
    }

    /// Metodo para iniciar la monitorizacion de la conexion a Internet
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let status: NetworkStatus = (path.status == .satisfied) ? .connected : .disconnected
            self?.delegate?.didUpdateNetworkStatus(status)
            self?.handleNetworkStatusUpdate(status)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    /// Meotdo para manejar las actualizaciones del estado de la conexion
    private func handleNetworkStatusUpdate(_ status: NetworkStatus) {
        switch status {
        case .connected:
            print("***** Internet Conectado ******")
        case .disconnected:
            print("***** Sin Conexión a Internet ******")
        }
    }

    /// Metodo para verificar el estado actual de la conexion a Internet
    func isConnectedToNetwork() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}
