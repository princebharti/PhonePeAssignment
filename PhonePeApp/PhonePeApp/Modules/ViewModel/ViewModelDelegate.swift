//
//  ViewModelDelegate.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import Foundation


protocol ViewModelDelegate: AnyObject {
    func viewModelDidUpdate(identifier: String?, data: Any?)
    func viewModelDidFail(identifier: String?, error: Error?)
    func reload(indexes: [IndexPath]?)

}
extension ViewModelDelegate {
    func reload(indexes: [IndexPath]?) { }
}
