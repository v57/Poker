//
//  MenuCell.m
//  Poker With Friends
//
//  Created by LinO_dska on 30.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "MenuCell.h"
#import <SpriteKit/SpriteKit.h>

#define headSpace 1
#define bodySpace 15
@implementation MenuCell
- (id)initWithCenter:(CGPoint)center
                head:(NSString*)head
                body:(NSString*)body
              border:(int)border
                   y:(float)y
              parent:(SKNode*)parent
{
    self = [super init];
    if (self) {
        self.parent = parent;
        self.cx = center.x;
        self.cy = center.y;
        self.border = border;
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"PMBG"];
        self.background.position = CGPointMake(center.x, center.y-self.border);
        self.head = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
        self.head.fontSize = 16;
        self.head.fontColor = [SKColor blackColor];
        self.head.text = head;
        self.head.position = CGPointMake(center.x, center.y+headSpace-self.border);
        self.body = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        self.body.fontSize = 12;
        self.body.fontColor = [SKColor blackColor];
        self.body.text = body;
        self.body.position = CGPointMake(center.x, center.y-bodySpace-self.border);
        self.onField = YES;
        self.active = YES;
        _y = y;
    }
    return self;
}
-(void)setY:(float)y {
    if(self.onField) {
        int dist = y - self.cy;
        int m = 1;
        if(dist<0) {
            dist = -dist;
            m = -1;
        }
        if(dist>self.border) {
            y -= (dist - self.border)*m;
            //self.onField = NO;
        }
    }
    else {
        int dist = y - self.cy;
        if(dist<0) dist = -dist;
        if(dist<self.border) {
            //self.onField = YES;
        }
    }
    _y = y;
    if(self.onField) {
        self.background.position = CGPointMake(self.cx,y);
        self.head.position = CGPointMake(self.cx,y+headSpace);
        self.body.position = CGPointMake(self.cx,y-bodySpace);
    }
}

-(void)setOnField:(BOOL)onField {
    if(onField != _onField) {
        if(onField) {
            [self.parent addChild:self.background];
            [self.parent addChild:self.head];
            [self.parent addChild:self.body];
        }
        else {
            [self.background removeFromParent];
            [self.head removeFromParent];
            [self.body removeFromParent];
        }
        _onField = onField;
    }
}

-(void)setShow:(BOOL)show {
    if(show != _show) {
        _show = show;
        if(show) {
            [self.background removeAllActions];
            if(!self.background.parent) [self.parent addChild:self.background];
            [self.background runAction:[SKAction fadeAlphaTo:1 duration:0.2f]];
            [self.head removeAllActions];
            if(!self.head.parent) [self.parent addChild:self.head];
            [self.head runAction:[SKAction fadeAlphaTo:1 duration:0.2f]];
            [self.body removeAllActions];
            if(!self.body.parent) [self.parent addChild:self.body];
            [self.body runAction:[SKAction fadeAlphaTo:1 duration:0.2f]];
        }
        else {
            [self.background removeAllActions];
            [self.background runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.background removeFromParent];}];
            [self.head removeAllActions];
            [self.head runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.head removeFromParent];}];
            [self.body removeAllActions];
            [self.body runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.body removeFromParent];}];
        }
    }
}


-(void)removeAllActions {
    [self.background removeAllActions];
    [self.head removeAllActions];
    [self.body removeAllActions];
}
- (void)runAction:(SKAction *)action {
    [self.background runAction:action];
    [self.head runAction:action];
    [self.body runAction:action];
}

-(void)hidePls {
    [self.background removeFromParent];
    [self.head removeFromParent];
    [self.body removeFromParent];
    _show = NO;
}

-(void)remove {
    SKAction *fade = [SKAction fadeAlphaTo:0 duration:0.1];
    [self.background runAction:fade];
    [self.head runAction:fade];
    [self.body runAction:fade completion:^{
        [self.background removeFromParent];
        [self.head removeFromParent];
        [self.body removeFromParent];
    }];
}

-(void)moveToY:(float)y {
    [self.background runAction:[SKAction moveToY:y duration:0.15]];
    [self.head runAction:[SKAction moveToY:y+headSpace duration:0.15]];
    [self.body runAction:[SKAction moveToY:y-bodySpace duration:0.15]];
}
@end