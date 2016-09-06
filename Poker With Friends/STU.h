//
//  STU.h
//  Poker With Friends
//
//  Created by LinO_dska on 27.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@class SKSpriteNode;
@class SKLabelNode;
@class SKNode;
@interface STU : NSObject
@property CGPoint pos;
@property (nonatomic) NSString *name;
@property SKSpriteNode *tile;
@property SKSpriteNode *left;
@property SKSpriteNode *right;

@property SKSpriteNode *button;
@property SKSpriteNode *down;

@property SKLabelNode *label;
@property SKNode *parent;

@property CGRect hitbox;

@property int size;
@property int size2;
@property int length;

@property NSMutableArray *activeSliders;

@property (nonatomic) BOOL show;
@property (readonly) BOOL showAnimated;
@property (readonly) BOOL showAnimation;
@property NSArray *views;

@property BOOL clicked;
- (id)initWithName:(NSString*)name
              path:(NSString*)path
          position:(CGPoint)position
             color:(SKColor*)color
              size:(int)size
            length:(int)length
            parent:(SKNode*)parent;
-(BOOL)touchDown:(CGPoint)pos;
-(void)touchMoved:(CGPoint)pos;
-(BOOL)touchUp;
@end
