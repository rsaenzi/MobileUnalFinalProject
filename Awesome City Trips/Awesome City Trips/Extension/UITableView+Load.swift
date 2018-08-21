//
//  UITableView+Load.swift
//
//  Created by Rigoberto Sáenz Imbacuán (https://www.linkedin.com/in/rsaenzi/)
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     This function works if the UITableViewCell class and the Cell Identifier are the same
     */
    func dequeue<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        
        let identifier = className(some: T.self)
        let rawCell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("UITableViewCell with identifier '\(identifier)' was not found")
        }
        return cell
    }
}

extension UICollectionView {
    
    /**
     This function works if the UICollectionViewCell class and the Cell Identifier are the same
     */
    func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        
        let identifier = className(some: T.self)
        let rawCell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("UICollectionViewCell with identifier '\(identifier)' was not found")
        }
        return cell
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}


// MARK: Alternatives

extension UITableViewCell {
    
    static func dequeue(_ tableView: UITableView, _ indexPath: IndexPath, _ reuseIdentifier: UITableViewCellId) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.rawValue, for: indexPath)
        return cell
    }
    
    static func dequeue<T: UITableViewCell>(_ tableView: UITableView, _ indexPath: IndexPath) -> T {
        
        let cellId = className(some: T.self)
        let rawCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("No UITableViewCell with ID \(cellId) was found")
        }
        return cell
    }
}

enum UITableViewCellId: String {
    case login = "LoginCell"
    case register = "RegisterCell"
}
