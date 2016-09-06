//
//  STU.m
//  Poker With Friends
//
//  Created by LinO_dska on 27.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "STU.h"
@implementation STU
- (id)initWithName:(NSString*)name
              path:(NSString*)path
          position:(CGPoint)position
             color:(SKColor*)color
              size:(int)size
            length:(int)length
            parent:(SKNode*)parent
{
    self = [super init];
    if (self) {
        _name = name;
        self.size = size;
        self.size2 = size/2;
        self.length = length;
        self.parent = parent;
        self.pos = position;
        self.hitbox = CGRectMake(position.x-self.size2,position.y-self.size2,size,size);
        self.left = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@Left.png",path]];
        self.tile = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@Tile.png",path]];
        self.right = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@Right.png",path]];
        self.left.position = CGPointMake(self.pos.x-7, self.pos.y);
        self.right.position = CGPointMake(self.pos.x+7, self.pos.y);
        self.tile.position = self.pos;
        self.button = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@.png",path]];
        self.button.position = self.pos;
        self.down = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@Down.png",path]];
        self.down.position = self.pos;
        self.label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
        self.label.fontColor = color;
        self.label.position = CGPointMake(self.pos.x+30, self.pos.y-6);
        self.label.fontSize = 14;
        self.label.text = name;
        self.label.alpha = 0;
        self.views = [[NSArray alloc]initWithObjects:self.left,self.tile,self.right,self.label,self.down, nil];
        
    }
    return self;
}
-(BOOL)touchDown:(CGPoint)pos {
    if(CGRectContainsPoint(self.hitbox, pos)) {
        self.clicked = YES;
        [self.label removeAllActions];
        [self.label runAction:[SKAction fadeAlphaTo:1 duration:0.2]];
        [self.label runAction:[SKAction moveTo:CGPointMake(self.pos.x+80, self.pos.y-6) duration:0.2]];
        [self.right runAction:[SKAction moveTo:CGPointMake(self.pos.x+self.length+7, self.pos.y) duration:0.2]];
        [self.tile runAction:[SKAction resizeToWidth:self.length duration:0.2]];
        [self.tile runAction:[SKAction moveTo:CGPointMake(self.pos.x+81, self.pos.y) duration:0.2]];
        [self.button removeFromParent];
        for(SKNode *node in self.views) {
            if(!node.parent) {
                [self.parent addChild:node];
            }
        }
        return YES;
    }
    return NO;
}
-(void)touchMoved:(CGPoint)pos {
    if(pos.x<self.pos.x) {
        pos.x = self.pos.x;
    }
    else if(pos.x>self.pos.x+self.length) {
        pos.x = self.pos.x+self.length;
    }
    float progression = (pos.x - self.pos.x)/self.length;
    self.label.alpha = 1-progression*2;
    self.down.position = CGPointMake(pos.x, self.down.position.y);
    self.down.zRotation = progression*-M_PI*2;
}
-(BOOL)touchUp {
    self.clicked = NO;
    [self.label removeAllActions];
    self.button.position = self.down.position;
    [self.button runAction:[SKAction moveTo:CGPointMake(self.pos.x, self.pos.y) duration:0.2]];
    [self.parent addChild:self.button];
    [self.right runAction:[SKAction moveTo:CGPointMake(self.pos.x+7, self.pos.y) duration:0.2]];
    [self.tile runAction:[SKAction resizeToWidth:1 duration:0.2]];
    [self.tile runAction:[SKAction moveTo:CGPointMake(self.pos.x, self.pos.y) duration:0.2]];
    [self.label runAction:[SKAction fadeAlphaTo:0 duration:0.1]];
    [self.label runAction:[SKAction moveTo:CGPointMake(self.pos.x+30, self.pos.y-6) duration:0.1]];
    [self.button runAction:[SKAction rotateByAngle:M_PI*2 duration:0.2]];
    [self.down removeFromParent];
    [self.label runAction:[SKAction waitForDuration:0.2] completion:^{
        for(SKNode *node in self.views) {
            [node removeFromParent];
        }
    }];
    self.down.zRotation = 0;
    BOOL y = self.down.position.x == self.pos.x+self.length;
    self.down.position = self.pos;
    return y;
}

-(void)setShow:(BOOL)show {
    if(show != _show) {
        _show = show;
        if(show) {
            [self.button removeAllActions];
            if(!self.button.parent) [self.parent addChild:self.button];
            [self.button runAction:[SKAction fadeAlphaTo:1 duration:0.2f]];
        }
        else {
            [self.button removeAllActions];
            [self.button runAction:[SKAction fadeAlphaTo:0 duration:0.2f] completion:^{
                [self.button removeFromParent];
            }];
        }
    }
}

-(void)setName:(NSString*)name {
    _name = name;
    self.label.text = name;
}
@end