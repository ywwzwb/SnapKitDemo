//
//  MySnapkit.swift
//  SnapKitDemo
//
//  Created by yww on 2017/8/31.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit

extension UIView {
    var mysnp: MyConstraintDSL {
        return MyConstraintDSL(view: self)
    }
}

class MyConstraintDSL {
    fileprivate weak var view:UIView!
    init(view: UIView) {
        self.view = view
    }
    func make(_ closure: (MyConstraintMaker)->()) {
        let maker = MyConstraintMaker(view: self.view)
        maker.make(closure)
    }
}
extension MyConstraintDSL {
    var top: MyConstraintItem {
        let item = MyConstraintItem(prop: .top, view: self.view)
        return item
    }
    var left: MyConstraintItem {
        let item = MyConstraintItem(prop: .left, view: self.view)
        return item
    }
    // 其他属性类似
}
class MyConstraintMaker {
    fileprivate weak var view:UIView!
    fileprivate var constants = [MyConstraintItem]()
    init(view: UIView) {
        self.view = view
    }
    func make(_ closure: (MyConstraintMaker)->()) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        closure(self)
        for constant in self.constants {
            constant.getLayoutConstraint()?.isActive = true
        }
    }
}
extension MyConstraintMaker {
    var top: MyConstraintItem {
        let item = MyConstraintItem(prop: .top, view: self.view)
        self.constants.append(item)
        return item
    }
    var left: MyConstraintItem {
        let item = MyConstraintItem(prop: .left, view: self.view)
        self.constants.append(item)
        return item
    }
    // 其他属性类似
}
class MyConstraintItem {
    fileprivate weak var view: UIView?
    fileprivate var prop: NSLayoutAttribute
    fileprivate var relation: NSLayoutRelation = .equal
    fileprivate var anotherItem: MyConstraintItem?
    fileprivate var offset: CGFloat = 0
    
    init(prop: NSLayoutAttribute, view: UIView? = nil) {
        self.prop = prop
        self.view = view
    }
    @discardableResult
    func equalTo(_ anotherItem: MyConstraintItem) -> MyConstraintItem{
        self.relation = .equal
        self.anotherItem = anotherItem
        return self
    }
    @discardableResult
    func equalTo(_ value: CGFloat) -> MyConstraintItem{
        self.relation = .equal
        self.anotherItem = MyConstraintItem(prop: self.prop, view: nil)
        self.anotherItem?.offset = 0
        return self
    }
    @discardableResult
    func offset(_ offset: CGFloat) -> MyConstraintItem {
        self.offset = offset
        return self
    }
    fileprivate func getLayoutConstraint() -> NSLayoutConstraint? {
        guard self.anotherItem != nil else {
            return nil
        }
        // 如果自己是一个常量类型约束, 那么就无法只靠自己生NSLayoutConstraint
        guard self.view != nil else {
            return nil
        }
        return NSLayoutConstraint(item: self.view!, attribute: self.prop, relatedBy: self.relation, toItem: self.anotherItem!.view, attribute: self.anotherItem!.prop, multiplier: 1, constant: self.offset)
    }
}
