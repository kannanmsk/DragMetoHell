//
//  MyView.m
//  DragMeToHell
//
//  Created by Robert Irwin on 2/18/12.
//  Copyright (c) 2012 Robert J. Irwin. All rights reserved.
//

#import "MyView.h"
#include "stdlib.h"
#include <math.h>

@implementation MyView

static BOOL flag = NO;
static int rowSet[25] ;
static int colSet[25] ;
int newX=0,newY=0;

@synthesize dw, dh, row, col, x, y, inMotion, s;

- (id)initWithFrame:(CGRect)frame {
    NSLog( @"initWithFrame:" );
    return self = [super initWithFrame:frame];
}

- (void)drawRect:(CGRect)rect 
{
    
    NSLog( @"drawRect:" );
    
    CGContextRef context = UIGraphicsGetCurrentContext();  // obtain graphics context
    //CGContextScaleCTM( context, 0.5, 0.5 );  // shrink into upper left quadrant
    CGRect bounds = [self bounds];          // get view's location and size
    CGFloat w = CGRectGetWidth( bounds );   // w = width of view (in points)
    CGFloat h = CGRectGetHeight ( bounds ); // h = height of view (in points)
    dw = w/10.0f;                           // dw = width of cell (in points)
    dh = h/10.0f;                           // dh = height of cell (in points)
    
    NSLog( @"view (width,height) = (%g,%g)", w, h );
    NSLog( @"cell (width,height) = (%g,%g)", dw, dh );   
    
    // draw lines to form a 10x10 cell grid
    CGContextBeginPath( context );               // begin collecting drawing operations
    for ( int i = 1;  i < 10;  ++i ) 
    {
        // draw horizontal grid line
        CGContextMoveToPoint( context, 0, i*dh );
        CGContextAddLineToPoint( context, w, i*dh );
    }
    for ( int i = 1;  i < 10;  ++i ) 
    {
        // draw vertical grid line
        CGContextMoveToPoint( context, i*dw, 0 );
        CGContextAddLineToPoint( context, i*dw, h );
    }
    [[UIColor grayColor] setStroke];             // use gray as stroke color
    CGContextDrawPath( context, kCGPathStroke ); // execute collected drawing ops
    
    // establish bounding box for image
    CGPoint tl = self.inMotion ? CGPointMake( x, y )     
                               : CGPointMake( row*dw, col*dh );
    CGRect imageRect = CGRectMake(tl.x, tl.y, dw, dh);

    // place appropriate image where dragging stopped
    UIImage *img;
    if ( self.row == 9  &&  self.col == 9 )
    {
        img = [UIImage imageNamed:@"devil1"];
    }
    else
    {
        img = [UIImage imageNamed:@"angel1"];
    }
    
    [img drawInRect:imageRect];
    
    if (flag == NO){
        
        for (int i=0;i<25;i++)
        {
            rowSet[i]=0;
            colSet[i]=0;
        }
    
        for(int k=0;k<25;k++)
        {
            //Random Number Generator
            int r = arc4random_uniform(9);
            int c = arc4random_uniform(9);
        
            if ( r == 0 && c == 0) continue;
        
            x = (w/10.0f)*r;
            y = (h/10.0f)*c;
        
            rowSet[k] = x;
            colSet[k] = y;
        
            img = [UIImage imageNamed:@"Matryoshka01"];

            CGRect imageRect = CGRectMake(x, y, dw, dh);
            [img drawInRect:imageRect];
        }
    
        flag = YES;
    
        for(int i=0;i<25;i++)
        {
            NSLog(@"%d %d",rowSet[i],colSet[i]);
        }
    }

    else
    {
        for (int i= 0 ;i < 25;i++)
        {
            //x = (w/10.0f)* (int)[rowSet objectAtIndex:i];
            //y = (h/10.0f)* (int)[colSet objectAtIndex:i];
            
            x = rowSet[i];
            y = colSet[i];
            int x1=0, y1 =0;
            x1 = ceil(x/dw);
            y1 = ceil(y/dh);
            NSLog(@"x %d,y %d",x1,y1);
            
            img = [UIImage imageNamed:@"Matryoshka01"];
            CGRect imageRect = CGRectMake(x, y, dw, dh);
            [img drawInRect:imageRect];
        }
        
        if (newX != 0 || newY != 0)
        {
            img = [UIImage imageNamed:@"devil"];
            CGRect imageRect = CGRectMake(newX, newY, dw+dw, dh+dh);
            [img drawInRect:imageRect];
        }
    }
}

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    int touchRow, touchCol;
    CGPoint xy;
    
    NSLog( @"touchesBegan:withEvent:" );
    [super touchesBegan: touches withEvent: event];
    for ( id t in touches )
    {
        xy = [t locationInView: self];
        self.x = xy.x;  self.y = xy.y;
        touchRow = self.x / self.dw;  touchCol = self.y / self.dh;
        self.inMotion = (self.row == touchRow  &&  self.col == touchCol);
        NSLog( @"touch point (x,y) = (%g,%g)", self.x, self.y );
        NSLog( @"  falls in cell (row,col) = (%d,%d)", touchRow, touchCol );
    }
}


-(void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
{    
    int touchRow, touchCol;
    CGPoint xy;

    NSLog( @"touchesMoved:withEvent:" );
    [super touchesMoved: touches withEvent: event];
    
    for ( id t in touches )
    {
        xy = [t locationInView: self];
        self.x = xy.x;  self.y = xy.y;
        touchRow = self.x / self.dw;  touchCol = self.y / self.dh;
        NSLog( @"touch point (x,y) = (%g,%g)", self.x, self.y );
        NSLog( @"  falls in cell (row,col) = (%d,%d)", touchRow, touchCol );
    }
    if ( self.inMotion )
        [self setNeedsDisplay];            
}


-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    newX = 0;
    newY = 0;
    NSLog( @"touchesEnded:withEvent:" );
    [super touchesEnded: touches withEvent: event];
    if ( self.inMotion )
    {
        int touchRow = 0, touchCol = 0;
        CGPoint xy ;
        
        for ( id t in touches )
        {
            xy = [t locationInView: self];
            self.x = xy.x;  self.y = xy.y;
            touchRow = self.x / self.dw;  touchCol = self.y / self.dh;
            NSLog( @"touch point (x,y) = (%g,%g)", x, y );
            NSLog( @"  falls in cell (row,col) = (%d,%d)", touchRow, touchCol );
        }
        
        self.inMotion = NO;
        self.row = touchRow;  self.col = touchCol;
        if ( self.row == 9  &&  self.col == 9 )
        {
            [self setBackgroundColor: [UIColor redColor]];
            NSLog( @"one");
        }
        else
        {
            [self setBackgroundColor: [UIColor cyanColor]];
            NSLog( @"two");
        }
        
        
        
        for (int i = 0; i < 25; i++)
        {
            x = rowSet[i];
            y = colSet[i];
            int x1=0, y1 =0;
            x1 = ceil(x/dw);
            y1 = ceil(y/dh);
            NSLog(@"xnew %d,ynew %d",x1,y1);
            if (x1 == touchRow && y1 == touchCol)
            {
                NSLog( @"TRUE");
                newX = x;
                newY = y;
                break;
                //[self setNeedsDisplay];
            }
            
        }
        [self setNeedsDisplay];
    }
}


-(void) touchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog( @"touchesCancelled:withEvent:" );
    [super touchesCancelled: touches withEvent: event];    
}

@end
