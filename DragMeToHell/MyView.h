//
//  MyView.h
//  DragMeToHell
//
//  Created by Robert Irwin on 2/18/12.
//  Copyright (c) 2012 Robert J. Irwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView

@property (nonatomic, assign) CGFloat dw, dh;  // width and height of cell
@property (nonatomic, assign) CGFloat x, y;    // touch point coordinates
@property (nonatomic, assign) int row, col;    // selected cell in cell grid
@property (nonatomic, assign) BOOL inMotion;   // YES iff in process of dragging
@property (nonatomic, strong) NSString *s;     // item to drag around grid

@end
