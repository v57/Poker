//
//  Button.h
//  Poker With Friends
//
//  Created by Dmitry on 21.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKSpriteNode;
@class SKNode;

@interface Button : NSObject
@property (nonatomic) BOOL clicked;
@property NSString *name;

//parameters
@property BOOL rounded;
@property int size;
@property CGRect hitbox;
@property (nonatomic) CGPoint pos;

@property SKSpriteNode *texture;
@property SKSpriteNode *textureDown;
@property SKNode *parent;
@property (readonly) BOOL actions;

@property (nonatomic) BOOL show;

- (id)initWithName:(NSString*)name
            format:(NSString*)format
           rounded:(BOOL)rounded
              size:(int)size
               pos:(CGPoint)pos
         superview:(SKNode*)superview;
-(BOOL)touchDown:(CGPoint)pos;
-(BOOL)touchUp:(CGPoint)pos;
-(void)setHitboxFromSize:(CGSize)size;
@end
