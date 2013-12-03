//
//  BlockerModel.h
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockView.h"

#define BLOCK_HEIGHT 20.0
#define BLOCK_WIDTH 64.0
#define BALL_SIZE 30.0
#define VIEW_WIDTH 320.0
#define VIEW_HEIGHT 460.0

@interface BlockerModel : NSObject {
    NSMutableArray* blocks;
    CGRect paddleRect;
    CGRect ballRect;
    CGPoint ballVelocity;
    CGFloat lastTime;
    CGFloat timeDelta;
}

@property (readonly) NSMutableArray *blocks;
@property (readonly) CGRect ballRect;
@property CGRect paddleRect;

- (void) updateModelWithTime:(CFTimeInterval)timestamp;
- (void) checkCollisionWithScreenEdges;
- (void) checkCollisionWithBlocks;
- (void) checkCollisionWithPaddle;

@end