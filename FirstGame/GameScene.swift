//
//  GameScene.swift
//  FirstGame
//
//  Created by tho dang on 2015-05-19.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    
    
   // Create bird animation node object(sprite node)
        var bird = SKSpriteNode()
        var bg = SKSpriteNode()
        var animationNode = SKSpriteNode ()
    
    
        let scoreCategory: UInt32 = 1 << 3
        let pipeCategory: UInt32 = 1 << 2
    
    
        var sound = SKAction.playSoundFileNamed("bensound-cute.mp3", waitForCompletion: false)
  
        override func didMoveToView(view: SKView) {
            
            playSound(sound)
            //call playSound method when you want
        }
    
        func playSound(sound : SKAction)
        {
        runAction(sound)
    
          //Create Birds
            var birdTexture = SKTexture(imageNamed: "flyingpig2.png")
            var birdTexture1 = SKTexture(imageNamed: "flyingpig3.png")
            var birdTexture2 = SKTexture(imageNamed: "flyingpig4.png")
            var animation = SKAction.animateWithTextures([birdTexture,birdTexture1,birdTexture2], timePerFrame: 0.1)
        
            
            var makePlayerAnimate = SKAction.repeatActionForever(animation)
            //assign texture to the node
            bird = SKSpriteNode(texture: birdTexture)
            
            
            bird.setScale(1.6)
            bird.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.6)
            bird.runAction(makePlayerAnimate)
            //add Physics to Bird
            
            bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
            bird.physicsBody?.dynamic = true
            bird.physicsBody?.allowsRotation = false
            bird.zPosition = 10
            self.addChild(bird)
            
            //define the ground position 
            var ground = SKNode()
            //set the ground position
            ground.position = CGPointMake(0, 0)
            ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width * 2, 150))
            ground.physicsBody?.dynamic = false
            
            self.addChild(ground)
          
            //Intilaize label and create a lable which holds the score
  
            var scoreLabel = SKLabelNode()
            scoreLabel.fontName = "04b_19"
            scoreLabel.fontSize = 100
            scoreLabel.fontColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
            scoreLabel.text = "0"
           
            scoreLabel.position = CGPointMake( CGRectGetMidX( self.frame ), 3 * self.frame.size.height / 4 )
            scoreLabel.zPosition = 100
            
            self.addChild(scoreLabel)
            
            //Add the background
            var backgroundImage = SKTexture(imageNamed: "bground.png")
            var movebg = SKAction.moveByX(-backgroundImage.size().width, y: 0, duration: 15)
            var replacebg = SKAction.moveByX(backgroundImage.size().width, y: 0, duration: 0)
            var moveBGForEver = SKAction.repeatActionForever(SKAction.sequence([movebg,replacebg]))
            
            
            for var i:CGFloat = 0; i < 3; i++ {
            bg = SKSpriteNode(texture: backgroundImage)
            
            
                //looping the background image again and again
            bg.position = CGPointMake(bg.size.width / 2.0 + i * backgroundImage.size().width, CGRectGetMidX(self.frame))
            
            bg.setScale(1.3)
            bg.runAction(moveBGForEver)
            

            self.addChild(bg)
            }
        
            // set up timer
            var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        
    }
    
            func makePipes() {
              
                //Create a gap between 2 pipes ( 4 birds can fit in between the gap )
                var gap = bird.size.height * 4
                //movement amount
                var movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
                // gap offset
                var pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
                // move pipes
                var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.width / 100))
                // removing pipes off the screen
                var removePipes = SKAction.removeFromParent()
                var moveAndRemovePipes = SKAction.sequence([movePipes,removePipes])
                
               
                
                //Creating the Pipe Up
                var pipe1Texture = SKTexture(imageNamed: "pipe1.png")
                var pipe1 = SKSpriteNode(texture: pipe1Texture)
                pipe1.runAction(moveAndRemovePipes)
                //collision detection
                pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
                pipe1.physicsBody?.dynamic = false
                pipe1.physicsBody?.categoryBitMask = pipeCategory
                pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipe1.size.height / 2 + gap / 2 + pipeOffset)
                
                self.addChild(pipe1)
                
                
                //Creating the pipe down
                var pipe2Texture = SKTexture(imageNamed: "pipe2.png")
                var pipe2 = SKSpriteNode(texture: pipe2Texture)
                pipe2.runAction(moveAndRemovePipes)
                //collision detection
                pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
                pipe2.physicsBody?.dynamic = false
                pipe2.physicsBody?.categoryBitMask = pipeCategory
                pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2.size.height / 2 - gap / 2 + pipeOffset)
                
                
                self.addChild(pipe2)
    
            }

  
    
        override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            
        /* Called when a touch begins */
            println("pig is flying")
            //birds'tốc độ
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            //bird's sức đẩy tới
            bird.physicsBody?.applyImpulse(CGVectorMake(0,50))
        
        for touch : AnyObject in touches {
            // we want the bird to go up, location is inside of the scence
         let location = touch.locationInNode(self)

        
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
