//
//  NBLabel.h
//  Poker With Friends
//
//  Created by LinO_dska on 24.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSpriteNode;
@class SKLabelNode;
@class SKNode;
@interface NBLabel : NSObject
@property (nonatomic) int value;
@property (nonatomic) NSString *string;
@property SKSpriteNode *left;
@property SKSpriteNode *right;
@property SKSpriteNode *tile;
@property SKLabelNode *label;
@property int pcount;
@property CGPoint position;
@property (nonatomic) int zPosition;
@property (nonatomic) BOOL show;
@property SKNode *parent;
- (id)initWithPosition:(CGPoint)position parent:(SKNode*)parent;
-(void)nonAnimatedHide;
@end
