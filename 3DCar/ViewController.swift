//
//  ViewController.swift
//  3DCar
//
//  Created by Turboks on 2022/3/24.
//

import UIKit
import SceneKit

let kswidth = UIScreen.main.bounds.size.width
let ksheight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    var scnView : SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
    }
    
    func initView() {
        
        let path = Bundle.main.path(forResource: "ks_car", ofType: "dae")!
        let source = SCNSceneSource.init(url: URL(fileURLWithPath: path), options: nil)
        let scene = source?.scene(options: nil)
        
        //添加灯光效果 omni：点光源、方向360度，可衰减
        let lightNode = SCNNode.init()
        lightNode.light = SCNLight()
        lightNode.light?.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3Make(0, 0, 300)
        scene?.rootNode.addChildNode(lightNode)
        
        scnView = SCNView.init(frame: CGRect(x: 0, y: 0, width: kswidth, height: 500))
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.white
        scnView.scene = scene
        self.view.addSubview(scnView)
        
        initTypes()
    }
    
    func initTypes() {
        //循环创建按钮
        let arr = ["轮胎","轮毂","车身","尾翼","玻璃","车灯"]
        for i in 0..<arr.count {
            let x = i / 3
            let y = i % 3
            let btn = UIButton.init(frame: CGRect(x: Int(kswidth)/3 * y, y:  520 + x * 110, width: Int(kswidth - 9)/3, height: 100))
            btn.setTitle(arr[i], for: .normal)
            btn.backgroundColor = UIColor.lightGray
            btn.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
            btn.tag = i
            self.view.addSubview(btn)
        }
        
    }
    
    @objc func changeColor(btn: UIButton) {
        //根据名称获取对应的模块  修改： 点开ks_car.dae文件，可以查看左边的node节点、根据需求选择对应的模块
        let arr = ["car4","car1","car70","car35","car31","car80"]
        let node = scnView.scene?.rootNode.childNode(withName: arr[btn.tag], recursively: true)
        //生成随机色
        let red = CGFloat(arc4random() % 256)/255.0
        let blue = CGFloat(arc4random() % 256)/255.0
        let green = CGFloat(arc4random() % 256 )/255.0
        let color = UIColor.init(red: red, green:green, blue: blue, alpha: 1.0)
        node?.geometry?.firstMaterial?.diffuse.contents = color

    }
    
}

