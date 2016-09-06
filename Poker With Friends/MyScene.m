//
//  MyScene.m
//  Poker With Friends
//
//  Created by Dmitry on 20.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "MyScene.h"
#import "Card.h"
#import "Button.h"
#import "Player.h"
#import "NBLabel.h"
#import "STU.h"
#import "List.h"
#import "MenuCell.h"

#define RaisePosition CGPointMake(442, 38)
#define CallPosition CGPointMake(512, 38)
#define FoldPosition CGPointMake(582, 38)
#define AddPlayerPosition CGPointMake(412, 460)
#define RemovePlayerPosition CGPointMake(612, 460)
#define PlayerListPosition CGPointMake(512, 460)
#define StartPosition CGPointMake(512,150)

static const CGPoint betPos = {.x = 100,.y = 75};
static const CGPoint bet[8] = {
    {.x = 150,.y = 75},
    {.x = 135,.y = 110},
    {.x = 100,.y = 125},
    {.x = 64,.y = 110},
    {.x = 50,.y = 74},
    {.x = 64,.y = 39},
    {.x = 100,.y = 25},
    {.x = 135,.y = 39}
};
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation MyScene
#pragma mark - Allocation
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor blackColor];
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"BG.png"];
        self.background.position = CGPointMake(self.size.width/2, self.size.height/2);
        self.greenColor = [SKColor colorWithRed:0.37647059 green:0.54509804 blue:0.19607843 alpha:1];
        
        self.cards = [NSMutableArray new];
        self.buttons = [NSMutableArray new];
        self.activeButtons = [NSMutableArray new];
        self.sliders = [NSMutableArray new];
        self.activeSliders = [NSMutableArray new];
        self.lists = [NSMutableArray new];
        self.activeLists = [NSMutableArray new];
        
        [self addChild:self.background];
        for(int f = 0;f<4;f++) {
            for(int n = 0;n<13;n++) {
                Card *card = [[Card alloc]initWithFraction:f number:n superview:self];
                card.pos = CGPointMake(50+f*50, 100+n*50);
            }
        }
        
        //init players
        NSMutableArray *players = [NSMutableArray new];
        for(int i = 0;i<10;i++) {
            Player *player = [[Player alloc]initWithSlot:i parent:self buttonArray:self.buttons greenColor:self.greenColor];
            [players addObject:player];
        }
        self.players = players;
        
        //init buttons
        self.start       = [[Button alloc]initWithName:@"StartButton"format:@"png" rounded:NO  size:25 pos:StartPosition        superview:self];
        self.raise       = [[Button alloc]initWithName:@"Raise"      format:@"png" rounded:YES size:25 pos:RaisePosition        superview:self];
        self.call        = [[Button alloc]initWithName:@"Call"       format:@"png" rounded:YES size:25 pos:CallPosition         superview:self];
        self.fold        = [[Button alloc]initWithName:@"Fold"       format:@"png" rounded:YES size:25 pos:FoldPosition         superview:self];
        self.chip1       = [[Button alloc]initWithName:@"Chip1"      format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip5       = [[Button alloc]initWithName:@"Chip5"      format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip25      = [[Button alloc]initWithName:@"Chip25"     format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip100     = [[Button alloc]initWithName:@"Chip100"    format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip500     = [[Button alloc]initWithName:@"Chip500"    format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip1000    = [[Button alloc]initWithName:@"Chip1000"   format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.chip5000    = [[Button alloc]initWithName:@"Chip5000"   format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.cancelBet   = [[Button alloc]initWithName:@"CancelBet"  format:@"png" rounded:YES size:16 pos:betPos               superview:self];
        self.bet         = [[Button alloc]initWithName:@"Bet"        format:@"png" rounded:YES size:25 pos:betPos               superview:self];
        self.PSMConfirm  = [[Button alloc]initWithName:@"AddPlayer"  format:@"png" rounded:YES size:16 pos:AddPlayerPosition    superview:self];
        
        [self.start setHitboxFromSize:CGSizeMake(200, 42)];
        
        [self.buttons addObject:self.start      ];
        [self.buttons addObject:self.raise      ];
        [self.buttons addObject:self.call       ];
        [self.buttons addObject:self.fold       ];
        [self.buttons addObject:self.chip1      ];
        [self.buttons addObject:self.chip5      ];
        [self.buttons addObject:self.chip25     ];
        [self.buttons addObject:self.chip100    ];
        [self.buttons addObject:self.chip500    ];
        [self.buttons addObject:self.chip1000   ];
        [self.buttons addObject:self.chip5000   ];
        [self.buttons addObject:self.cancelBet  ];
        [self.buttons addObject:self.bet        ];
        [self.buttons addObject:self.PSMConfirm ];
        
        self.raiseBetLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"];
        self.raiseBetLabel.fontColor = [SKColor blackColor];
        self.raiseBetLabel.fontSize = 12;
        self.raiseBetLabel.position = CGPointMake(betPos.x, betPos.y-6);
        self.raiseBetLabel.zPosition = 2;
        self.raiseBetLabel.alpha = 0;
        self.raiseBetValue = 0;
        self.bet.texture.zPosition = 2;
        
        //init sliders
        self.PSMDelete = [[STU alloc]initWithName:@"Slide to remove" path:@"STU" position:RemovePlayerPosition color:[SKColor colorWithRed:0.75 green:0 blue:0 alpha:1] size:32 length:165 parent:self];
        [self.sliders addObject:self.PSMDelete];
        
        //init data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Players" ofType:@"plist"];
        self.playersData = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"Players"];
        
        self.PSMList = [[List alloc]initWithName:@"PlayerList" array:self.playersData keyHead:@"Name" keyBody:@"Money" position:CGPointMake(512, 460) border:113 space:50 parent:self];
        [self.lists addObject:self.PSMList];
        
        
        
        //self.PSMDelete.show = YES;
        //self.PSMList.show = YES;
        //self.PSMConfirm.show = YES;
        
        self.start.show = YES;
        
        //self.button = [[Button alloc]initWithName:@"Raise" format:@"png" rounded:YES size:32 pos:CGPointMake(250, 100) superview:self];
        //NBLabel *test = [[NBLabel alloc]initWithPosition:CGPointMake(100, 100.5) parent:self];
        //test.value = 1000000;
        
        [self test];
    }
    return self;
}

-(void)test {
    
}

#pragma mark - Touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        for(Button *button in self.buttons) {
            BOOL click = [button touchDown:location];
            if(click) {
                self.selectedButton = button;
                break;
            }
        }
        for(STU *stu in self.sliders) {
            BOOL click = [stu touchDown:location];
            if(click) {
                self.selectedSlider = stu;
                break;
            }
        }
        for(List *list in self.lists) {
            BOOL click = [list touchDown:location];
            if(click) self.selectedList = list;
        }
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if(self.selectedSlider) [self.selectedSlider touchMoved:location];
        if(self.selectedList) [self.selectedList touchMoved:location];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if(self.selectedSlider) {
            BOOL completed = [self.selectedSlider touchUp];
            if(completed) {
                if(self.selectedSlider == self.PSMDelete) {
                    [self.PSMList removeSelectedCell];
                }
            }
            self.selectedSlider = nil;
        }
        if(self.selectedButton) {
            BOOL click = [self.selectedButton touchUp:location];
            if(click) {
                NSString *name = self.selectedButton.name;
                if(self.selectedButton == self.chip1) {
                    [self raiseBetBy:1];
                }
                else if(self.selectedButton == self.chip5) {
                    [self raiseBetBy:5];
                }
                else if(self.selectedButton == self.chip25) {
                    [self raiseBetBy:25];
                }
                else if(self.selectedButton == self.chip100) {
                    [self raiseBetBy:100];
                }
                else if(self.selectedButton == self.chip500) {
                    [self raiseBetBy:500];
                }
                else if(self.selectedButton == self.chip1000) {
                    [self raiseBetBy:1000];
                }
                else if(self.selectedButton == self.chip5000) {
                    [self raiseBetBy:5000];
                }
                else if(self.selectedButton == self.cancelBet) {
                    [self resetBet];
                }
                else if(self.selectedButton == self.fold) {
                    
                }
                else if(self.selectedButton == self.call) {
                    
                }
                else if(self.selectedButton == self.raise) {
                    if(!self.raiseMenuAnimation) self.showRaiseMenu = 1 - self.showRaiseMenu;
                }
                else if(self.selectedButton == self.PSMConfirm) {
                    self.showPlayerSelectionMenu = NO;
                    MenuCell *cell = [self.PSMList getSelectedCell];;
                    NSString *name = cell.head.text;
                    int cash = [[[self.playersData objectAtIndex:self.PSMList.value]objectForKey:@"Money"]intValue];
                    [self.selectedPlayer setName:name cash:cash];
                    //self.selectedPlayer.cell = cell;
                    //[self.PSMList hideSelectedCell];
                }
                else if(self.selectedButton == self.start) {
                    self.gameStarted = YES;
                }
                else if([name hasPrefix:@"Player"]) {
                    int slot = [name characterAtIndex:7] - 48;
                    Player *player = [self.players objectAtIndex:slot];
                    [self playerButton:player];
                }
            }
            self.selectedButton = nil;
        }
        if(self.selectedList) {
            [self.selectedList touchUp];
            self.selectedList = nil;
        }
        return;
    }
}
#pragma mark - Sets
-(void)setShowRaiseMenu:(BOOL)showRaiseMenu {
    if(showRaiseMenu != _showRaiseMenu) {
        _showRaiseMenu = showRaiseMenu;
        if(showRaiseMenu) {
            self.bet.show = YES;
            self.chip1.show = YES;
            self.raiseMenuAnimation = YES;
            [self.chip1.texture runAction:[SKAction moveTo:bet[0] duration:0.1]];
            [self runAction:[SKAction waitForDuration:0.05] completion:^{
                self.chip5.show = YES;
                [self.chip5.texture runAction:[SKAction moveTo:bet[1] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.1] completion:^{
                self.chip25.show = YES;
                [self.chip25.texture runAction:[SKAction moveTo:bet[2] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.15] completion:^{
                self.chip100.show = YES;
                [self.chip100.texture runAction:[SKAction moveTo:bet[3] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.2] completion:^{
                self.chip500.show = YES;
                [self.chip500.texture runAction:[SKAction moveTo:bet[4] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.25] completion:^{
                self.chip1000.show = YES;
                [self.chip1000.texture runAction:[SKAction moveTo:bet[5] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.3] completion:^{
                self.chip5000.show = YES;
                [self.chip5000.texture runAction:[SKAction moveTo:bet[6] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.35] completion:^{
                self.cancelBet.show = YES;
                [self.cancelBet.texture runAction:[SKAction moveTo:bet[7] duration:0.1]];
            }];
            [self runAction:[SKAction waitForDuration:0.4] completion:^{
                [self addChild:self.raiseBetLabel];
                [self.raiseBetLabel runAction:[SKAction fadeAlphaTo:1 duration:0.2] completion:^{
                    self.raiseMenuAnimation = NO;
                }];
            }];
        }
        else {
            self.raiseMenuAnimation = YES;
            [self.raiseBetLabel runAction:[SKAction fadeAlphaTo:0 duration:0.1] completion:^{
                [self.raiseBetLabel removeFromParent];
            }];
            SKAction *move = [SKAction moveTo:betPos duration:0.1f];
            [self.raiseBetLabel runAction:[SKAction fadeAlphaTo:0 duration:0.1] completion:^{
                [self.raiseBetLabel removeFromParent];
            }];
            [self.cancelBet.texture runAction:move completion:^{
                self.cancelBet.show = NO;
            }];
            [self runAction:[SKAction waitForDuration:0.05] completion:^{
                [self.chip5000.texture runAction:move completion:^{
                    self.chip5000.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.1] completion:^{
                [self.chip1000.texture runAction:move completion:^{
                    self.chip1000.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.15] completion:^{
                [self.chip500.texture runAction:move completion:^{
                    self.chip500.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.2] completion:^{
                [self.chip100.texture runAction:move completion:^{
                    self.chip100.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.25] completion:^{
                [self.chip25.texture runAction:move completion:^{
                    self.chip25.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.3] completion:^{
                [self.chip5.texture runAction:move completion:^{
                    self.chip5.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.35] completion:^{
                [self.chip1.texture runAction:move completion:^{
                    self.chip1.show = NO;
                }];
            }];
            [self runAction:[SKAction waitForDuration:0.60] completion:^{
                self.bet.show = NO;
                self.raiseMenuAnimation = NO;
            }];
        }
    }
}

-(void)setShowPlayerSelectionMenu:(BOOL)showPlayerSelectionMenu {
    _showPlayerSelectionMenu = showPlayerSelectionMenu;
    self.PSMConfirm.show = showPlayerSelectionMenu;
    self.PSMDelete.show = showPlayerSelectionMenu;
    self.PSMList.show = showPlayerSelectionMenu;
}

-(void)setGameStarted:(BOOL)gameStarted {
    if(self.playersCount>1+(int)self.showPlayerSelectionMenu) {
        _gameStarted = gameStarted;
        self.start.show = 1 - gameStarted;
        self.raise.show = gameStarted;
        self.call.show = gameStarted;
        self.fold.show = gameStarted;
        if(_gameStarted) {
            self.showPlayerSelectionMenu = NO;
            for(Player *player in self.players) {
                player.showPlus = NO;
                player.showBackground = player.playing;
                player.button.show = player.playing;
                if(!player.slotOpened && !player.playing) {
                    player.slotOpened = YES;
                }
            }
        }
    }
    else {
        for(Player *player in self.players) {
            [player blink];
        }
    }
}

-(void)resetBet {
    self.raiseBetValue = 0;
}

-(void)raiseBetBy:(int)value {
    
    self.raiseBetValue += value;
    if(self.raiseBetValue > 1000000) {
        value -= self.raiseBetValue - 1000000;
        self.raiseBetValue = 1000000;
    }
}

-(void)setRaiseBetValue:(int)raiseBetValue {
    _raiseBetValue = raiseBetValue;
    self.raiseBetLabel.text = [NSString stringWithFormat:@"%d",raiseBetValue];
}

#pragma mark - Engine
-(Card*)getRandomCard {
    Card *card = [self.cards objectAtIndex:arc4random() % ((int)self.cards.count)];
    if(card.onField) {
        card = [self getRandomCard];
    }
    return card;
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

#pragma mark - Buttons logic
-(void)playerButton:(Player*)player {
    if(!self.gameStarted) {
        if(self.selectedPlayer && self.selectedPlayer != player && self.selectedPlayer.slotOpened == NO && self.selectedPlayer.name == nil) {
            self.selectedPlayer.slotOpened = YES;
            self.playersCount--;
        }
        if(player.slotOpened) {
            player.slotOpened = NO;
            self.playersCount++;
            self.showPlayerSelectionMenu = YES;
        }
        else {
            self.showPlayerSelectionMenu = NO;
            if(player.cell) {
                [self.PSMList showCell:player.cell];
                player.cell = nil;
            }
            player.slotOpened = YES;
            self.playersCount--;
        }
        self.selectedPlayer = player;
    }
}

@end
