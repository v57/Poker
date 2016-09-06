//
//  Player.m
//  Poker With Friends
//
//  Created by Dmitry on 21.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "Player.h"
#import "Button.h"
#import "NBLabel.h"
@implementation Player
- (id)initWithSlot:(int)slot
            parent:(SKNode*)parent
       buttonArray:(NSMutableArray*)buttonArray
        greenColor:(SKColor*)greenColor
{
    self = [super init];
    if (self) {
        
        self.background = [[SKShapeNode alloc]init];
        self.background.position = playerPos[slot];
        self.background.path = CGPathCreateWithEllipseInRect(CGRectMake(-49, -49, 98, 98), nil);
        self.background.lineWidth = 0;
        self.background.antialiased = NO;
        self.background.strokeColor = [SKColor clearColor];
        self.background.fillColor = greenColor;
        [parent addChild:self.background];
        
        self.addPlayer = [SKSpriteNode spriteNodeWithImageNamed:@"PlayerAdd.png"];
        self.addPlayer.position = playerPos[slot];
        [parent addChild:self.addPlayer];
        
        self.button = [[Button alloc]initWithName:@"PlayerFrame" format:@"png" rounded:YES size:50 pos:playerPos[slot] superview:parent];
        self.button.name = [NSString stringWithFormat:@"Player %d",slot];
        [buttonArray addObject:self.button];
        self.button.show = YES;
        _slotOpened = YES;
        _showPlus = YES;
        _showBackground = YES;
        
        self.NBName = [[NBLabel alloc]initWithPosition:CGPointMake(playerPos[slot].x, playerPos[slot].y+50) parent:parent];
        self.NBName.zPosition = 2;
        [self.NBName nonAnimatedHide];
        self.NBCash = [[NBLabel alloc]initWithPosition:CGPointMake(playerPos[slot].x, playerPos[slot].y-50) parent:parent];
        self.NBCash.zPosition = 2;
        [self.NBCash nonAnimatedHide];

    }
    return self;
}


-(void)clear {
    self.playing = NO;
    _name = nil;
    _cash = 0;
    self.NBName.show = NO;
    self.NBCash.show = NO;
}
-(void)setName:(NSString *)name cash:(int)cash {
    self.name = name;
    self.cash = cash;
    self.NBName.show = YES;
    self.NBCash.show = YES;
    self.playing = YES;
}

-(void)setName:(NSString *)name {
    _name = name;
    self.NBName.string = name;
}

-(void)setCash:(int)cash {
    _cash = cash;
    self.NBCash.value = cash;
}

-(void)setSlotOpened:(BOOL)slotOpened {
    _slotOpened = slotOpened;
    if(slotOpened) {
        if(self.name) {
            [self clear];
        }
        [self.addPlayer runAction:[SKAction rotateByAngle:M_PI_4 duration:0.1f] completion:^{
            self.addPlayer.zRotation = 0;
        }];
    }
    else {
        [self.addPlayer runAction:[SKAction rotateByAngle:-M_PI_4 duration:0.1f]];
    }
}

-(void)blink {
    if(!self.playing) {
        self.addPlayer.alpha = 0.3;
        [self.addPlayer removeAllActions];
        [self.addPlayer runAction:[SKAction fadeAlphaTo:1 duration:0.5]];
    }
}

-(void)setShowBackground:(BOOL)showBackground {
    
    if(showBackground != _showBackground) {
        _showBackground = showBackground;
        if(showBackground) {
            [self.background removeAllActions];
            if(!self.background.parent) [self.parent addChild:self.background];
            [self.background runAction:[SKAction fadeAlphaTo:1 duration:.5f]];
        }
        else {
            [self.background removeAllActions];
            [self.background runAction:[SKAction fadeAlphaTo:0 duration:.5f] completion:^{
                [self.background removeFromParent];
            }];
        }
    }
}

-(void)setShowPlus:(BOOL)showPlus {
    if(showPlus != _showPlus) {
        _showPlus = showPlus;
        if(showPlus) {
            [self.addPlayer removeAllActions];
            if(!self.addPlayer.parent) [self.parent addChild:self.addPlayer];
            [self.addPlayer runAction:[SKAction fadeAlphaTo:1 duration:.5f]];
        }
        else {
            [self.addPlayer removeAllActions];
            [self.addPlayer runAction:[SKAction fadeAlphaTo:0 duration:.5f] completion:^{
                [self.addPlayer removeFromParent];
            }];
        }
    }
}

@end
