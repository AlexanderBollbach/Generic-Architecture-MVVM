//
//  ViewController.swift
//  Generic-Architecture-MVVM
//
//  Created by Alexander Bollbach on 2/14/18.
//  Copyright © 2018 Alexander Bollbach. All rights reserved.
//

import UIKit


protocol RenderableView {
    associatedtype ViewState
    func render(viewState: ViewState)
}

struct Foo {
    let title = "foo"
}

class FooViewController: UIViewController, RenderableView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    func render(viewState: Foo) {
        print(viewState.title)
    }
}

protocol ViewModel {
    associatedtype OwnedView
    associatedtype ViewState
    var viewState: ViewState { get set }
    var ownedView: OwnedView { get }
}

extension ViewModel where OwnedView: RenderableView, ViewState == OwnedView.ViewState {
    func render() {
        ownedView.render(viewState: viewState)
    }
}

struct FooViewModel: ViewModel {
    var ownedView = FooViewController()
    var viewState = Foo()
}


let fooViewModel = FooViewModel()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

