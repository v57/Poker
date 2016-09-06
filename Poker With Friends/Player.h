//
//  Player.h
//  Poker With Friends
//
//  Created by Dmitry on 21.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
static const CGPoint playerPos[10] = {
    {.x = 339,.y = 228},
    {.x = 512,.y = 228},
    {.x = 685,.y = 228},
    
    {.x = 890,.y = 355},
    {.x = 890,.y = 560},
    
    {.x = 685,.y = 687},
    {.x = 512,.y = 687},
    {.x = 339,.y = 687},
    
    {.x = 165,.y = 560},
    {.x = 165,.y = 355}
};
@class NBLabel;
@class Card;
@class SKShapeNode;
@class SKNode;
@class MenuCell;
@class Button;
@interface Player : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) int cash;

@property (nonatomic) int bet;

@property Card *card1;
@property Card *card2;
@property NSMutableArray *cards;

@property BOOL playing;
@property (nonatomic) BOOL slotOpened;

@property (nonatomic) BOOL showPlus;
@property (nonatomic) BOOL showBackground;
@property Button *button;

@property SKShapeNode *background;
@property NBLabel *NBName;
@property NBLabel *NBCash;
@property SKSpriteNode *addPlayer;
@property MenuCell *cell;

@property SKNode *parent;

- (id)initWithSlot:(int)slot
            parent:(SKNode*)parent
       buttonArray:(NSMutableArray*)buttonArray
        greenColor:(SKColor*)greenColor;
-(void)clear;
-(void)setName:(NSString *)name cash:(int)cash;
-(void)blink;

@end
