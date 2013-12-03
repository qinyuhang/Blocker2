//
//  ViewController.m
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import "ViewController.h"
#pragma mark - View lifecycle

@implementation ViewController

@synthesize gameModel, gameTimer, ball, paddle;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initiate the game model
	gameModel = [[BlockerModel alloc] init];
    //iterate over the blocks in the model, drawing them
    for (BlockView *blockViews in gameModel.blocks) {
        //add the block to the view
        [self.view addSubview:blockViews];
    }
    //draw the paddle
    paddle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paddle.png"]];
    //set the paddle position based on the mocdel
    [paddle setFrame:gameModel.paddleRect];
    [self.view addSubview:paddle];
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    [ball setFrame:gameModel.ballRect];
    [self.view addSubview:ball];
    //set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    //add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)updateDisplay:(CADisplayLink *)sender
{
    //this method is called by the gameTimer each time the display should update, update the model
    [gameModel updateModelWithTime:sender.timestamp];
    //update the display
    [ball setFrame:gameModel.ballRect];
    [paddle setFrame:gameModel.paddleRect];
    
    if ([gameModel.blocks count] == 0) {
        //no more blocks, end the game
        [self endGameWithMessage:@"You destroyed all the blocks, gangsta"];
    }
}

- (void)endGameWithMessage:(NSString *)message
{
    //invalidate the timer
    [gameTimer invalidate];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YOU RUN THIS COURT" message:message delegate:self cancelButtonTitle:@"COOL" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGFloat delta = [t locationInView:self.view].x - [t previousLocationInView:self.view].x;
        CGRect newPaddleRect = gameModel.paddleRect;
        newPaddleRect.origin.x += delta;
        gameModel.paddleRect = newPaddleRect;
    }
}

@end
