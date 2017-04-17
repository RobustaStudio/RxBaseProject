//
//  Operators.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

import UIKit

// Two way binding operator between control property and variable, that's all it takes {

infix operator <-> : DefaultPrecedence

func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument

    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }

    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }

    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
        return text
    }

    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

func <-> <Base: UITextInput>(textInput: TextInput<Base>, variable: Variable<String>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
        .bindTo(textInput.text)
    let bindToVariable = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            /**
             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
             The can be reproed easily if replace bottom code with 
             
             if nonMarkedTextValue != variable.value {
                variable.value = nonMarkedTextValue ?? ""
             }

             and you hit "Done" button on keyboard.
             */
            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != variable.value {
                variable.value = nonMarkedTextValue
            }
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToVariable)
}

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    if T.self == String.self {
#if DEBUG
        fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx_text` property directly to variable.\n" +
            "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
            "REMEDY: Just use `textField <-> variable` instead of `textField.rx_text <-> variable`.\n" +
            "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
#endif
    }

    let bindToUIDisposable = variable.asObservable()
        .bindTo(property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToVariable)
}


// MARK: - IgnoreErrors

extension ObservableType {
  func ignoreErrors() -> Observable<E> {
    return self.catchError { _ in .empty() }
  }
}
    
extension ObservableType {
    func dismissKeyboard() -> Observable<E> {
        return self.do(onNext: { (_) in
            AppDelegate.dismissKeyboard()
        })
    }
    
    func block() -> Observable<E> {
        return self.do(onNext: { (_) in
            AppDelegate.dismissKeyboard()
            AppDelegate.showLoadingProgress()
        })
    }
    
    func unblock() -> Observable<E> {
        return self.do(onNext: { (_) in
            AppDelegate.dismissLoadingProgress()
        }, onError: { (_) in
            AppDelegate.dismissLoadingProgress()
        }, onCompleted: { 
            AppDelegate.dismissLoadingProgress()
        })
    }
    
}

extension Observable where Element: Equatable {
    func ignore(value: Element) -> Observable<Element> {
        return filter { (e) -> Bool in
            return value != e
        }
    }
}

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}


extension Collection where Iterator.Element: ObservableType, Iterator.Element.E: BooleanType {
    
    func combineLatestAnd() -> Observable<Bool> {
        return Observable.combineLatest(self) { bools -> Bool in
            return bools.reduce(true, { (memo, element) in
                return memo && element.boolValue
            })
        }
    }
    
    func combineLatestOr() -> Observable<Bool> {
        return Observable.combineLatest(self) { bools in
            bools.reduce(false, { (memo, element) in
                return memo || element.boolValue
            })
        }
    }
}


protocol BooleanType {
    var boolValue: Bool { get }
}


extension Bool: BooleanType {
    var boolValue: Bool { return self }
}
