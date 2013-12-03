//
//  BlockerModel.m
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import "BlockerModel.h"

@implementation BlockerModel

@synthesize blocks, ballRect, paddleRect;

- (id)init {
    self = [super init];
    if (self) {
        blocks = [[NSMutableArray alloc] initWithCapacity:15];
    
    BlockView *blockViews;
    for (int row = 0; row <= 2; row += 1) {
        for (int col = 0; col < 5; col += 1) {
            blockViews = [[BlockView alloc] initWithFrame:CGRectMake(col * BLOCK_WIDTH, row * BLOCK_HEIGHT, BLOCK_WIDTH, BLOCK_HEIGHT) color:row];
            [blocks addObject:blockViews];
        }
    }
    UIImage *paddleImage = [UIImage imageNamed:@"paddle.png"];
    CGSize paddleSize = [paddleImage size];
    paddleRect = CGRectMake(0.0, 420.0, paddleSize.width, paddleSize.height);
    UIImage *ballImage = [UIImage imageNamed:@"ball.png"];
    CGSize ballSize = [ballImage size];
    ballRect = CGRectMake(180.0, 220.0, ballSize.width, ballSize.height);
    ballVelocity = CGPointMake(200.0, -200.0);
    lastTime = 0.0;
    }
    
    return self;
}

- (void)checkCollisionWithScreenEdges
{
    //change ball direction if it hit an edge of the screen, left edge
    if (ballRect.origin.x <= 0) {
        //flip x velocity component
        ballVelocity.x = abs(ballVelocity.x);
    }
    if (ballRect.origin.x >= VIEW_WIDTH - BALL_SIZE) {
        ballVelocity.x = -1 * abs(ballVelocity.x);
    }
    if (ballRect.origin.y <=0) {
        ballVelocity.y = abs(ballVelocity.y);
    }
    if (ballRect.origin.y >= VIEW_HEIGHT - BALL_SIZE) {
        //went off field, so reset the ball
        ballRect.origin.x = 180.0;
        ballRect.origin.y = 220.0;
        //flip the velocity component
        ballVelocity.y = -1 * abs(ballVelocity.y);
    }
}

- (void)checkCollisionWithBlocks
{
    //iterate over the blocks and check for a collisions
    for (BlockView *blockViews in blocks) {
        //this function returns true of the two rectangles passed in intersect each other
        if (CGRectIntersectsRect(blockViews.frame, ballRect)) {
            //flip the y velocity component
            ballVelocity.y = -ballVelocity.y;
            //remove the blocks from the collection
            [blocks removeObject:blockViews];
            //remove the block's view from the superview
            [blockViews removeFromSuperview];
            break;
        }
    }
}

- (void)checkCollisionWithPaddle
{
    //has paddle blocked ball
    if (CGRectIntersectsRect(ballRect, paddleRect)) {
        ballVelocity.y = -1 * abs(ballVelocity.y);
    }
}

- (void)updateModelWithTime:(CFTimeInterval)timestamp
{
    if (lastTime == 0.0) {
        //initialize the lastTime
        lastTime = timestamp;
    } else {
        //calculate time elapsed since last call
        timeDelta = timestamp - lastTime;
        //update the lastTime
        lastTime = timestamp;
        //calculate the new position of the ball
        ballRect.origin.x += ballVelocity.x * timeDelta;
        ballRect.origin.y += ballVelocity.y * timeDelta;
        //check fro collision with screen edges
        [self checkCollisionWithScreenEdges];
        [self checkCollisionWithBlocks];
        [self checkCollisionWithBlocks];
        [self checkCollisionWithPaddle];
    }
}

@end
