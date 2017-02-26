//
//  ViewController.swift
//  NameDiagnosisApp
//
//  Created by 滝本直樹 on 2017/02/26.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegateの処理をどこに書くか
        nameText.delegate = self
    }
    
    // delegate
    // あるクラスの実装を他のクラスに移譲する
    // Returnキーの処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // sendボタンを推した処理を行う
        self.sendButton.sendActions(for: .touchUpInside)
        
        // 処理止めるときはfalse
        return true
    }
    
    // ビュー表示前の処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameText.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画面遷移するかどうかの処理
    // falseを返すと遷移しない
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "showResult" {
            guard self.nameText.text != "" else {
                // 名前が未入力ならアラート表示
                
                // アラートの表示
                // コントローラ作成
                let alertController = UIAlertController(title: "Error", message: "Please enter your name", preferredStyle: .alert)
                // アクションを作成
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                // アクションの追加
                alertController.addAction(defaultAction)
                // 実行
                self.present(alertController, animated: true, completion: nil)
                
                return false
            }
            return true
        }
        
        // showResult でなければ遷移させる
        return true
    }

    // 遷移する前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // ResultViewController に対してだけ、処理が行われるようにする
        guard let identifier = segue.identifier else {
            // セグエがセットされていなかったら何もしない
            return
        }
        
        // showResult のときだけ動作
        if identifier == "showResult" {
            // お作法？？
            let resultVC = segue.destination as! ResultViewController
            // 入力されたテキストをセット
            resultVC.myName = self.nameText.text!
            
            // テキストボックスのフォーカスを外し、キーボードを隠す
            self.nameText.resignFirstResponder()
        }
        
    }

}

