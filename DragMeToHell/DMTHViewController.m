//
//  DMTHViewController.m
//  DragMeToHell
//
//  Created by Robert Irwin on 2/18/12.
//  Copyright (c) 2012 Robert J. Irwin. All rights reserved.
//

#import "DMTHViewController.h"

@implementation DMTHViewController

- (void)viewDidLoad
{
    NSLog( @"viewDidLoad" );
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor cyanColor]];
    
  /*  int count = 0;
    while (count < 30)
    {
        //Random Image selection
        int r = arc4random_uniform(9);
        int c = arc4random_uniform(9);
        
        if ( r == 0 && c == 0) continue;
        
        x = (w/10.0f)*r;
        y = (h/10.0f)*c;
        
        img = [UIImage imageNamed:@"Matryoshka01"];
        CGRect imageRect = CGRectMake(x, y, dw, dh);
        [img drawInRect:imageRect];
        count++;
    }*/

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
