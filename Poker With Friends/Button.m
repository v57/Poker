//
//  Button.m
//  Poker With Friends
//
//  Created by Dmitry on 21.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "Button.h"
#import <SpriteKit/SpriteKit.h>

@implementation Button
- (id)initWithName:(NSString*)name
            format:(NSString*)format
           rounded:(BOOL)rounded
              size:(int)size
               pos:(CGPoint)pos
         superview:(SKNode*)superview
{
    self = [super init];
    if (self) {
        self.parent = superview;
        self.name = name;
        self.texture = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@.%@",name,format]];
        self.texture.position = pos;
        self.textureDown = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@Down.%@",name,format]];
        self.textureDown.alpha = 0;
        self.textureDown.position = pos;
        self.rounded = rounded;
        self.size = size;
        _pos = pos;
    }
    return self;
}

-(BOOL)touchDown:(CGPoint)pos {
    if(self.rounded) {
        if(findDistanse(pos,self.pos) < self.size) {
            self.clicked = YES;
            return YES;
        }
        else return NO;
    }
    else {
        if(CGRectContainsPoint(self.hitbox,pos)) {
            self.clicked = YES;
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}

-(BOOL)touchUp:(CGPoint)pos {
    self.clicked = NO;
    return YES;
}

-(void)setClicked:(BOOL)clicked {
    if(_clicked != clicked) {
        if(clicked) {
            [self.textureDown removeAllActions];
            if(!self.textureDown.parent) [self.parent addChild:self.textureDown];
            [self.textureDown runAction:[SKAction fadeAlphaTo:1 duration:0.075f]];
        }
        else {
            [self.textureDown removeAllActions];
            [self.textureDown runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.textureDown removeFromParent]; 
            }];
        }
        _clicked = clicked;
    }
}

-(void)setShow:(BOOL)show {
    if(show != _show) {
        _show = show;
        if(show) {
            [self.texture removeAllActions];
            if(!self.texture.parent) [self.parent addChild:self.texture];
            [self.texture runAction:[SKAction fadeAlphaTo:1 duration:0.2f]];
        }
        else {
            [self.texture removeAllActions];
            [self.texture runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.texture removeFromParent]; 
            }];
        }
    }
}

static float findDistanse(CGPoint f,CGPoint s) {
    float dx = f.x - s.x;
    float dy = f.y - s.y;
    float dist2 = dx*dx + dy*dy;
    float distanse = sqrtf(dist2);
    return distanse;
}

-(void)setHitboxFromSize:(CGSize)size {
    self.hitbox = CGRectMake(self.pos.x - size.width/2,self.pos.y - size.height/2,size.width,size.height);
}
@end
