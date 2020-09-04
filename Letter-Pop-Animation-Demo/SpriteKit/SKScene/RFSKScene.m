//
//  PFSKScene.m
//  PushCha
//
//  Created by Ryan David Forsyth on 2020-04-27.
//  Copyright © 2020 Paul Boucher. All rights reserved.
//

#import "RFSKScene.h"

@interface RFSKScene()

@end

@implementation RFSKScene

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    self.scene.backgroundColor = UIColor.clearColor;
}

- (void)addConfettiEmitterWithPosition:(CGPoint)position {
    SKEmitterNode *emitter = [SKEmitterNode nodeWithFileNamed:@"ConfettiPop2"];
        
    NSArray *colorArray = @[
    UIColor.systemRedColor,
    UIColor.systemBlueColor,
    UIColor.systemOrangeColor,
    UIColor.systemYellowColor,
    UIColor.systemPinkColor
    ];
    
    emitter.position = position;
    
    emitter.particleColorSequence = nil;
    
    emitter.particleColorBlendFactor = 1.0;
    
    [self addChild:emitter];
    
    SKAction *action = [SKAction runBlock:^{
        emitter.particleColor = [colorArray objectAtIndex: arc4random_uniform((uint32_t)colorArray.count)];
        //        NSLog(@"%lu",(unsigned long)random);
    }];
    
    SKAction *wait = [SKAction waitForDuration:0.05];
    
    [self runAction: [SKAction repeatActionForever: [SKAction sequence:@[action,wait]]]];
}


@end
