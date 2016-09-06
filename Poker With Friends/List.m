//
//  List.m
//  Poker With Friends
//
//  Created by LinO_dska on 30.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//


#import "List.h"
#import "MenuCell.h"
#import <SpriteKit/SpriteKit.h>

@implementation List
- (id)initWithName:(NSString*)name
             array:(NSArray*)array
           keyHead:(NSString*)keyHead
           keyBody:(NSString*)keyBody
          position:(CGPoint)position
            border:(int)border
             space:(int)space
            parent:(SKNode*)parent; {
    self = [super init];
    if(self) {
        self.parent = parent;
        self.data = array;
        self.keyHead = keyHead;
        self.keyBody = keyBody;
        
        self.length = array.count;
        self.border = border;
        self.space = space;
        self.realLength = (self.length-1) * self.space;
        self.realLength2 = self.realLength/2;
        self.center = position;
        
        self.array = [NSMutableArray new];
        for(int i=0;i<self.length;i++) {
            NSDictionary *dick = [array objectAtIndex:i];
            NSString *head = [dick objectForKey:keyHead];
            NSNumber *number = [dick objectForKey:keyBody];
            NSString *body = [NSString stringWithFormat:@"%d",[number intValue]];
            MenuCell *cell = [[MenuCell alloc]initWithCenter:self.center head:head body:body border:self.border y:self.y parent:parent];
            cell.position = i;
            [self.array addObject:cell];
        }
        self.topBorder = [SKSpriteNode spriteNodeWithImageNamed:@"BorderTop.png"];
        self.topBorder.position = CGPointMake(self.center.x, self.center.y+100);
        self.topBorder.zPosition = 2;
        self.bottomBorder = [SKSpriteNode spriteNodeWithImageNamed:@"BorderBottom.png"];
        self.bottomBorder.position = CGPointMake(self.center.x, self.center.y-100);
        self.bottomBorder.zPosition = 2;
        self.hitbox = CGRectMake(self.center.x-90,self.center.y-self.border,180,self.border * 2);
        self.y = 0;
        for(MenuCell *cell in self.array) {
            if(cell.onField) {
                [cell hidePls];
            }
        }
    }
    return self;
}

-(void)setShow:(BOOL)show {
    if(show != _show) {
        _show = show;
        if(show) {
            for(MenuCell *cell in self.array) {
                if(cell.onField) {
                    cell.show = YES;
                }
            }
            [self.topBorder removeAllActions];
            [self.bottomBorder removeAllActions];
            if(!self.topBorder.parent) {
                //[self.parent addChild:self.topBorder    ];
                //[self.parent addChild:self.bottomBorder ];
            }
        }
        else {
            for(MenuCell *cell in self.array) {
                if(cell.onField) {
                    cell.show = NO;
                }
            }
            [self.topBorder removeAllActions];
            [self.bottomBorder removeAllActions];
            [self.topBorder runAction:[SKAction waitForDuration:0.2f] completion:^{
                [self.topBorder removeFromParent];
            }];
            [self.bottomBorder runAction:[SKAction waitForDuration:0.2f] completion:^{
                [self.bottomBorder removeFromParent];
            }];
        }
    }
}

-(BOOL)touchDown:(CGPoint)location {
    if(CGRectContainsPoint(self.hitbox, location)) {
        self.dy = location.y - self.y;
        self.py = location.y;
        return YES;
    }
    else {
        return NO;
    }
}
-(void)touchMoved:(CGPoint)location {
    self.y += location.y - self.py;
    self.py = location.y;
}
-(void)touchUp {
    int dy = self.center.y + self.value*self.space;
    for(int i=self.value-2;i<self.value+3;i++) {
        if(i>=0 && i<self.length) {
            MenuCell *cell = [self.array objectAtIndex:i];
            float celly = dy - self.space * i;
            int dist = celly - cell.cy;
            if(dist<0) dist = -dist;
            if(dist<cell.border) {
                if(!cell.onField) {
                    cell.onField = YES;
                }
            }
            if(cell.onField) {
                [cell moveToY:celly];
            }
        }
    }
}

-(MenuCell*)getSelectedCell {
    return [self.array objectAtIndex:self.value];
}

-(void)removeSelectedCell {
    int dy = self.center.y + self.value*self.space;
    MenuCell *removedCell = [self.array objectAtIndex:self.value];
    if(self.value == self.length-1) {
        int min = self.value - 3;
        if(min<0) min=0;
        for(int i=min;i<self.value;i++) {
            if(i>=0) {
                MenuCell *cell = [self.array objectAtIndex:i];
                float celly = dy - self.space * (i+1);
                [cell moveToY:celly];
            }
        }
        self.value--;
    }
    else {
        int max = self.value + 4;
        if(max>self.length) max = self.length;
        for(int i=self.value+1;i<max;i++) {
            MenuCell *cell = [self.array objectAtIndex:i];
            float celly = dy - self.space * (i-1);
            [cell moveToY:celly];
        }
        for(int i=self.value;i<self.length-1;i++) {
            MenuCell *cell = [self.array objectAtIndex:i+1];
            cell.position--;
            [self.array replaceObjectAtIndex:i withObject:cell];
        }
    }
    [self.array removeObjectAtIndex:self.length-1];
    self.length--;
    [removedCell remove];
    self.realLength -=  self.space;
    self.realLength2 = self.realLength/2;
}

-(void)hideSelectedCell {
    int dy = self.center.y + self.value*self.space;
    MenuCell *cell = [self.array objectAtIndex:self.value];
    cell.active = NO;
    cell.show = NO;
    [self.hidedCells addObject:cell];
    if(self.value == self.length-1) {
        int min = self.value - 3;
        if(min<0) min=0;
        for(int i=min;i<self.value;i++) {
            if(i>=0) {
                MenuCell *cell = [self.array objectAtIndex:i];
                float celly = dy - self.space * (i+1);
                [cell moveToY:celly];
            }
        }
        self.value--;
    }
    else {
        int max = self.value + 4;
        if(max>self.length) max = self.length;
        for(int i=self.value+1;i<max;i++) {
            MenuCell *cell = [self.array objectAtIndex:i];
            float celly = dy - self.space * (i-1);
            [cell moveToY:celly];
        }
        for(int i=self.value;i<self.length-1;i++) {
            MenuCell *cell = [self.array objectAtIndex:i+1];
            cell.position--;
            [self.array replaceObjectAtIndex:i withObject:cell];
        }
    }
    [self.array removeObjectAtIndex:self.length-1];
    self.length--;
    self.realLength -=  self.space;
    self.realLength2 = self.realLength/2;
}

-(void)showCell:(MenuCell*)cell {
    cell.active = YES;
    cell.show = YES;
    int n = -1;
    for(int i=0;i<self.length;i++) {
        MenuCell *cellA = [self.array objectAtIndex:i];
        if(cell.position < cellA.position) {
            n = i;
            break;
        }
    }
    if(n==-1) {
        [self.array addObject:cell];
    }
    else {
        [self.array addObject:[self.array objectAtIndex:self.length-1]];
        for(int i=self.length-2;i>n;i--) {
            MenuCell *cellA = [self.array objectAtIndex:i];
            [self.array replaceObjectAtIndex:i+1 withObject:cellA];
        }
        [self.array replaceObjectAtIndex:n withObject:cell];
    }
    [self.hidedCells removeObject:cell];
}

-(void)setY:(float)y {
    if(y<0) {
        y =  -pow(-y, 1.0/1.3);
    }
    else if(y>0+self.realLength) {
        float a = y - self.realLength;
        y = self.realLength + pow(a, 1.0/1.3);
    }
    _y = y;
    for(int i=self.value-2;i<self.value+3;i++) {
        if(i>=0 && i<self.length) {
            MenuCell *cell = [self.array objectAtIndex:i];
            cell.y = self.center.y + y - self.space * i;
        }
    }
    self.value = roundf(y/(float)self.space);
}

-(void)correctY {
    _y = self.value*(float)self.space;
}

-(void)setValue:(int)value {
    if(value>=self.length) {
        value = self.length-1;
    }
    else if(value<0) {
        value = 0;
    }
    if(_value != value) {
        NSLog(@"%d",value);
        _value = value;
    }
}
float mod(float a) {
    if(a<0) {
        return -a;
    }
    return a;
}
@end
