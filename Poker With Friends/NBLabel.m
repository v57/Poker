//
//  NBLabel.m
//  Poker With Friends
//
//  Created by LinO_dska on 24.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//
#define symbolSize 7.0f
#import "NBLabel.h"
#import <SpriteKit/SpriteKit.h>

@implementation NBLabel
- (id)initWithPosition:(CGPoint)position parent:(SKNode*)parent
{
    self = [super init];
    if (self) {
        position.y += 0.5f;
        self.left = [SKSpriteNode spriteNodeWithImageNamed:@"NBLeft.png"];
        self.right = [SKSpriteNode spriteNodeWithImageNamed:@"NBRight.png"];
        self.tile = [SKSpriteNode spriteNodeWithImageNamed:@"NBTile.png"];
        
        self.left.position = CGPointMake(position.x-symbolSize/2-5,position.y);
        self.right.position = CGPointMake(position.x+symbolSize/2+5,position.y);
        self.tile.position = position;
        
        self.tile.xScale = symbolSize;
        
        _position = position;
        
        _value = 0;
        self.pcount = 1;
        self.string = @"0";
        self.label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"];
        self.label.fontSize = 12;
        self.label.position = CGPointMake(position.x,position.y-5);
        self.label.text = self.string;
        self.label.fontColor = [SKColor blackColor];
        
        self.parent = parent;
        
    }
    return self;
}
-(void)setValue:(int)value {
    _value = value;
    self.string = [NSString stringWithFormat:@"%d",value];
}
-(void)setString:(NSString *)string {
    _string = string;
    NSUInteger length = self.string.length;
    if(self.pcount != length) {
        self.tile.xScale = symbolSize * length + 1;
        self.left.position = CGPointMake(self.position.x-symbolSize/2.0f*length-5,self.position.y);
        self.right.position = CGPointMake(self.position.x+symbolSize/2.0f*length+5,self.position.y);
        self.pcount = length;
    }
    self.label.text = self.string;
}
-(void)setZPosition:(int)zPosition {
    _zPosition = zPosition;
    self.left.zPosition = zPosition;
    self.right.zPosition = zPosition;
    self.tile.zPosition = zPosition;
    self.label.zPosition = zPosition;
}
-(void)setShow:(BOOL)show{
    if(show != _show ) {
        if(show) {
            SKAction *fade = [SKAction fadeAlphaTo:1 duration:0.2f];
            [self.tile removeAllActions];
            [self.left removeAllActions];
            [self.right removeAllActions];
            [self.label removeAllActions];
            if(!self.tile.parent) {
                [self.parent addChild:self.tile];
                [self.parent addChild:self.left];
                [self.parent addChild:self.right];
                [self.parent addChild:self.label];
            }
            [self.tile runAction:fade];
            [self.left runAction:fade];
            [self.right runAction:fade];
            [self.label runAction:fade];
        }
        else {
            SKAction *fade = [SKAction fadeAlphaTo:0 duration:0.2f];
            [self.tile removeAllActions];
            [self.tile runAction:fade completion:^{
                [self.tile removeFromParent];
            }];
            [self.left removeAllActions];
            [self.left runAction:fade completion:^{
                [self.left removeFromParent];
            }];
            [self.right removeAllActions];
            [self.right runAction:fade completion:^{
                [self.right removeFromParent];
            }];
            [self.label removeAllActions];
            [self.label runAction:fade completion:^{
                [self.label removeFromParent];
            }];
        }
        _show = show;
    }
    
}
-(void)nonAnimatedHide {
    _show = NO;
    [self.tile removeFromParent];
    [self.left removeFromParent];
    [self.right removeFromParent];
    [self.label removeFromParent];
    self.tile.alpha = 0;
    self.left.alpha = 0;
    self.right.alpha = 0;
    self.label.alpha = 0;
}
@end
