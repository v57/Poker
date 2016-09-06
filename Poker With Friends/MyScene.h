//
//  MyScene.h
//  Poker With Friends
//

//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class Button;
@class STU;
@class List;
@class Player;

@interface MyScene : SKScene

@property NSArray *players;
@property NSMutableArray *cards;

@property NSMutableArray *buttons;
@property NSMutableArray *activeButtons;
@property Button *selectedButton;

@property NSMutableArray *sliders;
@property NSMutableArray *activeSliders;
@property STU *selectedSlider;

@property NSMutableArray *lists;
@property NSMutableArray *activeLists;
@property List *selectedList;

@property SKSpriteNode *background;

@property (nonatomic) int raiseBetValue;

@property SKColor *greenColor;

@property NSMutableArray*playersData;

@property (nonatomic) BOOL gameStarted;

//GAME INFO
@property int playersCount;

@property Button *start;

// Player buttons
@property Button *raise;
@property Button *call;
@property Button *fold;

// Raise menu
@property BOOL raiseMenuAnimation;
@property (nonatomic) BOOL showRaiseMenu;
@property Button *chip1;
@property Button *chip5;
@property Button *chip25;
@property Button *chip100;
@property Button *chip500;
@property Button *chip1000;
@property Button *chip5000;
@property Button *cancelBet;
@property Button *bet;
@property SKLabelNode *raiseBetLabel;

// Player selection menu
@property (nonatomic) BOOL showPlayerSelectionMenu;
@property Player *selectedPlayer;
@property BOOL PSMIsOpened;
@property Button *PSMConfirm;
@property STU *PSMDelete;
@property List *PSMList;

@end
