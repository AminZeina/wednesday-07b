// Created on: Nov 2018
// Created by: Amin Zeina
// Created for: ICS3U
// This program has moving spaceship with bullets

// this will be commented out when code moved to Xcode
import PlaygroundSupport


import SpriteKit

class SplashScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let background = SKSpriteNode(imageNamed: "IMG_2066.JPG")
    let moveToNextSceneDelay = SKAction.wait(forDuration: 2.0)
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.5, green:0, blue:0, alpha: 1.0)
        background.position = CGPoint(x: screenSize.width / 2, y: 200)
        background.name = "Background"
        self.addChild(background)
        background.setScale(1)
        
        background.run(moveToNextSceneDelay){
            let mainMenuScene = MainMenuScene(size: self.size)
            self.view!.presentScene(mainMenuScene)
        }
            
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        let mainMenuScene = MainMenuScene(size: self.size)
        self.view!.presentScene(mainMenuScene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
}

class MainMenuScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let startButton = SKSpriteNode(imageNamed: "IMG_2181.PNG")
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)
        startButton.position = CGPoint(x: screenSize.width / 2, y: 150)
        startButton.name = "start button"
        self.addChild(startButton)
        startButton.setScale(0.65)
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var nodeTouched = self.atPoint(location)
        
        if let nodeTouchedName = nodeTouched.name{
            if nodeTouchedName == "start button" {
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene)
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let ship = SKSpriteNode(imageNamed: "spaceShip.png")
    let rightButton = SKSpriteNode(imageNamed: "rightButton.png")
    let leftButton = SKSpriteNode(imageNamed: "leftButton.png")
    let shootButton = SKSpriteNode(imageNamed: "redButton.png")
    var missiles = [SKSpriteNode]()
    
    var rightButtonClicked = false
    var leftButtonClicked = false
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 1, green:0.15, blue:0.3, alpha: 1.0)
        
        ship.position = CGPoint(x: screenSize.width / 2, y: 100)
        ship.name = "space ship"
        self.addChild(ship)
        ship.setScale(0.65)
        
        rightButton.position = CGPoint(x: 300, y: 100)
        rightButton.name = "right button"
        self.addChild(rightButton)
        rightButton.setScale(0.7)
        rightButton.alpha = 0.5
        
        leftButton.position = CGPoint(x: 100, y: 100)
        leftButton.name = "left button"
        self.addChild(leftButton)
        leftButton.setScale(0.7)
        leftButton.alpha = 0.5
        
        shootButton.position = CGPoint(x: frame.size.width - 75, y: 100)
        shootButton.name = "shoot button"
        self.addChild(shootButton)
        shootButton.setScale(0.7)
        shootButton.alpha = 0.5
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        // move ship if buttons are clicked 
        if rightButtonClicked == true && ship.position.x <= screenSize.width - 150 {
            var moveShipRight = SKAction.moveBy(x: 10, y: 0, duration: 0.1)
            ship.run(moveShipRight)
        } else if leftButtonClicked == true && ship.position.x >= 50 {
            var moveShipLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
            ship.run(moveShipLeft)
        } 
        
        for aSingleMissile in missiles {
            if aSingleMissile.position.y > frame.size.height {
                aSingleMissile.removeFromParent()
                missiles.removeFirst()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check if buttons are clicked
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var nodeTouched = self.atPoint(location)
        
        if let nodeTouchedName = nodeTouched.name{
            if nodeTouchedName == "right button" {
                rightButtonClicked = true 
            } else if nodeTouchedName == "left button" {
                leftButtonClicked = true
            } else if nodeTouchedName == "shoot button" {
                // shoot missile
                
                let aMissile = SKSpriteNode(imageNamed: "missile.png")
                aMissile.position = CGPoint(x: ship.position.x, y: 100)
                aMissile.name = "single missile"
                self.addChild(aMissile)
                aMissile.setScale(1)
                let shootMissile = SKAction.moveTo(y: frame.size.height + 75, duration: 1)
                aMissile.run(shootMissile)
                missiles.append(aMissile)
                
                //make sound
                aMissile.run(SKAction.playSoundFileNamed("laser1.wav", waitForCompletion: false))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check if buttons stopped being pressed
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var nodeTouched = self.atPoint(location)
        
        if let nodeTouchedName = nodeTouched.name{
            if nodeTouchedName == "right button" {
                rightButtonClicked = false 
            } else if nodeTouchedName == "left button" {
                leftButtonClicked = false
            }
        }
    }
}

// this will be commented out when code moved to Xcode

// set the frame to be the size for your iPad
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

let scene = SplashScene(size: frame.size)
scene.scaleMode = SKSceneScaleMode.resizeFill

let skView = SKView(frame: frame)
skView.showsFPS = true
skView.showsNodeCount = true
skView.presentScene(scene)

PlaygroundPage.current.liveView = skView

