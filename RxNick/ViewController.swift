//
//  ViewController.swift
//  RxNick
//
//  Created by Nick McConnell on 11/3/16.
//  Copyright © 2016 Nick McConnell. All rights reserved.
//..

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet var aTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = DummySocketTheremostatDataService.instance
        self.runExample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    let disposeBag = DisposeBag()
    
    func runExample() {
        
        // OBSERVABLE //
        
        // really simple
        
//        let observer = Observable.of(1,2,3,4,5)
//        
//        observer
//            .map {number in
//                return "New \(number)"
//            }
//            .subscribe(onNext: {element in
//                print(element)}
//            )
//            .addDisposableTo(disposeBag)
//
//
//        print("boo")
        
        // separate
        let fiveSecondObservable = Observable<String>.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                // Do background work
                for i in 0..<10 {
                    observer.onNext("\(5*i)🐣")
                    Thread.sleep(forTimeInterval: 5)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }

        let twoSecondObservable = Observable<String>.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                // Do background work
                for i in 0..<25 {
                    observer.onNext("\(2*i)")
                    Thread.sleep(forTimeInterval: 2)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }

        let oneSecondObservable = Observable<String>.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                // Do background work
                for i in 0..<50 {
                    observer.onNext("\(i).")
                    Thread.sleep(forTimeInterval: 1)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
//        //EXAMPLE OF COMBINING
//         let combination = Observable.combineLatest(oneSecondObservable,  fiveSecondObservable) {a, c in
//         return a + " " + c
//         }.subscribe {next in
//         if let stuff = next.element {
//         print(stuff)
//         }
//         }
//         combination.addDisposableTo(disposeBag)
//        
//        // OBSERVER //
//        _ = fiveSecondObservable.subscribe {element in
//            print(element)
//        }.addDisposableTo(disposeBag)
////
//
//        fiveSecondObservable.subscribe(onNext: { element in
//            print(element)
//        }).addDisposableTo(disposeBag)
        
//        //EXAMPLE OF BEHAVIOUR SUBJECT
//        let string = BehaviorSubject(value: "hello")
//        string.subscribe {
//            print($0)
//        }.addDisposableTo(disposeBag)
//        
//        string.on(.next("World!"))
//        string.on(.next("Bla bla"))
//
//        //EXAMPLE OF VARIABLES
//        let stringVariable = Variable("A")
//        stringVariable.asObservable().subscribe {
//            print("> \($0)")
//        }.addDisposableTo(disposeBag)
//        stringVariable.value = "b"
//        stringVariable.value = "last"
//
        //EXAMPLE OF SIMPLE, INSTANT EVENTING
//        Observable.of("A","A","B","123")
//            .distinctUntilChanged()
//            .map {">" + $0 + "<" }
//            .subscribe { print($0) }
//            .addDisposableTo(disposeBag)
//
//        
//        print("--------------")
//        //Observable.of("A","A","B","123").delay(2, scheduler: MainScheduler.instance).subscribe {x in print("delay:\(x)")}.addDisposableTo(disposeBag)
//        //Observable.of("A","A","B","123").buffer(timeSpan: 5, count: 2, scheduler: MainScheduler.instance).subscribe {x in print("delay:\(x)")}.addDisposableTo(disposeBag)
//        
        //EXAMPLE OF MULTIPLE SCUBSCRIPTIONS
//        let strings1 = Observable.of("A1","B1","C1","D1","E1","F1")
//        strings1
//            .subscribe{print("1:\($0)")} //will also be called onCompleted
//            .addDisposableTo(disposeBag)
//        strings1
//            .subscribe(onNext:  {print("2:\($0)")}, onError: nil , onCompleted: nil, onDisposed: nil)
//            .addDisposableTo(disposeBag)
//
//        
        //EXMAPLE OF ZIP, TAKE AND INTERVAL
//        print("MainThread:\(Thread.isMainThread)")
//        let strings = Observable.of("A","B","C","D","E","F")
//        let tick = Observable<Int>
//            .interval(1, scheduler: MainScheduler.instance)
//            .take(5)
//        let timed = Observable.zip(strings, tick, resultSelector: {s, t in
//            //print("Zip MainThread:\(Thread.isMainThread)")
//            return "\(s) - \(t)"
//        })
//        let observable = timed
//        observable
//            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
//            .subscribe {s in
//                print(s)
//                print("subscribed2 MainThread:\(Thread.isMainThread)")
//            }
//            .addDisposableTo(disposeBag)
//        print("Next")
//
        //EXAMPLE OF DO
//        let stringsDo = Observable.of("A1","B1","C1","D1","E1","F1")
//        stringsDo
//            .do(onNext: {_ in print("do")},
//                onError: nil,
//                onCompleted: nil,
//                onSubscribe: {_ in print("subsribe")},
//                onDispose: {_ in print("dispose")})
//            .subscribe{print("DO:\($0)")} //will also be called onCompleted
//            .addDisposableTo(disposeBag)
//
//        //EXAMPLE OF FLATMAP
//        Observable<Int>
//            .interval(10, scheduler: MainScheduler.instance)
//            .take(5)
//            .flatMap({i in
//            return Observable<Int>
//                .interval(1, scheduler: MainScheduler.instance)
//                .take(5)
//                .map{x in return "\(i):\(x)"}
//            })
//            .subscribe{s in print("FM:\(s)")}
//            .addDisposableTo(disposeBag)
        
        //EXAMPLE OF SUBJECT ACTING AS OBSERVER AND OBERSERVABLE
//        let observableX = Observable.of(10,20,30,40,50)
//        let subjectX = BehaviorSubject(value: 1)
//        subjectX.asObservable()
//            .subscribe{b in
//                print("B:\(b)")
//            }
//            .addDisposableTo(disposeBag)
//        observableX
//            .subscribe(subjectX)
//            .addDisposableTo(disposeBag)
//        
        
    }
}

