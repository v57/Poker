//
//  MenuCell.h
//  Poker With Friends
//
//  Created by LinO_dska on 30.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSpriteNode;
@class SKLabelNode;
@class SKNode;
@class SKAction;

@interface MenuCell : NSObject

@property int cx;
@property int cy;
@property int border;
@property (nonatomic) float y;
@property SKSpriteNode *background;
@property SKLabelNode *head;
@property SKLabelNode *body;
@property (nonatomic) BOOL onField;
@property BOOL active;
@property SKNode *parent;
@property (nonatomic) BOOL show;
@property int position;
- (id)initWithCenter:(CGPoint)center
                head:(NSString*)head
                body:(NSString*)body
              border:(int)border
                   y:(float)y
              parent:(SKNode*)parent;
-(void)moveToY:(float)y;
-(void)removeAllActions;
-(void)runAction:(SKAction*)action;
-(void)hidePls;
-(void)remove;
@end
