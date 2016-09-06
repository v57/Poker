//
//  List.h
//  Poker With Friends
//
//  Created by LinO_dska on 30.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSpriteNode;
@class SKLabelNode;
@class SKNode;
@class MenuCell;
@interface List : NSObject
@property CGPoint center;
@property NSMutableArray *array;
@property NSMutableArray *hidedCells;
@property CGPoint camPos;
@property SKSpriteNode *topBorder;
@property SKSpriteNode *bottomBorder;
@property int length;
@property int realLength;
@property int realLength2;
@property float dy;
@property (nonatomic) int value;
@property int space;
@property int border;
@property (nonatomic) float y;
@property int py;
@property NSTimer *scrollTimer;
@property SKNode *parent;
@property CGRect hitbox;
@property NSArray *data;
@property NSString *keyHead;
@property NSString *keyBody;

@property (nonatomic) BOOL show;

- (id)initWithName:(NSString*)name
             array:(NSArray*)array
           keyHead:(NSString*)keyHead
           keyBody:(NSString*)keyBody
          position:(CGPoint)position
            border:(int)border
             space:(int)space
            parent:(SKNode*)parent;

-(BOOL)touchDown:(CGPoint)pos;
-(void)touchMoved:(CGPoint)pos;
-(void)touchUp;
-(void)removeSelectedCell;
-(void)hideSelectedCell;
-(void)showCell:(MenuCell*)cell;
-(MenuCell*)getSelectedCell;
@end
