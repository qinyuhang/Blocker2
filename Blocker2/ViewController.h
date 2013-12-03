//
//  ViewController.h
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BlockView.h"
#import "BlockerModel.h"

@interface ViewController : UIViewController

@property BlockerModel *gameModel;
@property CADisplayLink *gameTimer;
@property UIImageView *ball;
@property UIImageView *paddle;


- (void)updateDisplay:(CADisplayLink *)sender;
- (void)endGameWithMessage:(NSString *)message;

@end
