//
//  BlockView.h
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RED_COLOR 0
#define GREEN_COLOR 1
#define BLUE_COLOR 2

@interface BlockView : UIView

@property int color;

- (id)initWithFrame:(CGRect)frame color:(int)inputColor;


@end
