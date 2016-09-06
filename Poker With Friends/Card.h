//
//  Card.h
//  Poker With Friends
//
//  Created by Dmitry on 20.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSpriteNode;
@class SKLabelNode;
@class SKNode;
@interface Card : NSObject

@property (nonatomic) BOOL onField;
@property (nonatomic) BOOL show;

@property (readonly) int fraction;
@property (readonly) int number;

@property SKSpriteNode *texture;
@property SKLabelNode *fractionView;
@property SKLabelNode *numberView;

@property (nonatomic) CGPoint pos;
@property (strong) SKNode *parent;
- (id)initWithFraction:(int)fraction number:(int)number superview:(SKNode*)superview;
@end
