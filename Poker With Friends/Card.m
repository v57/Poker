//
//  Card.m
//  Poker With Friends
//
//  Created by Dmitry on 20.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#define TEXTUREPATH @"CardTexture.png"
#define NUMBERFONT @"Helvetica-Light"
#define FRACTIONFONT @"Helvetica"
#define NUMBERFONTSIZE 14
#define FRACTIONFONTSIZE 12
#define FONTCOLOR [SKColor blackColor]
#define FRACTIONPOS CGPointMake(0,-10)
#define NUMBERPOS CGPointMake(0,0)

#import "Card.h"
#import "MyScene.h"
#import <SpriteKit/SpriteKit.h>

@implementation Card
- (id)initWithFraction:(int)fraction number:(int)number superview:(SKNode*)superview {
    self = [super init];
    if (self) {
        _fraction = fraction;
        _number = number;
        self.parent = superview;
        
        NSArray *numbers = [[NSMutableArray alloc]initWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A", nil];
        NSArray *fractions = [[NSMutableArray alloc]initWithObjects:@"♠︎",@"♣︎",@"♥︎",@"♦︎", nil];
        self.texture = [SKSpriteNode spriteNodeWithImageNamed:TEXTUREPATH];
        self.fractionView = [SKLabelNode labelNodeWithFontNamed:FRACTIONFONT];
        self.fractionView.fontColor = FONTCOLOR;
        self.fractionView.fontSize = FRACTIONFONTSIZE;
        self.fractionView.position = FRACTIONPOS;
        self.fractionView.text = [fractions objectAtIndex:fraction];
        self.numberView = [SKLabelNode labelNodeWithFontNamed:NUMBERFONT];
        self.numberView.fontColor = FONTCOLOR;
        self.numberView.fontSize = NUMBERFONTSIZE;
        self.numberView.position = NUMBERPOS;
        self.numberView.text = [numbers objectAtIndex:number];
    }
    return self;
}
-(void)setShow:(BOOL)show {
    if(show != _show) {
        _show = show;
        if(show) {
            [self.texture addChild:self.fractionView];
            [self.texture addChild:self.numberView];
        }
        else {
            [self.fractionView removeFromParent];
            [self.numberView removeFromParent];
        }
    }
}
-(void)setOnField:(BOOL)onField {
    if(onField != _onField) {
        if (onField) [self.parent addChild:self.texture];
        else [self.texture removeFromParent];
    }
}
-(void)setPos:(CGPoint)pos {
    _pos = pos;
    self.texture.position = pos;
}

@end

