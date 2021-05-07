//
//  Gameplay.swift
//  XPlore
//
//  Created by Bryan Khufa on 06/05/21.
//

import SwiftUI
import SpriteKit

class NpcShip: SKSpriteNode {
    var id: Int = 0
}

class GameScene: SKScene {
    //    @EnvironmentObject var modelData: ModelData
    
    let shipSize = CGSize(width: 50, height: 50)
    let velocityMultiplier: CGFloat = 0.12
    let npcs: [Explorer] = ModelData().explorers
    var chat: String = ""
    let elementSize = CGFloat(0.2)
    let mapSize = CGFloat(300)
    var allShips = [Int: SKNode]()
    var targetIndex: Int = 9
    var pauseGame: Bool = false
    
    let nc = NotificationCenter.default
    
    
    var playerShip: String = "Ship1"
    
    let fireParticles = SKEmitterNode(fileNamed: "RocketParticle.sks")
    
    enum NodeZPosition: CGFloat {
        case background, ship, joystick
    }
    
    lazy var topScreen: SKNode = {
        let node = SKNode()
        node.position = CGPoint(x: 0, y: 500)
        
        return node
    }()
    
    lazy var cam: SKCameraNode = {
        let camera = SKCameraNode()
        let range = SKRange(constantValue:0)
        let positionConstraint = SKConstraint.distance(range, to: player)
        
        camera.constraints = [positionConstraint]
        return camera
    }()
    
    lazy var player: SKSpriteNode = {
        let sprite = SKSpriteNode(imageNamed: playerShip)
        sprite.position = CGPoint.zero
        sprite.scaleTo(screenWidthPercentage: elementSize)
        sprite.zPosition = NodeZPosition.ship.rawValue
        sprite.name = "playerShip"
        
        return sprite
    }()
    
    lazy var analogJoyStick: AnalogJoystick = {
        let js = AnalogJoystick(diameter: 120)
        js.position = CGPoint(x: 0.5, y: ScreenSize.height * -0.45 + js.radius + 45)
        js.zPosition = NodeZPosition.joystick.rawValue
        js.stick.color = UIColor.systemGray2
        js.substrate.color = UIColor.gray
        
        return js
    }()
    
    lazy var pauseBtn: SKSpriteNode = {
        let btn = SKSpriteNode(imageNamed: "Love")
        btn.name = "pauseBtn"
        btn.position = CGPoint(x: 120, y: -200)
        btn.scaleTo(screenWidthPercentage: 0.15)
        
        return btn
    }()
    
    func addParticle(node: SKNode) {
        fireParticles!.position = CGPoint(x: node.position.x, y: node.position.y + -50)
        fireParticles!.zPosition = NodeZPosition.background.rawValue
        fireParticles!.particleBirthRate = 0
        node.addChild(fireParticles!)
    }
    
    func spawnNPC() {
        
        for i in 0 ... npcs.count - 1 {
            let fire = SKEmitterNode(fileNamed: "RocketParticle.sks")
            
            let sprite = NpcShip(imageNamed: npcs[i].ship!)
            sprite.name = "npcShip"
            sprite.id = i
            //            shipName(i: i, sprite: sprite)
            
            sprite.scaleTo(screenWidthPercentage: elementSize)
            sprite.position = CGPoint(x: CGFloat(npcs[i].coordX), y: CGFloat(npcs[i].coordY))
            sprite.zPosition = NodeZPosition.ship.rawValue
            
            
            fire?.position = CGPoint(x: 0,y: -50)
            
            sprite.addChild(fire!)
            addChild(sprite)
            
            sprite.run(
                SKAction.repeatForever(
                    SKAction.sequence([randomMove()])))
            
            allShips[i] = sprite
        }
    }
    
    func shipName(i: Int, sprite: SKNode) {
        let targetLabel = SKLabelNode(fontNamed: "SF")
        targetLabel.text = npcs[i].name
        targetLabel.zPosition = NodeZPosition.ship.rawValue
        targetLabel.horizontalAlignmentMode = .center
        targetLabel.verticalAlignmentMode = .center
        targetLabel.position = CGPoint(x: 0, y: 50)
        targetLabel.preferredMaxLayoutWidth = 250
        targetLabel.numberOfLines = 2
        
        let lookAtConstraint = SKConstraint.orient(to: topScreen, offset: SKRange(constantValue: -CGFloat.pi / 2))
        
        targetLabel.constraints = [ lookAtConstraint ]
        
        sprite.addChild(targetLabel)
    }
    
    func newCoords() -> CGPoint {
        let randCoordX = random(min: -10, max: 10) * mapSize
        let randCoordY = random(min: -10, max: 10) * mapSize
        return CGPoint(x: randCoordX, y: randCoordY)
    }
    
    func randomMove() -> SKAction {
        let coords = newCoords()
        let coords2 = newCoords()
        let coords3 = newCoords()
        
        let speed = random(min: CGFloat(10), max: CGFloat(15))
        let angleOffset = CGFloat(90)
        
        let angle = atan2(coords.y, coords.x) - angleOffset
        let angle2 = atan2(coords2.y, coords2.x) - angleOffset
        let angle3 = atan2(coords3.y, coords3.x) - angleOffset
//        let move = SKAction.moveBy(x: coords.x, y: coords.y, duration: TimeInterval(speed))
        let move = SKAction.move(to: CGPoint(x: coords.x, y: coords.y), duration: TimeInterval(speed))
        let move2 = SKAction.move(to: CGPoint(x: coords2.x, y: coords2.y), duration: TimeInterval(speed))
        let move3 = SKAction.move(to: CGPoint(x: coords3.x, y: coords3.y), duration: TimeInterval(speed))
        
        let rotate = SKAction.rotate(toAngle: angle, duration: 0.5)
        let rotate2 = SKAction.rotate(toAngle: angle2, duration: 0.5)
        let rotate4 = SKAction.rotate(toAngle: angle3, duration: 0.5)
        let rotate3 = SKAction.rotate(byAngle: angle3, duration: 1)
        let wait = SKAction.wait(forDuration: 5)
        
        let seq = SKAction.sequence([rotate, move, wait, rotate2, move2, rotate3, wait, move3])
        return seq
    }
    
    func checkCollision() {
        enumerateChildNodes(withName: "npcShip"){ node, _ in
            let npc = node as! NpcShip
            if npc.frame.intersects(self.player.frame) {
                //                print(npc.id)
                print(self.npcs[npc.id].name)
                return
            }
        }
    }
    
    func checkPause() {
        if pauseGame {
            for node in self.children as [SKNode] {
                node.isPaused = true
            }
        } else {
            for node in self.children as [SKNode] {
                node.isPaused = false
            }
        }
    }
    
    func setupJoystick(){
        cam.addChild(analogJoyStick)
        
        analogJoyStick.trackingHandler = { [unowned self] data in
            self.player.position = CGPoint(x: self.player.position.x + (data.velocity.x * self.velocityMultiplier), y: self.player.position.y + (data.velocity.y * self.velocityMultiplier))
            self.player.zRotation = data.angular
            fireParticles!.particleBirthRate = 200
        }
        
        analogJoyStick.stopHandler = { [unowned self] in
            fireParticles!.particleBirthRate = 0
            
        }
    }
    
    func createSpace(){
        let groundTexture = SKTexture(imageNamed: "SpaceBackground")
        
        for i in 0 ... 99 {
            for j in 0 ... 99 {
                let ground = SKSpriteNode(texture: groundTexture)
                ground.zPosition = NodeZPosition.background.rawValue
                ground.position = CGPoint(x: ((-50 * groundTexture.size().width) + (groundTexture.size().width * CGFloat(i))), y: ((-50 * groundTexture.size().height) + (groundTexture.size().height * CGFloat(j))))
                
                addChild(ground)
            }
        }
    }
    
    func compass() {
        let target = allShips[targetIndex]!
        let pointer = SKSpriteNode(imageNamed: "Arrow")
        pointer.zPosition = NodeZPosition.joystick.rawValue
        pointer.scaleTo(screenWidthPercentage: 0.15)
        pointer.position = CGPoint(x: ScreenSize.width - 250, y: 300)
        cam.addChild(pointer)
        
        let lookAtConstraint = SKConstraint.orient(to: target,
                                                   offset: SKRange(constantValue: 0))
        
        pointer.constraints = [ lookAtConstraint ]
    }
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: String] {
            for (message, value) in data {
                print("\(message) \(value)")
                drawChat(chatText: value)
            }
        }
    }
    
    func drawChat(chatText: String) {
        let chatLabel = SKLabelNode(fontNamed: "San Francisco")
        chatLabel.text = chatText
        chatLabel.preferredMaxLayoutWidth = 250
        chatLabel.verticalAlignmentMode = .center
        chatLabel.numberOfLines = 2
        chatLabel.position = CGPoint(x: 0, y: 100)
        chatLabel.fontSize = CGFloat(18.0)
        chatLabel.fontColor = UIColor.black
        chatLabel.zPosition = 1000
        
        let bg = SKShapeNode(rectOf: CGSize(width: chatLabel.frame.width + 10, height: chatLabel.frame.height + 10), cornerRadius: 10)
        bg.fillColor = UIColor.white
        bg.strokeColor = UIColor.white
        bg.zPosition = -100
        
        chatLabel.addChild(bg)
        
        func spawn(){
            cam.addChild(chatLabel)
        }
        
        func destroy() {
            chatLabel.removeFromParent()
        }
        
        run(SKAction.sequence([
            SKAction.run(spawn),
            SKAction.wait(forDuration: 5),
            SKAction.run(destroy)
        ])
        )
        
    }
    
    func drawUI() {
        let targetLabel = SKLabelNode(fontNamed: "San Fransisco")
        targetLabel.text = npcs[targetIndex].name
        targetLabel.zPosition = NodeZPosition.joystick.rawValue
        targetLabel.horizontalAlignmentMode = .left
        targetLabel.verticalAlignmentMode = .center
        targetLabel.position = CGPoint(x: ScreenSize.width - 550, y: 300)
        targetLabel.preferredMaxLayoutWidth = 250
        targetLabel.numberOfLines = 2
        
        cam.addChild(targetLabel)
        //        cam.addChild(pauseBtn)
    }
    
    func setupNodes(){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        createSpace()
        compass()
        drawUI()
        
        addChild(player)
        addChild(cam)
        scene?.camera = cam
    }
    
    // MARK: - Override Functions
    
    override func didMove(to view: SKView) {
        //        chat = modelData.chat
        
        targetIndex = Int(random(min: 0, max: 90))
        
        setupJoystick()
        spawnNPC()
        setupNodes()
        
        addParticle(node: player)
        self.pauseGame = false
        
        nc.addObserver(self, selector: #selector(onDidReceiveData), name: Notification.Name("chat"), object: nil)
        
    }
    
    override func didEvaluateActions() {
        checkCollision()
        checkPause()
        //        print(chat)
    }
}

struct Gameplay: View {
    @EnvironmentObject var modelData: ModelData
    
    var scene: SKScene {
        let scene = GameScene()
        scene.playerShip = modelData.explorers[0].ship!
        scene.size = ScreenSize.size
        scene.scaleMode = .fill
        //        scene.pauseGame = pauseState
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: ScreenSize.width, height: ScreenSize.height, alignment: .center)
            .edgesIgnoringSafeArea([.top, .leading, .trailing])
    }
}

struct Gameplay_Previews: PreviewProvider {
    static var previews: some View {
        Gameplay()
    }
}
