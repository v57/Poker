//
//  ViewController.m
//  Poker With Friends
//
//  Created by Dmitry on 20.01.14.
//  Copyright (c) 2014 LinO_dska. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view.
    [self setNeedsStatusBarAppearanceUpdate];
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:CGSizeMake(1024, 768)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    skView.showsNodeCount = YES;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
